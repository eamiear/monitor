<template>
    <div class="detail-wrap">
      <div class="nav">
        <v-nav :path="path" :title="title">
          <div class="uil-ellipsis-css" slot="status">
            <div class="ib" :class="{active: app['status']}">
              <div class="circle"><div></div></div>
              <div class="circle"><div></div></div>
              <div class="circle"><div></div></div>
            </div>
          </div>
          <div class="pull-right">
            <span class="icon icon-play" title="启动" @click="start"></span>
            <span class="icon icon-stop" title="停止" @click="stop"></span>
          </div>
        </v-nav>
      </div>

      <tabs class="tabs" v-model="activeTab">
        <tab-pane label="运行" name="HomeTab" class="tab-content">
          <div class="home-content">
            <div class="command">
            <pre id="log">
              <p v-for="(item,index) in logger">{{item}}</p>
            </pre>
            </div>
            <div class="settings panel">
              <div class="panel-title">配置</div>
              <div class="panel-body">
                <mu-flexbox class="mt8" orient="vertical">
                  <mu-flexbox-item order="0" class="flex-item">
                    <mu-switch label="自启动" labelClass="label-class" labelLeft  @change="autostart" :value="autostartVal"/>
                  </mu-flexbox-item>

                  <mu-flexbox-item order="2" class="flex-item">
                    <span class="port">端&nbsp;口</span>
                    <div class="el-input-number">
                      <div class="el-input">
                        <input type="text" class="el-input__inner" v-model="port">
                      </div>
                      <span class="el-input-number__decrease icon icon-minus" @click="decrease"></span>
                      <span class="el-input-number__increase icon icon-plus" @click="increase"></span>
                    </div>
                  </mu-flexbox-item>
                </mu-flexbox>
              </div>

              <div class="panel-title">日志</div>
              <div class="panel-body">
                <mu-flexbox class="mt8" orient="vertical">
                  <mu-flexbox-item order="0" class="flex-item">
                    <mu-flat-button icon="info" label="打开日志目录" backgroundColor="#a4c639" color="#FFF" @click="openLog(false)"/>
                  </mu-flexbox-item>
                  <mu-flexbox-item order="0" class="flex-item">
                    <mu-flat-button icon="info" label="打开当前日志" backgroundColor="#a4c639" color="#FFF" @click="openLog(true)"/>
                  </mu-flexbox-item>
                </mu-flexbox>
              </div>
            </div>
          </div>
        </tab-pane >
        <tab-pane label="详情" name="DetailTab" class="sys-detail">
          <v-sysinfo :health="health" :memory="memory" :gcs="gcs" :datascources="datascources"></v-sysinfo>
        </tab-pane>
      </tabs>
    </div>
</template>

<style lang="less">
  .detail-wrap{
    background: #fff;
    height: 96%;
    .nav{
      padding: 5px 10px;
      border: 1px solid #eee;
      .icon{
        font-size: 20px;
        cursor: pointer;
      }
      .icon + .icon{
        margin-left: 10px;
      }
      span.icon {
        border: 1px solid transparent;
        border-radius: 50%;
        background: -webkit-gradient(linear,3% 0%, 100% 100%, from(#D4D4D4), to(#DEDEDE), color-stop(1.0,#D9D6C7),color-stop(0.5,#C3C4C2));
        display: inline-block;
        width: 28px;
        height: 28px;
        text-align: center;
        vertical-align: middle;
        line-height: 28px;
        font-size: 18px;
        transition: all .45s cubic-bezier(.445,.05,.55,.95);
      }

      span.icon:hover{
        background: -webkit-gradient(linear,3% 0%, 100% 100%, from(#E6E6E6), to(#EDEDED), color-stop(1.0,#FAF6E5),color-stop(0.5,#D8D9D7));
      }
      .icon-stop{
        color: #f12c2c;
        &:hover{
          color: rgba(173, 83, 83, 0.78);
        }
      }
      .icon-play{
        color: #2f14ff;
        padding-left: 3px;
        &:hover{
         color: rgba(44, 128, 191, 0.64);
        }
      }
    }
  }
  .tabs{
    justify-content: flex-start;
    width:100%;

    .el-tabs__header{
      display: flex;
      flex-flow: row wrap;
      justify-content: center;
      align-items: center;
      margin-bottom: 0;
    }
    .el-tabs__item{
      display: flex;
      flex: auto;
      align-self: center;
      flex-flow: row wrap;
      justify-content: center;
    }
    .el-tab-pane__content{
      height: 100%;
    }

    .sys-detail{
      overflow: auto;
    }
    .sys-detail .panel-group{
      padding:8px 10px 0;
    }
  }

  .home-content,
  .setting-content{
    display: flex;
    flex-flow: row wrap;
    justify-content: center;
    align-items: stretch;

    padding: 10px;
    height: 100%;
  }
  .setting-content{
    overflow: auto;
  }
  .home-content{
    .command,
    .settings{
      align-self:stretch;
      flex: auto;
      border-radius: 4px;
      box-shadow: 0 1px 2px 2px rgba(239, 238, 238, 0.75)
    }
    .command{
      flex: 10 0;
      font-size: 13px;
      background: rgba(0,0,0,.65);
      color: rgba(253, 248, 248, 0.78);
      margin-right: 15px;
      padding: 5px 10px;

      overflow: hidden;

      pre{
        height: 100%;
        margin-right: -30px;
        padding-left: 5px;
      }
      pre p{
        margin: 0;
        padding: 0;
        height: auto;
      }
    }
    .settings{
      .label-class{
         padding: 5px;
         margin-right: 10px;
      }
    }
  }
  .panel-group{
    display: flex;
    flex-flow: row wrap;
    justify-content: space-between;
    align-items: stretch;
    width: 100%;

    .panel{
      min-height: 160px;
      width: 49%;
      margin-bottom: 10px;
    }
  }
  .panel{
    border-radius: 4px;
    box-shadow: 0 1px 2px 2px rgba(239, 238, 238, 0.75);
    background: #fff;

    .panel-title{
       padding: 5px 10px;
       font-size: 14px;
       color: #555;
       font-weight: 600;
       background: #eee;
    }
    .panel-body{
      padding: 10px;
    }

    .panel-title ~ .panel-title{
      margin-top: 40px;
      border-radius: 4px 4px 0 0;
    }
  }
  .port{
     display: inline-block;
     width: 50px;
  }
  .flex-item{
    padding: 5px 10px;
    display: flex;
    flex-direction: row;
    align-items: center;
  }
  .el-input-number {
    display: inline-block;
    overflow: hidden;
    width: 180px;
    position: relative;
  }
  .el-input {
    position: relative;
    font-size: 14px;
  }
  .el-input-number .el-input__inner {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    padding-right: 82px;
  }
  .el-input__inner {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    background-color: #fff;
    background-image: none;
    border-radius: 4px;
    border: 1px solid #c0ccda;
    box-sizing: border-box;
    color: #1f2d3d;
    display: block;
    font-size: inherit;
    height: 36px;
    line-height: normal;
    outline: none;
    padding: 3px 10px;
    transition: border-color .2s cubic-bezier(.645,.045,.355,1);
    width: 100%;
  }
  .el-input-number__decrease {
    right: 37px;
  }
  .el-input-number__increase {
    right: 0;
  }
  .el-input-number__decrease, .el-input-number__increase {
    height: auto;
    border-left: 1px solid #c0ccda;
    width: 36px;
    line-height: 34px;
    top: 1px;
    text-align: center;
    color: #99a9bf;
    cursor: pointer;
    position: absolute;
  }
.nav{
  .uil-ellipsis-css {
    display: inline-block;
    padding-left: 10px;
    top: inherit;
    right: inherit;
    position: relative;
  }
  .uil-ellipsis-css .ib {
    width: 100%;
  }
  .uil-ellipsis-css .circle {
    width: 5px;
    height: 5px;
    text-align: center;
    display: inline-block;

  }
  .uil-ellipsis-css .circle > div {
    width: 5px;
    height: 5px;
    border-radius: 50%;
    margin: 0;
  }
  .uil-ellipsis-css .circle:nth-of-type(2n+1) > div {
    background: #403d3d;
  }
  .uil-ellipsis-css .circle:nth-of-type(2n) > div {
    background: #808a80;
  }

  .uil-ellipsis-css .active .circle,
  .uil-ellipsis-css .active .circle > div{
    border-radius: 50%;
    -webkit-animation:ripple 2s 0s ease-in-out infinite alternate;
    animation:ripple 2s 0s ease-in-out infinite alternate;
  }
}

@keyframes ripple {
  0% {
    background: #27ab62;
  }
  100% {
    background: green;
    box-shadow: 0 0 30px 2px rgba(53, 218, 53, 0.5);
  }
}
</style>

<script>
  import Vue from 'vue'
  import VueResource from'vue-resource';
  Vue.use(VueResource);

  import VNav from '../components/Nav'
  import VSysinfo from './Sysinfo'

  import {schemaBuilder} from '../store/db'
  import {Spawns} from '../store/spawns'
  import { dbApi } from '../scripts/dbService'
  import { startApp, openLogFile,readLogFile } from '../scripts/operation'

  import { Notification,MessageBox,Message } from 'element-ui'
  import { Tabs,TabPane } from 'element-ui'

  const process = require('process');


  export default{
    data(){
      return{
        activeTab: 'HomeTab',
        path: '/home',
        port: 8080,
        app: {},
        //title: '',
        appId: 0,
        logger: [],
        health: {},
        memory:{},
        gcs:[],
        datascources:[],
        statusName: '',
        killed: false
      }
    },
    beforeMount:function() {
      this.appId = this.$route.params.id;
    },
    computed: {
      autostartVal(){
        return this.app ? !!this.app.autostart : false;
      },
      title(){
        return this.app ? this.app.name : '';
      }
    },
    mounted(){
      const self = this;

      this.initLayout();
      window.onresize = this.initLayout;

      if(!window.bootDb){
         schemaBuilder.connect().then((db) => {
           window.bootDb = db;
           window.appTable = db.getSchema().table('boot_apps');
           return bootDb.select().from(appTable).where(appTable.id.eq(self.appId)).exec()
         }).then((app) => {
           self.app = app[0];
           self.port = self.app.port;
           self.initLogger(app[0],self);
         })
      }else{
         bootDb.select().from(appTable).where(appTable.id.eq(self.appId)).exec().then((app) => {
           self.app = app[0];
           self.port = self.app.port;
           self.initLogger(app[0],self);
         });
      }
    },
    watch: {
      '$route': 'fetchData',
      // watch port
      'port' (value,oldValue) {
         const isvalid = /^[0-9]*$/.test(value);
         if(!isvalid){
           Message.warning({message: '端口只能是数字',duration: 1500});
           this.port = oldValue;
         }else{
           this.port = value;
           this.app.port = this.port;
           dbApi.update(this.app);
         }
         //this.port = !isvalid ? oldValue : value;
         //this.app.port = this.port;
         //dbApi.update(this.app);
      },

      // watch status
      'app.status' (status){
         status && this.initLogger(this.app,this);
         status && this.initHealth();
      },
      'statusName' (statusName){
         console.log('statusName',statusName)
         console.log('status',this.app.status)
         switch(statusName){
          case '启动失败':
            console.log('启动失败',this.app.pid,this.app.id)
            Message.error({message: '启动失败...',duration: 1500});
            break;
          case '启动完成':
            console.log('starting... ')
            this.app.status && this.initHealth();
            Message.success({message: '启动完成',duration: 2000});
            break;

          case '端口冲突':
            console.log('端口冲突',this.app.pid,this.app.id)
            Message.error({message: '端口冲突',duration: 1500});
            break;

          case '运行存在错误':
            console.log('运行存在错误',this.app.pid,this.app.id)
            Message.error({message: '检测到程序存在错误',duration: 1500});
            break;

          case '连接超时':
          case '拒接连接':
          case '程序终止':
            console.log('程序终止',this.app.pid,this.app.id)
            this.killed = true;
            Message.error({message: statusName,duration: 1500});

            break;
         }
         dbApi.update(this.app);
      },
      'killed' (killed){
         if(this.killed){
           console.log('killing...')
           let portSpawn = new Spawns().get(this.app.id);
           let spawn = ( portSpawn && portSpawn.spawn );
           let pid = this.app.pid;

           try{
             (spawn && pid ) && spawn.kill();
           }catch(err){
             console.log('error when killing pid ' + err);
             pid && process.kill(pid);
           }
           console.log('killed')
           this.killed = false;
         }
      },

      'activeTab' (val){
         if(val == "DetailTab"){
         }else{

         }
      },
      'logger' (){
        try{
          const log = document.querySelector('#log');
          log.scrollTop = log.scrollHeight;
        }catch(err){
          console.log('logging error: ' + err)
        }
      }
    },
    filters: {
      number(value,oldValue) {

      },
      statusName(status){
         switch(status){
           case "UP": return "已启动"
           case "OFFLINE": return "离线"
           case "DOWN": return "已关闭"
           case "OUT_OF_SERVICE": return "停止服务"
           default: return "未知"
         }
      },
      memoryFormat(m){
         const M = 1024;
         const G = M * 2;
         return m ? m > G ? (m / G).toFixed(1) + " G" : (m / M).toFixed(1) + " M" : "0 M";
      },
      codeName(code){
         switch(code){
           case "diskSpace": return "磁盘空间"
           case "db": return "数据库"
           default: return code
         }
      }
    },
    methods: {
      // init layout
      initLayout(){
        let content = document.querySelector('.el-tabs__content');
        let homeTab = document.querySelector('.tab-content > div');
        let sysDetail = document.querySelector('.sys-detail');
        //let content = document.querySelector('.tab-content');
        let navHeight = document.querySelector('.nav').clientHeight;
        let tabHeight = document.querySelector('.el-tabs__header').clientHeight;
        //let tabHeight = document.querySelector('.mu-tabs').clientHeight;

        const gap = (this.$el.clientHeight - navHeight - (tabHeight||42) - 8) + 'px';
        content.style.height = gap;
        homeTab.style.height = gap;
        sysDetail.style.height = gap;
      },

      // init logger on panel
      initLogger(app,self){
        let hasData = '';

        if(app && app['id']){
          const spawns = new Spawns();
          const s = spawns.get(this.app.id);
          if(!s) return;
          const spawn = s.spawn;
          spawn.stdout.on('data', (data) => {
            self.logger.push(`${data}`)

            console.log('running.....')
            const d = data+'';
            hasData = d;
            if(d.indexOf('APPLICATION FAILED TO START')!= -1){
              app.status = 0;
              app.statusName = "启动失败";
              self.statusName =  "启动失败";
            }
            if(d.indexOf('The port may already be in use') != -1){
              app.status = 0;
              app.statusName = "端口冲突";
              self.statusName =  "端口冲突";
            }
            if(d.indexOf('connect timed out') != -1){
              app.status = 0;
              app.statusName = "连接超时";
              self.statusName =  "连接超时";
            }
            if(d.indexOf('Connection refused') != -1){
              app.status = 0;
              self.statusName = " ";
              app.statusName = "拒绝连接";
              self.statusName = "拒绝连接";
              console.log(self.statusName)
            }

            if(d.indexOf('shutdown') != -1 || d.indexOf('Stopping service Tomcat') != -1){
              app.status = 0;
              app.statusName = "程序终止";
              self.statusName =  "程序终止";
            }
            if(d.indexOf('Started LandlordserviceApplication in') != -1 || d.indexOf('Tomcat started on port') != -1){
              !app.status && (app.status = 1);
              app.statusName = "启动完成";
              self.statusName =  "启动完成";
            }
          });

          spawn.stderr.on('data', (data) => {
             console.log('err running....')
             app.status = 0;
             app.statusName = "运行存在错误";
             self.statusName =  "运行存在错误";
          });

          if(!hasData && app.logpath){
            let log = '';
            try{
              log = readLogFile(app.logpath);
            }catch(err){
              console.log('read log file err',err)
            }
             self.logger.push(log);
          }
        }
      },

      // open log file
      openLog(type){
        openLogFile(type,this.app,() => {
          Message.warning({message: '无日志',duration: 1500})
        })
      },
      // tab toggle
      handleTabChange (val) {
        this.activeTab = val
      },
      handleActive () {
        //window.alert('tab active')
      },

      // toggle auto start
      autostart(val){
        if(this.app && this.app.status){
         this.app.autostart = val;
         dbApi.update(this.app);
        }
      },
      // increase port
      increase() {
        if(this.app && this.app.status){
          Message.warning({message: 'APP 正在运行',duration: 1500})
        }else{
          this.app.port = this.port++;
          //dbApi.update(this.app);
        }
      },

      // decrease port
      decrease() {
        if(this.app && this.app.status){
          Message.warning({message: 'APP 正在运行',duration: 1500})
        }else{
          this.app.port = this.port--;
          //dbApi.update(this.app);
        }
      },

      // start app if it has not started
      start(){
        if(this.app && !this.app.status){
           Message.success({message: '程序即将启动...',duration: 1500})
           this.app.status = 1;
           // clear logs
           this.logger = [];

           startApp(this.app)
           // update db
           dbApi.update(this.app);

           this.app.statusName = "启动中";
           self.statusName =  "启动中";
        }else{
          Message.warning({ message: 'APP 正在运行',duration: 1500})
        }
      },

      // stop app
      stop(){
        if(this.app && this.app.status && this.app.pid){
          try{
            process.kill(this.app.pid);
            this.app.statusName = "未启用";
            self.statusName =  "未启用";
            Message.success({message: 'APP 已停止',duration: 1500});
          }catch(e){
            Message.error({message: '停止出现问题,可能杀掉一个不存在的进程',duration: 1500});
          }
          this.app.status = 0;
          this.app.pid = 0;

          // remove from window.spawns
          const spawns = new Spawns();
          spawns.remove(this.app.id);

          // update db
          dbApi.update(this.app);
        }else{
          Message.info({message: 'APP 未启动',duration: 1500})
        }
      },
      // initialize program's executed message
      initHealth(){
        let interval;
        const self = this;
        this.$http.get('http://localhost:' + this.port+ '/health').then((response) =>{
           self.health = response.data;
           interval && clearInterval(interval);
           if(response.data["status"]=="UP"){
             interval = setInterval(() => {

               dbApi.getById(self.app.id).then((result) => {
                 const a = result[0];
                 if(!a.status ){
                   interval && clearInterval(interval);
                   return;
                 }
                 self.loadMetrics();
               });
               //if(!self.app.status ){
               //  interval && clearInterval(interval);
                // return;
               //}
               //self.loadMetrics();
             },2000)
           }
        }).catch(function(response) {
           interval && clearInterval(interval);
			  })
      },
      // load os message  from spring boot
      loadMetrics(){
        const self = this;
        this.$http.get('http://localhost:' + this.port + '/metrics').then((response) => {
					self.memory = response.data;
          self.gcs = [];
          self.datascources = [];

          Array.prototype.forEach.call(self.memory,(item,key) => {
            const gcmatch = /gc\.(.+)\.time/.exec(key);
            if (gcmatch) {
              const gcsItem = {
                name: gcmatch[1],
                time: gcmatch + ' ms',
                count: self.memory['gc.' + gcmatch[1] + '.count']
              };
              self.gcs.push(gcsItem);
              //continue;
            }

            let datamatch = /datasource\.(.+)\.active/.exec(key);
            if(datamatch){
              const dataItem = {
                name: datamatch[1],
                active: item,
                usage: (self.memory['datasource.' + datamatch[1] + '.usage'] * 100).toFixed(2)
              };
              self.datascources.push(dataItem);
            }
          })

				}).catch(function(response) {
           self.memory = {};
           self.gcs = [];
           self.datascources = [];
				})
      }
    },
    components:{
      VNav,
      VSysinfo,
      Tabs,TabPane
    },
    beforeDestroy(){
      let self = this
      setTimeout(() => {
        self.$el.remove()
      },100)
    }
  }
</script>

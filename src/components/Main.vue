<template>
    <div class="content">
      <v-plus @click="selectFile()"></v-plus>

      <div class="swiper-container">
        <div class="swiper-wrapper">
          <div class="swiper-slide" v-for="(item,index) in apps">

            <router-link class="slide" :to="{ name: 'detail', params: { id: item.id }}">
              <div class="uil-ellipsis-css">
                <div class="ib" :class="{active: item.status,running: item.hasRunning}" :title="item.statusName">
                  <div class="circle"><div></div></div>
                  <div class="circle"><div></div></div>
                  <div class="circle"><div></div></div>
                </div>
              </div>
              <div class="card" :style="{ background: item.color}">
                {{item.name}}
              </div>
              <div class="action" @click.stop.prevent="">
                <mu-icon-button icon="play_arrow" iconClass="play" @click.stop.prevent="start(index,item.id)"/>
                <mu-icon-button icon="stop" iconClass="stop" @click.stop.prevent="stop(index,item.id)"/>
                <mu-icon-button icon="delete" iconClass="delete" @click.stop.prevent="remove(index,item.id)"/>
              </div>
            </router-link>
          </div>
        </div>
        <!--<div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>-->
        <div class="swiper-scrollbar"></div>
      </div>
    </div>
</template>

<style>
  .content{
    position: relative;
    height: 94%;
    padding: 2% 20px;
  }
  .card,
  .action{
    display: flex;
    align-items: center;
    justify-content: center;
  }
  .swiper-slide{
    display: flex;
    justify-content: space-around;
    align-items: center;
  }
  .swiper-container {
    height: auto!important;
    margin-left: auto;
    margin-right: auto;
    top: 50%;
    transform: translateY(-50%);

    overflow: hidden;
    padding: 12px 0;

    .swiper-slide {
      height: 200px;
    }
  }

  .slide{
    position: relative;
    width: 100%;
    height: 100%;
    color: #333;
    border-radius: 50px;
    -webkit-user-drag: none;
    -webkit-user-select: none;
    flex: auto;

    box-shadow: 2px 3px 12px 0px rgba(20, 85, 134, 0.79);

    .appStatus{
      position: absolute;
      top: -20px;
      right: 15px;
    }

    .action{
      position: absolute;
      left: 0;
      right: 0;
      opacity: 0;
      justify-content: space-between;
      align-items: flex-end;

      bottom: -5px;
      transition: all .45s cubic-bezier(.445,.05,.55,.95);;
      border-radius: 0 0 18px 18px;
    }
    &:hover{
      .action{
         bottom: 0;
         opacity: 1;
      }
      .card{
        font-size: 20px;
        padding-bottom: 45px;
      }
    }
  }
  .card{
    font-size: 16px;
    font-weight: bold;

    color: rgba(241, 239, 239, 0.89);
    text-shadow: 0px 4px 12px rgba(88, 83, 83, 0.75);
    margin: 0;
    height: 100%;
    width: 100%;

    border-radius: 18px;

    cursor: pointer;
    transition: all .4s cubic-bezier(.445,.05,.55,.95);
  }
  .action{
    height: 60px;
    width: 100%;
    background: rgba(19, 16, 16, 0.37);
    box-shadow: 0px 0px 12px 0px rgba(185, 176, 176, 0.48);

    &,.mu-icon-button{
      cursor: default;
    }
    .mu-icon-button,
    .mu-icon,.icon{
      transition: all .4s cubic-bezier(.445,.05,.55,.95);
    }
    .mu-icon,.icon{
      color: rgba(208, 200, 200, 0.84);
      -webkit-user-drag: none;
      -webkit-user-select: none;
    }
    .mu-icon-button:hover{
      background: rgba(241, 239, 239, 0.07);
      .mu-icon,.icon{
        color: rgba(251, 249, 249, 0.73);
      }
    }
  }

.uil-ellipsis-css {
  background: none;
  position: absolute;
  top: -16px;
  right: 10px;
}
.uil-ellipsis-css .ib {
  width: 100%;
  height: 100%;
}
.uil-ellipsis-css .circle {
  width: 8px;
  height: 8px;
  text-align: center;
  display: inline-block;

}
.uil-ellipsis-css .circle > div {
  width: 8px;
  height: 8px;
  border-radius: 30px;
  margin: 0;
}
.uil-ellipsis-css .circle:nth-of-type(2n+1) > div {
  background: #403d3d;
}
.uil-ellipsis-css .circle:nth-of-type(2n) > div {
  background: #808a80;
}

.uil-ellipsis-css .active .circle,
.uil-ellipsis-css .active .circle > div,
.uil-ellipsis-css .active.running .circle,
.uil-ellipsis-css .active.running .circle > div{
	border-radius: 30px;
	-webkit-animation:ripple 2s 0s ease-in-out infinite alternate;
	animation:ripple 2s 0s ease-in-out infinite alternate;
}
.uil-ellipsis-css .running .circle,
.uil-ellipsis-css .running .circle > div{
  border-radius: 30px;
	-webkit-animation:ripple1 2s 0s ease-in-out infinite alternate;
	animation:ripple1 2s 0s ease-in-out infinite alternate;
}

@keyframes ripple {
   0% {
    background: #27ab62;
  }
  100% {
     background: green;
     box-shadow: 0px 0px 30px 2px rgba(53, 218, 53, 0.5);
  }
}

@keyframes ripple1 {
   0% {
    background: #27ab62;
  }
  100% {
     background: red;
     box-shadow: 0px 0px 30px 2px rgba(53, 218, 53, 0.5);
  }
}

</style>

<script>
    import Vue from 'vue'
    import VPlus from './Plus.vue'

    import Swiper from '../assets/js/swiper-3.4.0.min.js'
    import '../assets/css/swiper-3.4.0.min.css'
    import { Notification,MessageBox,Message } from 'element-ui';

    const {dialog} = require('electron').remote;
    const spawn  = require("child_process").spawn ;
    const process = require('process');
    const path = require('path');

    import { jarFileImport,handleDragOver,startApp } from '../scripts/operation'
    import {schemaBuilder} from '../store/db'
    import { dbApi } from '../scripts/dbService'
    import {Boot} from '../store/boot'
    import {Spawns} from '../store/spawns'

    export default{
      name: 'main',
      data() {
        return {
          swiperOption: {
            slidesPerView: 3,
            slidesPerColumn: 2,
            spaceBetween: 30,
            nextButton: '.swiper-button-next',
            prevButton: '.swiper-button-prev',
            scrollbar:'.swiper-scrollbar',
            scrollbarDraggable : true ,
            scrollbarSnapOnRelease : true ,
            mousewheelControl: true,
            keyboardControl : true,
            centeredSlides: false,
            observer:true
          },
          apps: [],
          defaultPort: 8081,
          swiper: null,
          killed: false,
          statusName: '',
          hasRunning: false,
          app: {}
        }
      },
      computed: {
        currentPort(){
          return this.defaultPort++;
        }
      },
      watch: {
        'app.statusName' (statusName){
           console.log('PID: ',this.app.pid,this.app.name)
           console.log('-----------------------------------')
           console.log('statusName',statusName)
           console.log('status',this.app.status)
           switch(statusName){
            //case '启动失败':
            //  console.log(this.app.pid,': 启动失败',this.app.id)
            //  Message.error({message: '启动失败...',duration: 2000});
            //  break;
            case '启动完成':
              console.log(this.app.pid,'started ')
              this.hasRunning = false;
              this.app.hasRunning = false;
              const name = this.app.name.slice(0,this.app.name.length-4);
              Message.success({message: name + ' 启动完成',duration: 2000});
              break;

            case '端口冲突':
              console.log(this.app.pid,'端口冲突',this.app.port)
              Message.error({message: '端口冲突',duration: 2000});
              break;

            case '运行存在错误':
              console.log(this.app.pid,'运行存在错误',this.app.id)
              Message.error({message: '检测到程序存在错误',duration: 2000});
              break;

            case '连接超时':
            case '拒绝连接':
            case '启动失败':
            case '程序终止':
              console.log(this.app.pid,statusName,this.app.id)
              this.killed = true;
              Message.error({message: statusName,duration: 2000});
              break;
           }
           dbApi.update(this.app);
        },
        'killed' (killed){
           if(this.killed){
             let portSpawn = new Spawns().get(this.app.id);
             let spawn = ( portSpawn && portSpawn.spawn );
             let pid = this.app.pid;
             console.log(pid,'killing...')

             try{
               (spawn && pid ) && spawn.kill();
             }catch(err){
               console.log('error when killing pid ' + err);
               pid && process.kill(pid);
             }
             console.log(pid,'killed')
             this.killed = false;
             this.hasRunning = false;
             this.app.hasRunning = false;
           }
        }
      },
      beforeMount(){
        let self = this;
        if(!bootDb){
           schemaBuilder.connect().then((db) => {
             window.bootDb = db;
             window.appTable = db.getSchema().table('boot_apps');
             return db.select().from(appTable).exec();
           }).then((results) => {
              results.forEach((row) => {
                initApp(row);
              });
           })
        }else{
           bootDb.select().from(appTable).exec().then((results) => {
            results.forEach((row) => {
              initApp(row);
            });
          })
        }

        function initApp(row){
          const id = row['id'];
          const name = row['name'];
          const port = row['port'];
          const status = row['status'];
          const statusName = row['statusName'];
          const path = row['path'];
          const pid = row['pid'];
          const hasModifyPort = row['hasModifyPort'];
          const autostart = row['autostart'];
          const logpath = row['logpath'];
          const color = row['color'];

          let app = new Boot(id,name,port,status,statusName,path,pid,hasModifyPort,autostart,logpath,color);
          self.apps.push(app);
          autostart && startApp(app);
        }
      },
      mounted() {
        const self = this;
        this.swiper = new Swiper('.swiper-container', this.swiperOption);

        function handleFileSelect(evt) {
          evt.stopPropagation();
          evt.preventDefault();

          const files = evt.dataTransfer.files; // FileList object.
          if(!files) {
            Message.warning({title: '警告', message: '没有文件',duration: 1500});
            return;
          }
          if(files.length > 1) {
            Message.warning({title: '警告', message: '只能选择一个文件',duration: 1500});
            //files = [];
            return;
          }
          const jarName = files[0].name;
          const suffix = jarName.substring(jarName.lastIndexOf("."),jarName.length);
          if(suffix!=".jar"){
            Message.warning({title: '警告', message: '请导入Jar包文件',duration: 1500});
            return;
          }
          if(self.hasRepeatName(jarName)){
            Message.info({message: '已存在同名 jar 文件',duration: 1500});
            return;
          }

          console.log('drag jarFileImporting...')
          jarFileImport(files[0].path,jarName,self._createApp);
        }

        // Setup the dnd listeners.
        const app_list = document.querySelector('.container');
        //app_list.removeEventListener('drop', handleFileSelect);
        //app_list.removeEventListener('dragover', handleDragOver);

        //app_list.addEventListener('dragover', handleDragOver, false);
        //app_list.addEventListener('drop', handleFileSelect, false);
      },
      methods: {
        hasRepeatPort(app){
          return this.apps.some((item) => {
             return item.id !== app.id && item.port === app.port;
          })
        },
        hasRepeatName(appname){
           return this.apps.some((item) => {
             return item.name === appname;
          })
        },
        hasRepeatInDB(appname){
           return dbApi.getByName(appname);
        },
        randomColor() {
           let colors = ['#5fbf0b','#ffb718','#9b64ce','#4d9bff','#2075a5','#18a892','#7c5955','#ce09c9'];
           return colors[Math.floor(Math.random()*8)];
          // return '#' + Math.floor(Math.random()*16777215).toString(16);
        },
        // start action
        start(index,id){
           if(this.hasRunning) {
              Message.info({message: '有 App 在启动,请稍后...',duration: 1500});
              return;
           }
           this.hasRunning = true;

           const app = this.apps[index];
           const self = this;
           this.app = app;
           this.app.hasRunning = true;
           if(app.status === 1){
              Message.info({message: 'App 正在运行',duration: 1500});
              return;
           }

           Message.success({message: '程序即将启动...',duration: 2000})
           if(this.hasRepeatPort(app)){
             const ports = this.apps.map((item,index) => {
                return item.port;
             })
             this.defaultPort = Math.max.apply(null,ports);
             app.port = this.defaultPort + 1;
           }
           app.status = 1;
           startApp(app);

           // update db
           dbApi.update(this.app);

          const spawns = new Spawns();
          const s = spawns.get(this.app.id);
          if(!s) return;
          const spawn = s.spawn;
          spawn.stdout.on('data', (data) => {
            const d = data+'';
            console.log('running...')
            if(d.indexOf('APPLICATION FAILED TO START')!= -1){
              self.app.status = 0;
              self.app.statusName = "启动失败";
              console.log('启动失败')
            }
            if(d.indexOf('The port may already be in use') != -1){
              self.app.status = 0;
              self.app.statusName = "端口冲突";
              console.log('端口冲突')
            }
            if(d.indexOf('connect timed out') != -1){
              self.app.status = 0;
              self.app.statusName = "连接超时";
               console.log(self.app.name,'连接超时')
            }
            if(d.indexOf('Connection refused') != -1){
              self.app.status = 0;
              self.app.statusName = "拒绝连接";
              console.log(self.app.name,'拒绝连接')
            }

            if(d.indexOf('shutdown') != -1 || d.indexOf('Stopping service Tomcat') != -1){
              self.app.status = 0;
              self.app.statusName = "程序终止";
            }
            if(d.indexOf('Started LandlordserviceApplication in') != -1 || d.indexOf('Tomcat started on port') != -1){
              !app.status && (app.status = 1);
              app.statusName = "启动完成";
              self.statusName =  "启动完成";
            }
          });

          spawn.stderr.on('data', (data) => {
          const d = data+'';
            console.log('err running...')
            if(d.indexOf('APPLICATION FAILED TO START')!= -1){
              self.app.status = 0;
              self.app.statusName = "启动失败";
              console.log('启动失败')
            }else if(d.indexOf('The port may already be in use') != -1){
              self.app.status = 0;
              self.app.statusName = "端口冲突";
              console.log('端口冲突')
            }else if(d.indexOf('connect timed out') != -1){
              self.app.status = 0;
              self.app.statusName = "连接超时";
               console.log(self.app.name,'连接超时')
            }else if(d.indexOf('Connection refused') != -1){
              self.app.status = 0;
              self.app.statusName = "拒绝连接";
              console.log(self.app.name,'拒绝连接')
            }else if(d.indexOf('shutdown') != -1 || d.indexOf('Stopping service Tomcat') != -1){
              self.app.status = 0;
              self.app.statusName = "程序终止";
            }else{
              self.app.status = 0;
             self.app.statusName = "运行存在错误";
             console.log('运行存在错误')
            }

          });


           app.statusName = "启动中";
           this.statusName = "启动中";
        },

        // stop app if it has started
        stop(index,id){
          const app = this.apps[index];
          this.app = app;
          if(app.status && app.pid){
            try{
              process.kill(app.pid);
              app.statusName = "未启用";
              this.statusName =  "未启用";
              Message.success({message: 'APP 已停止',duration: 1500});
            }catch(e){
              Message.error({message: '停止出现问题,可能杀掉一个不存在的进程',duration: 1500});
            }

            app.pid = 0;
            app.status = 0;
             this.app.hasRunning = false;

            // remove from window.spawns
            const spawns = new Spawns();
            spawns.remove(app.id);

            // update db
            dbApi.update(app);
          }else{
            Message.info({message: 'App 未启动',duration: 1500})
          }
        },

        // remove
        remove(index,id){
          const self = this;
          const app = this.apps[index];
          MessageBox.confirm('确认删除 '+app.name+' ?', '提示', {
            type: 'warning'
          }).then(() => {
            Message.success({message: '移除成功',duration: 1500})
            self.doRemove(index,id);
          }).catch(() => {
            Message.info({message: '取消移除',duration: 1500})
          });
        },

        // handle remove
        doRemove(index,id){
          const app = this.apps[index];
          if(app.pid){
            try{
             process.kill(app.pid);
             app.pid = 0;
            }catch(e){}
          }
          this.apps.splice(index, 1);
          dbApi.remove(app);
        },
        // add app into db
        _createApp(jarName,filePath){
          console.log('created',jarName)
          const self = this;
          const boot = new Boot();
          boot.setName(jarName);
          boot.setPath(filePath);
          boot.setColor(self.randomColor());

          const item = boot.getDbRow();
          dbApi.create(item,(app) => {
             self.apps.push(app);
          });
        },
        // select jar file
        selectFile(){
          const self = this;
          //properties: ['openFile', 'multiSelections']
          dialog.showOpenDialog({ filters: [{name: 'Jar', extensions: ['jar']}]},function (files) {
            if(!files){
              //Message.info({message: '请选择 jar 文件'});
              return;
            }
            const jarName = path.basename(files[0]);
            if(self.hasRepeatName(jarName)){
              Message.info({message: '已存在同名 jar 文件',duration: 1500});
              return;
            }
             Message.success({message: '添加成功',duration: 1500});
            console.log('selected jarFileImporting...')
            jarFileImport(files[0],jarName,self._createApp);
          });
        }
      },
      components: {
        VPlus
      }
    }
</script>

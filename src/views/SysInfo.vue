<template>
  <div class="panel-group">
    <div class="panel">
      <div class="panel-title">运行情况</div>
      <div class="panel-body">
        <mu-flexbox class="mt8" orient="vertical">
          <mu-flexbox-item order="0" class="flex-item">
            <mu-list>
              <div v-for="(value, key, index) in health">
                <mu-list-item v-if="isChildHealth(value)" :title="key|codeName" :open="false" toggleNested :disableRipple=true>
                  <mu-list-item slot="nested" v-for="(val, k, index) in value" :title="k|codeName | capitalize">
                    <mu-badge v-if="typeof val === 'string'" style="width:auto" secondary slot="right" :content="val | statusName"></mu-badge>
                    <mu-badge v-else-if="typeof val === 'number'" secondary slot="right" :content="val | memoryFormat"></mu-badge>
                  </mu-list-item>
                </mu-list-item>
                <mu-list-item v-else-if="key != 'status'" :title="key|codeName | capitalize" :disableRipple=true>
                  <mu-badge v-if="typeof val === 'string'" style="width:auto" secondary slot="right" :content="value | statusName"></mu-badge>
                  <mu-badge v-else-if="typeof val === 'number'" secondary slot="right" :content="value | memoryFormat"></mu-badge>
                </mu-list-item>
              </div>
            </mu-list>
          </mu-flexbox-item>
        </mu-flexbox>
      </div>
    </div>

    <div class="panel">
      <div class="panel-title">内存</div>
      <div class="panel-body">
        <mu-flexbox class="mt8" orient="vertical">
          <mu-flexbox-item order="0" class="flex-item">
            <mu-list>
              <mu-list-item title="内存状态" :open="false" toggleNested :disableRipple=true>
                <mu-list-item slot="nested" title="内存" :afterText="this.memoryRate + '%'">
                    <span slot="describe">
                      <mu-linear-progress mode="determinate" :value="this.memoryRate|toNumber"/>
                    </span>
                </mu-list-item>
                <mu-list-item slot="nested" title="堆内存" :afterText="this.heapRate + '%'">
                    <span slot="describe">
                      <mu-linear-progress mode="determinate" :value="this.heapRate|toNumber"/>
                    </span>
                </mu-list-item>
                <mu-list-item slot="nested" title="非堆内存" :afterText="this.nonheapRate + '%'">
                    <span slot="describe">
                      <mu-linear-progress mode="determinate" :value="this.nonheapRate|toNumber"/>
                    </span>
                </mu-list-item>
              </mu-list-item>

              <mu-list-item title="内存" :open="false" toggleNested :disableRipple=true>
                <mu-list-item slot="nested" title="初始堆内存 (-Xmx)">
                  <mu-badge slot="right" secondary :content="memory['heap.init']|toNumber|memoryFormat"></mu-badge>
                </mu-list-item>

                <mu-list-item slot="nested" title="最大堆内存 (-Xmx)">
                  <mu-badge slot="right" secondary :content="memory['heap']|toNumber|memoryFormat"></mu-badge>
                </mu-list-item>

                <mu-list-item slot="nested" title="初始非堆内存">
                  <mu-badge slot="right" secondary :content="memory['nonheap.init']|toNumber|memoryFormat"></mu-badge>
                </mu-list-item>

                <mu-list-item slot="nested" title="最大非堆内存">
                  <mu-badge slot="right" secondary :content="memory['nonheap']|toNumber|memoryFormat"></mu-badge>
                </mu-list-item>

              </mu-list-item>
            </mu-list>
          </mu-flexbox-item>
        </mu-flexbox>
      </div>
    </div>

    <div class="panel">
      <div class="panel-title">JVM</div>
      <div class="panel-body">
        <mu-flexbox class="mt8" orient="vertical">
          <mu-flexbox-item order="0" class="flex-item">
            <mu-list>
              <mu-list-item title="执行状态" :open="false" toggleNested :disableRipple=true>
                <mu-list-item slot="nested" title="运行时间">
                  <mu-badge slot="right" secondary :content="this.executeTime"></mu-badge>
                </mu-list-item>
                <mu-list-item slot="nested" title="处理器数量">
                  <mu-badge slot="right" secondary :content="memory.processors|toString"></mu-badge>
                </mu-list-item>
              </mu-list-item>

              <mu-list-item title="类" :open="false" toggleNested :disableRipple=true>
                <mu-list-item slot="nested" title="总数">
                  <mu-badge slot="right" secondary :content="memory['classes']|toString"></mu-badge>
                </mu-list-item>
                <mu-list-item slot="nested" title="已加载">
                  <mu-badge slot="right" secondary :content="memory['classes.loaded']|toString"></mu-badge>
                </mu-list-item>
                <mu-list-item slot="nested" title="未加载">
                  <mu-badge slot="right" secondary :content="memory['classes.unloaded']|toString"></mu-badge>
                </mu-list-item>
              </mu-list-item>

              <mu-list-item title="线程" :open="false" toggleNested :disableRipple=true>
                <mu-list-item slot="nested" title="总数">
                  <mu-badge slot="right" secondary :content="memory['threads.totalStarted']|toString"></mu-badge>
                </mu-list-item>
                <mu-list-item slot="nested" title="当前运行">
                  <mu-badge slot="right" secondary :content="memory['threads']|toString"></mu-badge>
                </mu-list-item>
                <mu-list-item slot="nested" title="守护进程">
                  <mu-badge slot="right" secondary :content="memory['threads.daemon']|toString"></mu-badge>
                </mu-list-item>
                <mu-list-item slot="nested" title="峰值">
                  <mu-badge slot="right" secondary :content="memory['threads.peak']|toString"></mu-badge>
                </mu-list-item>
              </mu-list-item>

            </mu-list>
          </mu-flexbox-item>
        </mu-flexbox>
      </div>
    </div>

    <div class="panel">
      <div class="panel-title">数据源</div>
      <div class="panel-body">
        <mu-flexbox class="mt8" orient="vertical">
          <mu-flexbox-item order="0" class="flex-item">
            <mu-list v-for="(value, key, index) in datascources">
              <mu-list-item :title="value.name" :open="false" toggleNested :disableRipple=true>
                <mu-list-item slot="nested" title="连接数" afterText="20%">
                  <mu-linear-progress mode="determinate" :value="20"/>
                </mu-list-item>
              </mu-list-item>
            </mu-list>
          </mu-flexbox-item>
        </mu-flexbox>
      </div>
    </div>

    <div class="panel">
      <div class="panel-title">servlet</div>
      <div class="panel-body">
        <mu-flexbox class="mt8" orient="vertical">
          <mu-flexbox-item order="0" class="flex-item">
            <mu-list>
              <mu-list-item  title="Http Session">
                <mu-badge slot="right" secondary :content="memory['httpsessions.active']|toString"></mu-badge>
              </mu-list-item>
              <mu-list-item title="上限">
                <mu-badge slot="right" secondary :content="( (memory['httpsessions.max'] > -1) ? memory['httpsessions.max']|toString : '无限')"></mu-badge>
              </mu-list-item>
            </mu-list>
          </mu-flexbox-item>
        </mu-flexbox>
      </div>
    </div>

    <div class="panel">
      <div class="panel-title">垃圾回收</div>
      <div class="panel-body">
        <mu-flexbox class="mt8" orient="vertical">
          <mu-list>
            <mu-list-item v-for="(gc, key, index) in gcs" :title="gc.name" :open="false" toggleNested :disableRipple=true>
              <mu-list-item slot="nested" title="数量">
                <mu-badge slot="right" secondary :content="gc.count|toString"></mu-badge>
              </mu-list-item>
              <mu-list-item slot="nested" title="时间">
                <mu-badge slot="right" secondary :content="gc.time|dateFormat"></mu-badge>
              </mu-list-item>
            </mu-list-item>

          </mu-list>
        </mu-flexbox>
      </div>
    </div>
  </div>
</template>
<style>
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
    box-shadow: 0px 1px 2px 2px rgba(239, 238, 238, 0.75);
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
  }
  .mu-list .mu-list .mu-item {
    padding: 2px 16px;
   }
  .mu-item-left, .mu-item-right{
    width: auto !important;
  }
  .mu-item-title {
    font-size: 14px;
    font-family: "microsoft yahei";
  }
  .mu-item-after {
    font-size: 13px;
    font-weight: bold;
  }
  .mu-linear-progress {
    margin-top: 4px;
  }
</style>
<script>
    import Moment from 'moment'

    export default{
      props:{
        health: {
          type: Object,
          default:{}
        },
        memory:{
          type: Object,
          default:{}
        },
        gcs:{
          type: Array,
          default:[]
        },
        datascources:{
          type: Array,
          default:[]
        }
      },
      data(){
        return{
          memRate: 0,
          heapRate: 0,
          noheapRate: 0
        }
      },
      computed:{
        memoryRate(){
          const r = parseFloat(this.memory['mem.free'] / this.memory['mem'] * 100).toFixed(2);
          return isNaN(+r) ? 0 : r;
        },
        heapRate(){
          const r = parseFloat(this.memory['heap.used'] / this.memory['heap.committed'] * 100).toFixed(2);
          return isNaN(+r) ? 0 : r;
        },
        nonheapRate(){
          const r = parseFloat(this.memory['nonheap.used'] / this.memory['nonheap.committed'] * 100).toFixed(2);
          return isNaN(+r) ? 0 : r;
        },
        executeTime(){
          const uptime = this.memory['uptime'];
          let timestr = "";
          if(uptime){
            let d = Math.floor(uptime /86400000);
            let h = ("0" + Math.floor(uptime/3600000) ).slice(-2);
            let m = ("0" + Math.floor(uptime/60000%60) ).slice(-2);
            let s = ("0" + Math.floor(uptime/1000%60)).slice(-2);

            timestr = [d,h,m,s].join(':');
          }
          //return this.memory['uptime'] ? Moment(this.memory['uptime']).format('HH:mm:ss') : '';
          return timestr;
        }
      },
      mounted(){

      },
      filters: {
        capitalize(value) {
          if (!value) return ''
          value = value.toString();
          return value.charAt(0).toUpperCase() + value.slice(1);
        },
        statusName(status){
           switch(status){
             case "UP": return "已启动"
             case "OFFLINE": return "离线"
             case "DOWN": return "已关闭"
             case "OUT_OF_SERVICE": return "停止服务"
             default: return status
           }
        },
        memoryFormat(m){
           const M = 1024;
           const G = M * M;
           return m ? m > G ? (m / G).toFixed(1) + " G" : (m / M).toFixed(1) + " M" : '0 M';
        },
        codeName(code){
           switch(code){
             case "diskSpace": return "磁盘空间"
             case "db": return "数据库"
             default: return code
           }
        },
        toString(val){
          return val + '';
        },
        toNumber(val){
          return +val;
        },
        dateFormat(val){
          return Moment(val).format('YYYY-MM-DD HH:mm:ss')
        }
      },
      methods: {
       isHealthDetail(key,value) {
          return key !== 'status' && value !== null && (Array.isArray(value) || typeof value !== 'object');
       },
       isChildHealth(value) {
          return value !== null && !Array.isArray(value) && typeof value === 'object';
       },
       isMemHeap(key){
         return key in ['memory.mem','memory.mem.free','memory.heap.used','memory.heap.committed']
       },
       memoryFormat(m){
         const M = 1024;
         const G = M * M;
         return m ? m > G ? (m / G).toFixed(1) + " G" : (m / M).toFixed(1) + " M" : '0 M';
       }
      },
      components:{

      }
    }
</script>

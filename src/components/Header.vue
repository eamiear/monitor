<template>
  <div>
    <header class="toolbar toolbar-header">
      <div class="toolbar-actions">
        <button class="btn btn-logo">
          <img src="src/assets/app.png" alt="logo">
        </button>

        <div class="btn-group pull-right">
          <button class="btn btn-default" id="minimize" @click="minimize()"  title="最小化">
            <span class="icon icon-minus"></span>
          </button>
          <button class="btn btn-default" id="maximize" @click="maximize()" title="最大化">
            <span class="icon icon-popup"></span>
          </button>
          <button class="btn btn-default" id="exit" @click="exit()" title="关闭">
            <span class="icon icon-cancel-circled"></span>
          </button>
        </div>
      </div>
    </header>
  </div>
</template>
<style>
  .toolbar .btn-logo{
    border: none;
    box-shadow: none;
    background: none;
  }
  .toolbar .btn-logo > img{
    width:22px;
    height:22px;
    vertical-align: middle;
    -webkit-user-drag: none;
    -webkit-user-select: none;
  }
  .toolbar-actions{
    margin-bottom: 0;
    padding-bottom: 0;
  }
  .toolbar-actions .btn-group .btn,
  .toolbar-actions .btn-group .icon{
    transition: all .2s;
    cursor: pointer;
  }
  .toolbar-actions .btn-group .btn-default:hover{
    background: #eee;
  }
  .toolbar-actions .btn-group .icon-minus{
    padding-top: 5px;
  }
  .toolbar-actions .icon-cancel-circled{
    color: #de3c37;
    font-size: 16px;
  }
</style>
<script>
  const mainWindow = require('electron').remote.getCurrentWindow();

  export default{
    data(){
      return{
        dialogVisible: false,
        radio: 0,
        checked: true
      }
    },
    methods:{
      minimize(){
        mainWindow.minimize();
      },
      maximize(){
        mainWindow.isMaximized() ? mainWindow.unmaximize() : mainWindow.maximize();
      },
      exit(){
        mainWindow.close();
      }
    }
  }
</script>

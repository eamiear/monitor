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
    <v-dialog title="提示" v-model="dialogVisible" size="tiny">
      <v-radio-group v-model="radio">
        <v-radio :label="0">最小化到托盘</v-radio>
        <v-radio :label="1">退出</v-radio>
      </v-radio-group>
      <mu-divider/>
      <v-checkbox v-model="checked">记住</v-checkbox>

      <span slot="footer" class="dialog-footer">
        <v-button @click="dialogVisible = false">取 消</v-button>
        <v-button type="primary" @click="handleExit">确 定</v-button>
      </span>
    </v-dialog>
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

  .el-dialog{
    .el-dialog__body{
       padding-left: 50px;
    }
    .el-radio,
    .el-checkbox{
      display: block;
    }
    .el-radio+.el-radio{
      margin-left: 0;
    }
    .el-checkbox{
      padding-top: 10px;
    }
  }
</style>
<script>
  const mainWindow = require('electron').remote.getCurrentWindow();
  const app = require('electron').remote.app;
  import { Notification,MessageBox,Message } from 'element-ui'
  import { Dialog,Checkbox,Radio,Button,RadioGroup } from 'element-ui'

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
        const exit = localStorage.getItem('exit');
        if(exit === 1){
          app.quit();
        }else if(exit === 0){
          this.dialogVisible = false;
          mainWindow.close();
        }else{
          this.dialogVisible = true;
        }
      },
      handleExit(){
        this.dialogVisible = false;
        if(this.checked){
          this.radio ? localStorage.setItem('exit',1) : localStorage.setItem('exit',0);
        }else{
          localStorage.setItem('exit',0);
        }
        this.radio ? app.quit() : mainWindow.close();
      }
    },
    components:{
      'v-dialog':Dialog,
      'v-checkbox': Checkbox,
      'v-radio': Radio,
      'v-button': Button,
      'v-radio-group': RadioGroup
    }
  }
</script>

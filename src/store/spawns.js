/**
 * spawn process
 * Created by skz on 2016/12/22 0022.
 */

const process = require('process');

if(!window.spawns){
  window.spawns = [];
}

class Spawns{
  constructor(){
    this.spawns = window.spawns;
  }
  get(id){
    let index;
    //this.spawns.forEach(function(item ,i){
    // if(item.id === id){
    //    index = i;
    //  }
    //});
    this.spawns.some((item,i) => {
      let found = false;
      if(item.id === id){
        index = i;
        found = true;
      }
      return found;
    });
    return this.spawns[index];
  }
  push(id,spawn){
    this.spawns.push({id:id,spawn:spawn});
  }
  remove(id){
    let self = this;
    this.spawns.forEach(function(item ,i){
      if(item.id === id){
        self.spawns.splice(i,1);
      }
    });
  }
  clear(){
    this.spawns.length && this.spawns.forEach((item ,i) => {
      try {
        (item.pid) && item.kill();
      }catch (e){
        item.pid && process.kill(item.pid);
        console.log('kill process error');
      }
      self.spawns.splice(i,1);
    })
  }

  kill(id){
    let self = this;
    this.spawns.forEach(function(item ,i){
      if(item.id === id){
        try{
          (item.pid) && item.kill();
        }catch (err){
          item.pid && process.kill(item.pid);
          console.log('kill process error');
        }
        self.spawns.splice(i,1);
      }
    });
  }
}
export {Spawns}

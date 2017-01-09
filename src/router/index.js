import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router);

const  router = new Router({
  //hashbang: true,
  //saveScrollPosition: true,
  //suppressTransitionError: true,
  mode: 'hash',
  routes: [
    //{
    //  path: '*',
    //  component: require('../views/Welcome.vue')
    //},
    {
      path: '/',
      name: 'index',
      component: require('../views/Welcome.vue')
    },
    {
      path: '/home',
      name: 'main',
      component: require('../views/Home.vue')
    },
    {
      path: '/detail/:id',
      name: 'detail',
      component: require('../views/Detail.vue')
    }
  ]
});

export default  router



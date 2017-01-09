import Vue from 'vue'
import App from './App.vue'

import MuseUI from 'muse-ui'
import 'muse-ui/dist/muse-ui.css'

Vue.use(MuseUI);

import router from './router/index'

new Vue({
    el: '#root',
    router,
    render: (h) => h(App)
});

<template>
    <div class="container">
        <v-header></v-header>
      <transition name="custom-classes-transition"
                  enter-active-class="animated zoomIn"
                  leave-active-class="animated zoomOutRight">
        <router-view></router-view>
      </transition>
    </div>
</template>

<script>
    import VHeader from './components/Header.vue'
    export default {
        components: {
          VHeader
        }
    }
</script>

<style>
  .container {
    position: relative;
    margin: 0 auto;
    overflow: hidden;
    height: 100%;
    border: 2px solid #ece3e3;
    background: -webkit-gradient(linear, left top, left bottom, from(rgba(211, 220, 230, 0.63)), color-stop(2%, #d8e3e4));

  }
</style>

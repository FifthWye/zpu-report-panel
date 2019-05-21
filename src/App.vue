<template>
  <div id="app">
    <div class="container">
      <Auth v-on:get-mode="setMode"/>
      <Port :panelMode="mode"/>
      <Office :panelMode="mode"/>
    </div>
  </div>
</template>

<script>
import Auth from "./components/Auth";
import Port from "./components/Port/Port";
import Office from "./components/Office/Office";

export default {
  name: "app",
  components: {
    Port,
    Office,
    Auth
  },
  data: function() {
    return {
      mode: 0
    };
  },
  methods: {
    setMode(value) {
      this.mode = value;
    },
    checkMode() {
      if (localStorage.panel) {
        this.mode = Number(localStorage.panel);
      }
    }
  },
  watch: {
    mode(value) {
      this.mode = value;
    }
  },
  mounted() {
    this.checkMode();
  }
};
</script>

<style>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  line-height: 1.4;
}

.container {
  text-align: center;
}
</style>

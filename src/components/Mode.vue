<template>
  <div class="custom-radio" v-if="!mode">
    <p>Выберите режим панели:</p>
    <input type="radio" id="one" value="1" v-model="mode">
    <label for="one">Порт</label>
    &#8195;
    <input type="radio" id="two" value="2" v-model="mode">
    <label for="two">Офис</label>
  </div>
</template>

<script>
export default {
  data: function() {
    return {
      mode: localStorage.panel
    };
  },
  watch: {
    mode: function(value) {
      this.$emit("get-mode", Number(value));
      localStorage.panel = Number(value);
    }
  }
};
</script>

<style scoped>
.custom-radio {
  margin-top: 10%;
}

select {
  width: 200px;
  height: 50px;
}
</style>

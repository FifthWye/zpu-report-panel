<template>
  <div>
    <h1 v-if="!edit">{{title}}</h1>
    <input v-focus v-if="edit" v-model="title" maxlength="30" placeholder="Enter your title">
    <button v-if="!edit" class="edit" v-on:click="editTitle()">Edit</button>
    <button v-if="edit" class="save" v-on:click="editTitle()">Save</button>
  </div>
</template>

<script>
export default {
  name: "Title",
  data: function() {
    return {
      title: this.titleData,
      edit: false
    };
  },
  props: {
    titleData: {
      type: String,
      required: true
    }
  },
  methods: {
    editTitle() {
      this.edit = !this.edit;
      if (this.edit == false) {
        this.$emit("get-title", this.title);
      }
    }
  },
  watch: {
    titleData: function(value) {
      this.title = value;
    }
  },
  directives: {
    focus: {
      inserted: function(el) {
        el.focus();
      }
    }
  }
};
</script>

<style scoped>
div {
  height: 50px;
  width: 100%;
  text-align: center;
  /*border-bottom: 0.15rem solid #000;*/
}

h1 {
  display: inline-block;
  width: 75%;
  height: 100%;
  overflow: hidden;
}

img {
  height: 25px;
  width: 25px;
}

button {
  height: 100%;
  width: 25%;
  float: right;
  font-weight: bold;
  border: none;
  text-decoration: none;
  cursor: pointer;
  text-align: center;
  /*border-left: 0.15rem solid #000;*/
}

.edit {
  background-color: #555555;
  color: white;
}

.save {
  background-color: #4caf50;
  color: white;
}

button:focus {
  outline: 0;
}

input {
  height: 100%;
  width: 75%;
  display: inline-block;
  border: none;
  font-size: 24px;
  text-align: center;
  overflow: hidden;
}

input:focus {
  outline: 0;
}
</style>

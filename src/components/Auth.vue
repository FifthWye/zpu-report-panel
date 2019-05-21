<template>
  <div v-if="mode != 1 && mode != 2">
    <form action method="post">
      <label>Еmail:</label>
      <br>
      <input v-model="email" type="email">
      <label>Пароль:</label>
      <br>
      <input v-model="password" type="password">
      <button type="button" v-on:click="auth()" class="submit">Войти</button>
    </form>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "Auth",
  data: function() {
    return {
      email: "",
      password: "",
      mode: localStorage.panel
    };
  },
  methods: {
    auth() {
      const userData = new FormData();
      userData.append("request", 1);
      userData.append("email", this.email);
      userData.append("password", this.password);
      axios
        .post("http://localhost/report-panel/api/login.php", userData) //fix sql injections on server side
        .then(response => {
          this.mode = response.data["mode"];
          localStorage.currentUser = response.data["userId"];
        })
        .catch(function(error) {
          /* eslint-disable no-console */
          console.log(error);
          /* eslint-disable no-console */
        });
    }
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
form {
  width: 30%;
  margin: auto;
  margin-top: 10%;
}

input {
  height: 40px;
  border: 1px solid #ddd;
  width: 100%;
}

button {
  margin-top: 10px;
  height: 40px;
  width: 100%;
  background-color: #4caf50;
  color: white;
  border: none;
  cursor: pointer;
}
</style>

<template>
  <div>
    <ul v-if="this.errors.length" class="error">
      <li v-for="error in errors" v-bind:key="error.index">{{error}}</li>
    </ul>
    <form>
      <label>Номер платформы:</label>
      <input
        v-on:keypress="isNumber($event)"
        v-model="formData.platform"
        pattern="\d{8}"
        maxlength="8"
        inputmode="numeric"
        placeholder="Номер платформы"
        autocomplete="off"
        type="text"
        class="platform-input"
      >
      <div class="container-block">
        <div class="input-block">
          <label>Контейнер №1:</label>
          <br>
          <select v-model="formData.letter1">
            <option v-bind:key="letters" v-for="letters in containerLetters">{{letters}}</option>
          </select>
          <input
            v-on:keypress="isNumber($event)"
            v-model="formData.container1"
            pattern="\d{2,3}"
            maxlength="4"
            inputmode="numeric"
            placeholder="Контейнер"
            autocomplete="off"
            type="text"
            class="container-input"
          >
        </div>
        <div class="input-block">
          <label>Контейнер №2:</label>
          <br>
          <select v-model="formData.letter2">
            <option v-bind:key="letters" v-for="letters in containerLetters">{{letters}}</option>
          </select>
          <input
            v-on:keypress="isNumber($event)"
            v-model="formData.container2"
            pattern="\d{2,3}"
            maxlength="4"
            inputmode="numeric"
            placeholder="Контейнер"
            autocomplete="off"
            type="text"
            class="container-input"
          >
        </div>
      </div>
      <div class="container-block">
        <div class="input-block">
          <label>Первый ЗПУ:</label>
          <br>
          <input
            v-on:keypress="isZPU($event, formData.ZPU1)"
            v-model="formData.ZPU1"
            pattern="^[a-zA-Zа-яА-Я]{1}[0-9]{6}$"
            maxlength="7"
            placeholder="ЗПУ"
            autocomplete="off"
            type="text"
            class="zpu-input"
          >
        </div>
        <div class="input-block">
          <label>Второй ЗПУ:</label>
          <br>
          <input
            v-on:keypress="isZPU($event, formData.ZPU2)"
            v-model="formData.ZPU2"
            pattern="^[a-zA-Zа-яА-Я]{1}[0-9]{6}$"
            maxlength="7"
            placeholder="ЗПУ"
            autocomplete="off"
            type="text"
            class="zpu-input"
          >
        </div>
      </div>
      <button type="button" class="submit" v-on:click="addRow($event)">Добавить</button>
    </form>
  </div>
</template>

<script>
export default {
  name: "Form",
  data() {
    return {
      containerLetters: ["D", "Z", "U"],
      errors: [],
      formData: {
        platform: "",
        letter1: "D",
        container1: "",
        ZPU1: "",
        letter2: "D",
        container2: "",
        ZPU2: ""
      },
      report: this.tableData
    };
  },
  props: {
    tableData: {
      type: Array,
      required: true
    },
    tableErrors: {
      type: Array,
      required: true
    }
  },
  watch: {
    tableData: function(value) {
      this.report = value;
    },
    tableErrors: function(value) {
      this.errors = this.errors.concat(value);
    }
  },
  methods: {
    addRow(evt) {
      let new_zpu1 =
        this.formData.ZPU1.charAt(0).toUpperCase() +
        this.formData.ZPU1.slice(1);
      let new_zpu2 =
        this.formData.ZPU2.charAt(0).toUpperCase() +
        this.formData.ZPU2.slice(1);

      let row = {
        platform: this.formData.platform,
        container1: this.formData.letter1 + this.formData.container1,
        container2: this.formData.letter2 + this.formData.container2,
        ZPU1: new_zpu1,
        ZPU2: new_zpu2
      };
      this.matchesCheck(row);
      if (!this.errors.length) {
        this.$emit("add-row", row);
        this.formData.platform = "";
        this.formData.container1 = "";
        this.formData.container2 = "";
        this.formData.ZPU1 = "";
        this.formData.ZPU2 = "";
      } else {
        evt.preventDefault();
      }
    },
    isZPU(evt, str) {
      //var charCode = evt.which ? evt.which : evt.keyCode;
      var char = String.fromCharCode(evt.keyCode);

      if (str.length > 0) {
        this.isNumber(evt);
      } else {
        if (this.isChar(char)) {
          return true;
        } else {
          evt.preventDefault();
        }
      }
    },
    isNumber(evt) {
      var charCode = evt.which ? evt.which : evt.keyCode;
      if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        evt.preventDefault();
      } else {
        return true;
      }
    },
    isChar(char) {
      if (char.match(/[a-zA-Zа-яА-Я]/i)) {
        return true;
      } else {
        return false;
      }
    },
    matchesCheck(rowToAdd) {
      this.errors = [];
      if (!rowToAdd.platform) {
        this.errors.push("Требуется указать платформу");
      }
      if (rowToAdd.container1.length < 2) {
        this.errors.push("Требуется указать первый контейнер");
      }
      if (rowToAdd.container2.length < 2) {
        this.errors.push("Требуется указать второй контейнер");
      }
      if (!rowToAdd.ZPU1) {
        this.errors.push("Требуется указать первый ЗПУ");
      }
      if (!rowToAdd.ZPU2) {
        this.errors.push("Требуется указать второй ЗПУ");
      }
      if (!this.errors.length) {
        if (rowToAdd.container1 == rowToAdd.container2) {
          this.errors.push("Первый и второй контейнер не должны совпадать");
        }
        if (rowToAdd.ZPU1 == rowToAdd.ZPU2) {
          this.errors.push("Первый и второй ЗПУ не должны совпадать");
        }
      }
      this.report.forEach(line => {
        if (rowToAdd.platform == line.platform) {
          this.errors.push("Эта платформа уже есть в списке");
        }
        if (
          rowToAdd.container1 == line.container1 ||
          rowToAdd.container1 == line.container2
        ) {
          this.errors.push("Первый контейнер уже есть в списке");
        }
        if (
          rowToAdd.container2 == line.container1 ||
          rowToAdd.container2 == line.container2
        ) {
          this.errors.push("Второй контейнер уже есть в списке");
        }
        if (rowToAdd.ZPU1 == line.ZPU1 || rowToAdd.ZPU1 == line.ZPU2) {
          this.errors.push("Первый ЗПУ уже есть в списке");
        }
        if (rowToAdd.ZPU2 == line.ZPU1 || rowToAdd.ZPU2 == line.ZPU2) {
          this.errors.push("Второй ЗПУ уже есть в списке");
        }
      });
    }
  }
};
</script>

<style scoped>
label {
  font-size: 18px;
}

input {
  height: 40px;
  border: 1px solid #ddd;
}

.platform-input {
  width: 100%;
  margin-bottom: 20px;
}

.container-input {
  width: 88%;
}

.zpu-input {
  width: 100%;
}

.input-block {
  display: inline-block;
  width: 100%;
  margin-bottom: 10px;
}

.container-block {
  width: 50%;
  display: inline-block;
}

select {
  width: 12%;
  height: 40px;
  display: inline-block;
  border: 1px solid #ddd;
}

.submit {
  background-color: #4caf50;
  color: white;
  border: none;
  width: 100%;
  height: 50px;
  cursor: pointer;
}

.submit:focus {
  outline: 0;
}

.error {
  color: #000;
  margin-top: 10px;
  margin-bottom: 10px;
  padding-top: 20px;
  padding-bottom: 20px;
  border: 1px solid #f44336;
  text-align: center;
}

@media only screen and (min-width: 0px) and (max-width: 560px) {
  select {
    width: 25%;
  }

  .container-input {
    width: 75%;
  }
}
</style>

<template>
  <tr>
    <td>{{this.index + 1}}</td>
    <td v-if="!this.edit">{{this.platform}}</td>
    <td v-if="!this.edit">
      {{this.container1}}
      <br>
      {{this.container2}}
    </td>
    <td v-if="!this.edit">
      {{this.ZPU1}}
      <br>
      {{this.ZPU2}}
    </td>
    <td v-if="this.edit">
      <input
        v-on:keypress="isNumber($event)"
        v-model="platform"
        pattern="\d{8}"
        maxlength="8"
        inputmode="numeric"
        placeholder="Номер платформы"
        autocomplete="off"
        type="text"
        class="platform-input"
      >
    </td>
    <td v-if="this.edit">
      <input
        v-on:keypress="isNumber($event)"
        v-model="container1"
        pattern="\d{2,3}"
        maxlength="5"
        inputmode="numeric"
        placeholder="Контейнер"
        autocomplete="off"
        type="text"
        class="container-input"
      >
      <br>
      <input
        v-on:keypress="isNumber($event)"
        v-model="container2"
        pattern="\d{2,3}"
        maxlength="5"
        inputmode="numeric"
        placeholder="Контейнер"
        autocomplete="off"
        type="text"
        class="container-input"
      >
    </td>
    <td v-if="this.edit">
      <input
        v-on:keypress="isZPU($event, ZPU1)"
        v-model="ZPU1"
        pattern="^[a-zA-Zа-яА-Я]{1}[0-9]{6}$"
        maxlength="7"
        placeholder="ЗПУ"
        autocomplete="off"
        type="text"
        class="zpu-input"
      >
      <br>
      <input
        v-on:keypress="isZPU($event, ZPU2)"
        v-model="ZPU2"
        pattern="^[a-zA-Zа-яА-Я]{1}[0-9]{6}$"
        maxlength="7"
        placeholder="ЗПУ"
        autocomplete="off"
        type="text"
        class="zpu-input"
      >
    </td>
    <td>
      <button v-if="!this.edit" v-on:click="editRow()">
        <font-awesome-icon icon="edit"/>
      </button>
      <button v-if="this.edit" v-on:click="saveRow()">
        <font-awesome-icon icon="check-square"/>
      </button>
    </td>
    <td>
      <button v-on:click="deleteRow()">&#10006;</button>
    </td>
  </tr>
</template>
<script>
export default {
  name: "Row",
  data: function() {
    return {
      index: this.rowIndex,
      edit: false,
      errors: ["Первый контейнер уже есть в списке"],
      platform: this.rowData.platform,
      container1: this.rowData.container1,
      container2: this.rowData.container2,
      ZPU1: this.rowData.ZPU1,
      ZPU2: this.rowData.ZPU2
    };
  },
  props: {
    rowData: {
      type: Object,
      required: true
    },
    rowIndex: {
      type: Number,
      required: true
    }
  },
  methods: {
    deleteRow() {
      this.$emit("delete-row", this.index);
    },
    editRow() {
      this.edit = !this.edit;
    },
    saveRow() {
      this.edit = !this.edit;
      let row = {
        platform: this.platform,
        container1: this.container1,
        container2: this.container2,
        ZPU1: this.ZPU1,
        ZPU2: this.ZPU2
      };

      row.rowIndex = this.index;
      this.$emit("edit-row", row);
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
    }
  },
  watch: {
    rowData: function(value) {
      this.platform = value.platform;
      this.container1 = value.container1;
      this.container2 = value.container2;
      this.ZPU1 = value.ZPU1;
      this.ZPU2 = value.ZPU2;
    },
    rowIndex: function(value) {
      this.index = value;
    }
  }
};
</script>
<style scoped>
div {
  display: table-row;
  vertical-align: inherit;
  border-color: inherit;
}

th,
td {
  border: 1px solid #ddd;
  text-align: left;
  padding: 15px;
  width: 32%;
}

td:first-child {
  width: 4%;
}

button {
  height: 100%;
  width: 100%;
  float: right;
  font-weight: bold;
  border: none;
  text-decoration: none;
  cursor: pointer;
  text-align: center;
  background: #fff;
}

input {
  height: 30px;
  border: 1px solid #ddd;
}

.platform-input {
  width: 75%;
}

.container-input {
  width: 75%;
}

.zpu-input {
  width: 85%;
}

@media only screen and (min-width: 0px) and (max-width: 320px) {
  td:first-child {
    display: none;
  }
}

@media only screen and (min-width: 0px) and (max-width: 440px) {
  th,
  td {
    padding: 0;
    border: none;
    border-bottom: 1px solid #ddd;
  }

  button {
    margin-right: 5px;
  }
}

@media only screen and (min-width: 441px) and (max-width: 500px) {
  th,
  td {
    padding: 10px;
  }
}
</style>

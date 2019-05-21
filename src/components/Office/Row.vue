<template>
  <tr>
    <td>{{this.index + 1}}</td>
    <td>{{this.platform}}</td>
    <td>
      {{this.container1}}
      <br>
      {{this.container2}}
    </td>
    <td>
      {{this.ZPU1}}
      <br>
      {{this.ZPU2}}
    </td>
  </tr>
</template>
<script>
export default {
  name: "Row",
  data: function() {
    return {
      index: this.rowIndex,
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

  td:first-child {
    display: none;
  }
}

@media only screen and (min-width: 441px) and (max-width: 500px) {
  th,
  td {
    padding: 10px;
  }
}
</style>

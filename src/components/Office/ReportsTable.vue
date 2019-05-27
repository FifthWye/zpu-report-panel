<template>
  <div>
    <table>
      <tr>
        <th>№</th>
        <th>Отчет</th>
        <th></th>
      </tr>
      <tr v-for="report in reports" v-bind:key="report.index">
        <td>{{reports.length - reports.indexOf(report)}}</td>
        <td>{{report.title}} | {{report.date}}</td>
        <td>
          <button v-on:click="getReport(reports.length - reports.indexOf(report))">Открыть</button>
        </td>
      </tr>
    </table>
  </div>
</template>

<script>
export default {
  name: "ReportsTable",
  data: function() {
    return {
      reports: this.tableData
    };
  },
  methods: {
    getReport(reportIndex) {
      this.$emit("get-report", reportIndex);
    }
  },
  props: {
    tableData: {
      type: Array,
      required: true
    }
  },
  watch: {
    tableData: function(value) {
      this.reports = value;
    }
  }
};
</script>

<style scoped>
button {
  background-color: #4caf50;
  color: white;
  border: none;
  width: 80px;
  height: 50px;
  cursor: pointer;
}

button:hover {
  background-color: #3e8e41;
}

button:focus {
  outline: 0;
}

table {
  text-align: left;
  border-collapse: collapse;
  width: 100%;
}

th,
td {
  border: 1px solid #ddd;
  text-align: left;
  padding: 15px;
  width: 85%;
}

th:first-child {
  width: 5%;
}

td:first-child {
  width: 5%;
}

th:nth-child(2) {
  border-right: none;
}

td:nth-child(2) {
  border-right: none;
}

th:last-child {
  width: 10%;
  border-left: none;
}

td:last-child {
  width: 10%;
  border-left: none;
}

@media only screen and (min-width: 0px) and (max-width: 440px) {
  th,
  td {
    padding: 0;
    border: none;
    border-bottom: 1px solid #ddd;
  }
}

@media only screen and (min-width: 441px) and (max-width: 500px) {
  th,
  td {
    padding: 10px;
  }
}
</style>

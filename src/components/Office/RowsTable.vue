<template>
  <div>
    <table>
      <tr>
        <th>№</th>
        <th>Платформа</th>
        <th>Контейнеры</th>
        <th>ЗПУ</th>
      </tr>
      <Row
        v-for="rows in report"
        v-bind:key="rows.index"
        :rowIndex="report.indexOf(rows)"
        :rowData="rows"
      />
    </table>
  </div>
</template>

<script>
import Row from "./Row";

export default {
  name: "RowsTable",
  components: {
    Row
  },
  data: function() {
    return {
      report: this.tableData
    };
  },
  props: {
    tableData: {
      type: Array,
      required: true
    }
  },
  watch: {
    tableData: function(value) {
      this.report = value;
    }
  }
};
</script>

<style scoped>
table {
  text-align: left;
  border-collapse: collapse;
  width: 100%;
  margin-top: 20px;
}

th,
td {
  border: 1px solid #ddd;
  text-align: left;
  padding: 15px;
  width: 32%;
}

th:first-child {
  width: 4%;
}

@media only screen and (min-width: 0px) and (max-width: 440px) {
  th,
  td {
    padding: 0;
    border: none;
    border-bottom: 1px solid #ddd;
  }

  th:first-child {
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


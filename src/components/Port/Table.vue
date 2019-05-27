<template>
  <div>
    <table>
      <tr>
        <th>№</th>
        <th>Платформа</th>
        <th>Контейнеры</th>
        <th>ЗПУ</th>
        <th></th>
        <th></th>
      </tr>
      <Row
        v-for="rows in report"
        v-bind:key="rows.index"
        v-on:delete-row="deleteRow"
        v-on:edit-row="editRow"
        :rowIndex="report.indexOf(rows)"
        :rowData="rows"
      />
    </table>
  </div>
</template>

<script>
import Row from "./Row";

export default {
  name: "Table",
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
  },
  methods: {
    deleteRow(index) {
      this.$emit("delete-row", index);
    },
    editRow(obj) {
      this.$emit("edit-row", obj);
    }
  }
};
</script>

<style scoped>
table {
  text-align: left;
  border-collapse: collapse;
  width: 100%;
  margin-top: 10px;
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

@media only screen and (min-width: 0px) and (max-width: 320px) {
  th:first-child {
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
}

@media only screen and (min-width: 441px) and (max-width: 500px) {
  th,
  td {
    padding: 10px;
  }
}
</style>

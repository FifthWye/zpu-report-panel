<template>
  <div v-if="mode == 1">
    <Title :titleData="this.title" v-on:get-title="setTitle"/>
    <Form :tableData="this.list" v-on:add-row="addRow"/>
    <Table :tableData="this.list" v-on:delete-row="deleteRow" v-on:edit-row="editRow"/>
    <button v-if="this.list.length != 0" class="send" v-on:click="saveReport()">Отправить отчет</button>
  </div>
</template>

<script>
import Title from "./Title";
import Form from "./Form";
import Table from "./Table";

import axios from "axios";

export default {
  name: "Port",
  components: {
    Title,
    Form,
    Table
  },
  data: function() {
    return {
      title: "Empty title",
      currentReportId: 1,
      list: [],
      mode: this.panelMode
    };
  },
  props: {
    panelMode: {
      type: Number,
      required: true
    }
  },
  methods: {
    addRow(value) {
      this.list.push(value);
    },
    deleteRow(value) {
      this.list.splice(value, 1);
    },
    editRow(obj) {
      let index = obj.rowIndex;
      delete obj.rowIndex;
      this.list[index] = obj;
    },
    setTitle(value) {
      this.title = value;
    },
    saveReport() {
      this.postReport();
    },
    getReport() {
      axios
        .get("http://localhost/report-panel/api/port/rows.php", {
          params: {
            request: 1
          }
        })
        .then(response => {
          /* eslint-disable no-console */
          console.log(response.data);
          /* eslint-disable no-console */
          this.list = response.data;
        })
        .catch(
          error =>
            /* eslint-disable no-console */
            console.log(error)
          /* eslint-disable no-console */
        );
    },
    getTitle() {
      axios
        .get("http://localhost/report-panel/api/port/reports.php", {
          params: {
            request: 1
          }
        })
        .then(response => {
          this.currentReportId = response.data[0].reportId;
          this.title = response.data[0].title;
          this.getData();
        })
        .catch(
          error =>
            /* eslint-disable no-console */
            console.log(error)
          /* eslint-disable no-console */
        );
    },
    postReport() {
      const newReport = new FormData();
      newReport.append("request", 2);
      newReport.append("title", "Новый отчет");
      newReport.append("sentBy", localStorage.currentUser);

      axios
        .post("http://localhost/report-panel/api/port/reports.php", newReport)
        .then(function(response) {
          /* eslint-disable no-console */
          console.log(response);
          /* eslint-disable no-console */
        })
        .catch(function(error) {
          /* eslint-disable no-console */
          console.log(error.data);
          /* eslint-disable no-console */
        });

      const newRows = new FormData();
      newRows.append("reportId", Number(this.currentReportId));

      this.list.forEach(function(row) {
        newRows.append("request", 2);
        newRows.append("platform", row.platform);
        newRows.append("container1", row.container1);
        newRows.append("container2", row.container2);
        newRows.append("ZPU1", row.ZPU1);
        newRows.append("ZPU2", row.ZPU2);

        axios
          .post("http://localhost/report-panel/api/port/rows.php", newRows)
          .then(function(response) {
            /* eslint-disable no-console */
            console.log(response);
            /* eslint-disable no-console */
          })
          .catch(function(error) {
            /* eslint-disable no-console */
            console.log(error);
            /* eslint-disable no-console */
          });
      });
      localStorage.removeItem("list");
      localStorage.removeItem("title");
      localStorage.removeItem("currentReportId");
      this.getData();
    },
    getData() {
      if (localStorage.list) {
        this.list = JSON.parse(localStorage.list);
      } else {
        this.getReport();
      }
      if (localStorage.title && localStorage.currentReportId) {
        this.title = localStorage.title;
        this.currentReportId = localStorage.currentReportId;
      } else {
        this.getTitle();
      }
    }
  },
  watch: {
    title: function(value) {
      if (typeof value === "undefined") {
        localStorage.title = value;
      } else {
        this.getTitle();
      }
    },
    currentReportId: function(value) {
      localStorage.currentReportId = value;
    },
    list: function(value) {
      localStorage.list = JSON.stringify(value);
    },
    panelMode: function(value) {
      this.mode = value;
    }
  },
  mounted() {
    this.getData();
  }
};
</script>

<style scoped>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  line-height: 1.4;
}

button {
  height: 50px;
  width: 100%;
  float: right;
  font-weight: bold;
  border: none;
  text-decoration: none;
  cursor: pointer;
  text-align: center;
  margin-top: 20px;
  /*border-left: 0.15rem solid #000;*/
}

.send {
  background-color: #4caf50;
  color: white;
}

button:focus {
  outline: 0;
}
</style>

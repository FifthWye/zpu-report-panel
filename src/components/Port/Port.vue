<template>
  <div v-if="mode == 1 || mode == -1">
    <Title :titleData="this.title" v-on:get-title="setTitle"/>
    <Form :tableData="this.list" :tableErrors="this.errors" v-on:add-row="addRow"/>
    <Table :tableData="this.list" v-on:delete-row="deleteRow" v-on:edit-row="editRow"/>
    <button v-if="this.list.length != 0" class="send" v-on:click="sendReport()">Отправить отчет</button>
    <button v-if="this.list.length != 0" class="save" v-on:click="saveReport()">Сохранить отчет</button>
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
      mode: this.panelMode,
      errors: []
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
      localStorage.list = JSON.stringify(this.list);
    },
    setTitle(value) {
      this.title = value;
    },
    sendReport() {
      this.checkMatches();

      if (!this.errors.length) {
        this.postReportAndCreateNew();
      }
    },
    saveReport() {
      this.checkMatches();

      if (!this.errors.length) {
        this.postReport();
      }
    },
    checkMatches() {
      this.errors = [];
      var matches = [];
      for (var i = 0, len = this.list.length; i < len; i++) {
        for (var i1 = 0, len1 = this.list.length; i1 < len1; i1++) {
          var alreadyChecked = false;
          if (matches.length) {
            for (var i2 = 0; i2 < matches.length; i2++) {
              if (i == matches[i2].first && i1 == matches[i2].second) {
                alreadyChecked = true;
              }
              if (i == matches[i2].second && i1 == matches[i2].first) {
                alreadyChecked = true;
              }
            }
          }

          if (i1 != i) {
            if (!alreadyChecked) {
              if (this.list[i].platform == this.list[i1].platform) {
                this.errors.push(
                  "Платформы " +
                    (i + 1) +
                    "-ой и " +
                    (i1 + 1) +
                    "-ой строки совпадают"
                );
              }
              if (
                this.list[i].container1 == this.list[i1].container1 ||
                this.container1 == this.list[i1].container2
              ) {
                this.errors.push(
                  "Первый контейнер " +
                    (i + 1) +
                    "-ой строки совпадает с контейнером " +
                    (i1 + 1) +
                    "-ой строки"
                );
              }
              if (
                this.list[i].container2 == this.list[i1].container1 ||
                this.container2 == this.list[i1].container2
              ) {
                this.errors.push(
                  "Первый контейнер " +
                    (i + 1) +
                    "-ой строки совпадает с контейнером " +
                    (i1 + 1) +
                    "-ой строки"
                );
              }
              if (
                this.list[i].ZPU1 == this.list[i1].ZPU1 ||
                this.ZPU1 == this.list[i1].ZPU2
              ) {
                this.errors.push(
                  "Первый ЗПУ " +
                    (i + 1) +
                    "-ой строки совпадает с ЗПУ " +
                    (i1 + 1) +
                    "-ой строки"
                );
              }
              if (
                this.list[i].ZPU2 == this.list[i1].ZPU1 ||
                this.ZPU2 == this.list[i1].ZPU2
              ) {
                this.errors.push(
                  "Первый ЗПУ " +
                    (i + 1) +
                    "-ой строки совпадает с ЗПУ " +
                    (i1 + 1) +
                    "-ой строки"
                );
              }
              if (this.errors.length) {
                matches.push({ first: i, second: i1 });
              }
            }
          }
        }
      }
    },
    getReport() {
      axios
        .get("/api/port/rows.php", {
          params: {
            request: 1
          }
        })
        .then(response => {
          /* eslint-disable no-console */
          //console.log(response.data);
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
        .get("/api/port/reports.php", {
          params: {
            request: 1
          }
        })
        .then(response => {
          this.currentReportId = response.data[0].reportId;
          this.title = response.data[0].title;
        })
        .catch(
          error =>
            /* eslint-disable no-console */
            console.log(error)
          /* eslint-disable no-console */
        );
    },
    postReport() {
      var dbList = [];
      var newList = this.list;

      axios
        .get("/api/port/rows.php", {
          params: {
            request: 1
          }
        })
        .then(response => {
          /* eslint-disable no-console */
          //console.log(response.data);
          /* eslint-disable no-console */
          dbList = response.data;

          for (var i1 = 0; i1 < newList.length; i1++) {
            for (var i2 = 0; i2 < dbList.length; i2++) {
              if (JSON.stringify(newList[i1]) === JSON.stringify(dbList[i2])) {
                newList.splice(newList.indexOf(newList[i1]), 1);
              }
            }
          }

          for (var i = 0, len = newList.length; i < len; i++) {
            let row = newList[i];
            const newRows = new FormData();
            newRows.append("request", 2);
            newRows.append("reportId", this.currentReportId);
            newRows.append("platform", row.platform);
            newRows.append("container1", row.container1);
            newRows.append("container2", row.container2);
            newRows.append("ZPU1", row.ZPU1);
            newRows.append("ZPU2", row.ZPU2);

            axios
              .post("/api/port/rows.php", newRows)
              // .then(function(response) {
              //   /* eslint-disable no-console */
              //   console.log(response);
              //   /* eslint-disable no-console */
              // })
              .catch(function(error) {
                /* eslint-disable no-console */
                console.log(error);
                /* eslint-disable no-console */
              });
          }
          localStorage.removeItem("list");
          localStorage.removeItem("title");
          localStorage.removeItem("currentReportId");
          this.getData();
        })
        .catch(
          error =>
            /* eslint-disable no-console */
            console.log(error)
          /* eslint-disable no-console */
        );
    },
    postReportAndCreateNew() {
      var c = confirm(
        "После отправки отчет нельзя будет удалить или отредактировать!"
      );
      if (c) {
        const newReport = new FormData();
        newReport.append("request", 2);
        newReport.append("title", "Новый отчет");
        newReport.append("sentBy", localStorage.currentUser);

        axios
          .post("/api/port/reports.php", newReport)
          // .then(function(response) {
          //   /* eslint-disable no-console */
          //   console.log(response);
          //   /* eslint-disable no-console */
          // })
          .catch(function(error) {
            /* eslint-disable no-console */
            console.log(error.data);
            /* eslint-disable no-console */
          });

        var dbList = [];
        var newList = this.list;

        axios
          .get("/api/port/rows.php", {
            params: {
              request: 1
            }
          })
          .then(response => {
            /* eslint-disable no-console */
            //console.log(response.data);
            /* eslint-disable no-console */
            dbList = response.data;

            for (var i1 = 0; i1 < newList.length; i1++) {
              for (var i2 = 0; i2 < dbList.length; i2++) {
                if (
                  JSON.stringify(newList[i1]) === JSON.stringify(dbList[i2])
                ) {
                  newList.splice(newList.indexOf(newList[i1]), 1);
                }
              }
            }
            for (var i = 0, len = newList.length; i < len; i++) {
              let row = newList[i];
              const newRows = new FormData();
              newRows.append("request", 2);
              newRows.append("reportId", this.currentReportId);
              newRows.append("platform", row.platform);
              newRows.append("container1", row.container1);
              newRows.append("container2", row.container2);
              newRows.append("ZPU1", row.ZPU1);
              newRows.append("ZPU2", row.ZPU2);

              axios
                .post("/api/port/rows.php", newRows)
                // .then(function(response) {
                //   /* eslint-disable no-console */
                //   console.log(response);
                //   /* eslint-disable no-console */
                // })
                .catch(function(error) {
                  /* eslint-disable no-console */
                  console.log(error);
                  /* eslint-disable no-console */
                });
            }
            localStorage.removeItem("list");
            localStorage.removeItem("title");
            localStorage.removeItem("currentReportId");
            this.getData();
          });
      }
    },
    getData() {
      if (localStorage.title && localStorage.currentReportId) {
        this.title = localStorage.title;
        this.currentReportId = localStorage.currentReportId;
      } else {
        this.getTitle();
      }
      if (localStorage.list) {
        this.list = JSON.parse(localStorage.list);
      } else {
        this.getReport();
      }
    }
  },
  watch: {
    title: function(value) {
      localStorage.title = value;
    },
    currentReportId: function(value) {
      localStorage.currentReportId = value;
    },
    list: function(value) {
      localStorage.list = JSON.stringify(value);
    },
    panelMode: function(value) {
      this.mode = value;
    },
    errors: function(value) {
      this.errors = value;
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
  width: 50%;
  float: right;
  font-weight: bold;
  border: none;
  text-decoration: none;
  cursor: pointer;
  text-align: center;
  margin-top: 10px;
  /*border-left: 0.15rem solid #000;*/
}

.send {
  background-color: #4caf50;
  color: white;
}

.save {
  background-color: #555555;
  color: white;
}

button:focus {
  outline: 0;
}
</style>

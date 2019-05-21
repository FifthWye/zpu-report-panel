<template>
  <div v-if="mode == 2">
    <ReportsTable
      v-on:get-report="setCurrentReport"
      v-if="!currentReport"
      :tableData="this.reportsList"
    />
    <Menu
      v-on:set-current="setCurrentEmpty"
      v-if="currentReport"
      :reportName="this.reportsList[(this.currentReport -1)].title"
      :tableData="this.rowsList"
    />
    <RowsTable v-if="currentReport" :tableData="this.rowsList"/>
  </div>
</template>

<script>
import ReportsTable from "./ReportsTable";
import RowsTable from "./RowsTable";
import Menu from "./Menu";
import axios from "axios";

export default {
  components: {
    ReportsTable,
    RowsTable,
    Menu
  },
  data: function() {
    return {
      mode: this.panelMode,
      currentReport: "",
      reportsList: [],
      rowsList: []
    };
  },
  props: {
    panelMode: {
      type: Number,
      required: true
    }
  },
  methods: {
    getReports() {
      axios
        .get("http://localhost/report-panel/api/office/reports.php", {
          params: {
            request: 1
          }
        })
        .then(response => (this.reportsList = response.data))
        .catch(
          error =>
            /* eslint-disable no-console */
            console.log(error)
          /* eslint-disable no-console */
        );
    },
    getReport(value) {
      axios
        .get("http://localhost/report-panel/api/office/rows.php", {
          //fix sql injections on server side
          params: {
            request: 1,
            reportId: value
          }
        })
        .then(response => (this.rowsList = response.data))
        .catch(
          error =>
            /* eslint-disable no-console */
            console.log(error)
          /* eslint-disable no-console */
        );
    },
    setCurrentReport(value) {
      this.currentReport = value;
      this.getReport(value);
    },
    setCurrentEmpty(value) {
      this.currentReport = value;
    }
  },
  watch: {
    panelMode: function(value) {
      this.mode = value;
    },
    rowsList: function(value) {
      this.rowsList = value;
    }
  },
  mounted() {
    this.getReports();
  }
};
</script>


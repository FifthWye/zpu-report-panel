<template>
  <div>
    <button v-on:click="csvExport" id="downloadlink">Скачать в формате CSV</button>
    <button v-on:click="back" id="back">Назад</button>
  </div>
</template>

<script>
export default {
  name: "Menu",
  data: function() {
    return {
      reportData: this.tableData,
      fileName: this.reportName + ".csv"
    };
  },
  props: {
    tableData: {
      type: Array,
      required: true
    },
    reportName: {
      type: String,
      required: true
    }
  },
  methods: {
    back() {
      this.$emit("set-current", 0);
    },
    csvExport() {
      var processRow = function(row) {
        var finalVal = "";
        for (var j = 0; j < row.length; j++) {
          var innerValue = row[j] === null ? "" : row[j].toString();
          if (row[j] instanceof Date) {
            innerValue = row[j].toLocaleString();
          }
          var result = innerValue.replace(/"/g, '""');
          if (result.search(/("|,|\n)/g) >= 0) result = '"' + result + '"';
          if (j > 0) finalVal += ",";
          finalVal += result;
        }
        return finalVal + "\n";
      };

      var csvFile = "";
      var titles = [
        "Платформа",
        "Первый контейнер",
        "Второй контейнер",
        "Первый ЗПУ",
        "Второй ЗПУ"
      ];

      csvFile += processRow(titles);
      for (var i = 0; i < this.reportData.length; i++) {
        let row = [
          this.reportData[i].platform,
          this.reportData[i].container1,
          this.reportData[i].container2,
          this.reportData[i].ZPU1,
          this.reportData[i].ZPU2
        ];
        csvFile += processRow(row);
      }

      var blob = new Blob(["\uFEFF" + csvFile], {
        type: "text/csv;charset=utf-8;"
      });
      if (navigator.msSaveBlob) {
        // IE 10+
        navigator.msSaveBlob(blob, this.fileName);
      } else {
        var link = document.createElement("a");
        if (link.download !== undefined) {
          var url = URL.createObjectURL(blob);
          link.setAttribute("href", url);
          link.setAttribute("download", this.fileName);
          link.style.visibility = "hidden";
          document.body.appendChild(link);
          link.click();
          document.body.removeChild(link);
        }
      }
    }
  },
  watch: {
    tableData: function(value) {
      this.reportData = value;
    },
    reportName: function(value) {
      this.fileName = value + ".csv";
    }
  }
};
</script>

<style scoped>
#downloadlink {
  background-color: #4caf50;
  position: relative;
  color: white;
  border: none;
  width: 70%;
  height: 50px;
  cursor: pointer;
}

#downloadlink:focus {
  outline: 0;
}

#downloadlink:hover {
  background-color: #3e8e41;
}

#back {
  background-color: #e7e7e7;
  color: black;
  position: relative;
  border: none;
  width: 30%;
  height: 50px;
  cursor: pointer;
}

#back:focus {
  outline: 0;
}

#downloadlink:focus {
  outline: 0;
}
</style>

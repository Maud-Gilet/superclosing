import Chart from "chart.js"

const graphsecond = ()=>{
  var ctx = document.getElementById("mySecondChart").getContext('2d');
  var shares = document.getElementById("mySecondChart").dataset.share.split("-");
  var mySecondChart = new Chart(ctx, {
      type: 'bar',
      data: {
          labels: ["Levée", "Pre-money"],
          datasets: [{
              label: '',
              data: shares,
              backgroundColor: [
                  'rgba(252, 150, 0, 0.8)',
                  'rgba(205, 116, 74, 1)'

              ],
              borderColor: [
                  'rgba(252, 150, 0, 1)',
                  'rgba(205, 116, 74, 1)'
              ],
              borderWidth: 1
          }]
      },
      options: {
          tooltips:{
              enabled: false
          },
          legend:{
              display: false
          },
          scales: {
              xAxes: [{
                  gridLines: {
                      display:false,
                      drawBorder:false
                  },
                  ticks: {
                      beginAtZero: true,
                      callback: function(value, index, values) {
                        return "";
                      }
                  }

              }],
              yAxes: [{
                  gridLines: {
                      display:false,
                      drawBorder:false
                  },
                  ticks: {
                      beginAtZero: true,
                      callback: function(value, index, values) {
                        return "";
                      }
                  }

              }]
          }
      }
  });
};


export { graphsecond };

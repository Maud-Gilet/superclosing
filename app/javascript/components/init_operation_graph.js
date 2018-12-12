import Chart from "chart.js"

const graph = ()=>{
  var ctx = document.getElementById("myChart").getContext('2d');
  var shares = document.getElementById("myChart").dataset.share.split(",");
  var labels = document.getElementById("myChart").dataset.label.split(",");
  var myChart = new Chart(ctx, {
      type: 'doughnut',
      data: {
          labels: labels,
          datasets: [{
              label: '# of Votes',
              data: shares,
              backgroundColor: [
                  '#0d627a',
                  '#0c907d',
                  '#40a8c4',
                  '#cce490',
                  '#a6cb12'
              ],
              borderColor: [
                  '#0d627a',
                  '#0c907d',
                  '#40a8c4',
                  '#cce490',
                  '#a6cb12'
              ],
              borderWidth: 1
          }]
      },
      options: {
          scales: {
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
          },
          legend: {
            position: 'right',
            labels: {
              padding: 20,
              fontFamily: 'Barlow',
              fontSize: 16
            }

          }
      }
  });
};

export { graph };


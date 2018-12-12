import Chart from "chart.js"

const graphfourth = ()=>{
  var ctx = document.getElementById("chart-fourth").getContext('2d');
  var shares = document.getElementById("chart-fourth").dataset.share.split(",");
  var labels = document.getElementById("chart-fourth").dataset.label.split(",");
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
          responsive: true,
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
            position: 'top',
            labels: {
              padding: 6,
              fontFamily: 'Barlow',
              fontSize: 12
            }

          }
      }
  });
};

export { graphfourth };

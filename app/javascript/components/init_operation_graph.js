import Chart from "chart.js"

const graph = ()=>{
  var ctx = document.getElementById("myChart").getContext('2d');
  var shares = document.getElementById("myChart").dataset.share.split("-");
  var myChart = new Chart(ctx, {
      type: 'doughnut',
      data: {
          labels: ["Associé 1", "Associé 2"],
          datasets: [{
              label: '# of Votes',
              data: shares,
              backgroundColor: [
                  'rgba(252, 150, 0, 0.8)',
                  '#2D3D4D'

              ],
              borderColor: [
                  'rgba(252, 150, 0, 1)',
                  '#2D3D4D'
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
          }
      }
  });
};

export { graph };


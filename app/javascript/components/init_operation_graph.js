import Chart from "chart.js"

const graph = ()=>{
  var ctx = document.getElementById("myChart").getContext('2d');
  var shares = document.getElementById("myChart").dataset.share.split("-");
  var myChart = new Chart(ctx, {
      type: 'doughnut',
      data: {
          labels: ["Levée", "Pre-money"],
          datasets: [{
              label: '# of Votes',
              data: shares,
              backgroundColor: [
                  'rgba(252, 150, 0, 0.8)',
                  'rgba(71, 79, 88, 0.8)'

              ],
              borderColor: [
                  'rgba(252, 150, 0, 1)',
                  'rgba(71, 79, 88, 1)'
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

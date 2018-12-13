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
                  '#6b8fb2',
                  '#2D3D4D',
                  '#E57C04',
                  '#FC9E4F',
                  '#FBB02D'
              ],
              borderColor: [
                  '#6b8fb2',
                  '#2D3D4D',
                  '#E57C04',
                  '#FC9E4F',
                  '#FBB02D'

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
            position: 'right',
            labels: {
              padding: 12,
              fontFamily: 'Barlow',
              fontSize: 14
            }

          }
      }
  });
};

export { graphfourth };

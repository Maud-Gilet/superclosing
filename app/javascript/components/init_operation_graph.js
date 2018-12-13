import Chart from "chart.js"

const graph = ()=> {
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
            '#2D3D4D',
            '#52708d',
            '#6b8fb2',
            '#8bb8e5',
            '#bfddfb'
        ],
        borderColor: [
            '#2D3D4D',
            '#52708d',
            '#6b8fb2',
            '#8bb8e5',
            '#bfddfb'
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


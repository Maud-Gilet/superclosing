import Chart from "chart.js"

const graphthird = () => {
  var ctx = document.getElementById('chart-third');
  var data1 = document.getElementById("chart-third").dataset.share.split("-")[0];
  var data2 = document.getElementById("chart-third").dataset.share.split("-")[1];

  var myChart = new Chart(ctx, {
    type: 'horizontalBar',
    data: {
      labels: ['Suivi levée'],
      datasets: [
        {
          label: '',
          data: [data1],
          backgroundColor: ['#0c907d'],
        },
        {
          label: '',
          data: [data2],
          backgroundColor: ['#add2c9'],
        },
      ],
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
            display: false,
            drawBorder: false
          },
          stacked: true,
          ticks: {
            beginAtZero: true,
            callback: function(value, index, values) {
              return "";
            }
          },
        }],
        yAxes: [{
          gridLines: {
            display:false,
            drawBorder:false
          },
          stacked: true,
          ticks: {
            beginAtZero: true,
            callback: function(value, index, values) {
              return "";
            }
          },
        }],
      }
    },
  });
};


export { graphthird };

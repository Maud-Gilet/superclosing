import Chart from "chart.js"

const graphthird = () => {
  var ctx = document.getElementById('chart-third');
  var data1 = document.getElementById("chart-third").dataset.share.split("-")[0];
  var data2 = document.getElementById("chart-third").dataset.share.split("-")[1];

  var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ['Suivi levée'],
      datasets: [
        {
          label: '',
          data: [data1],
          backgroundColor: [
            'rgba(252, 150, 0, 0.8)',
            'rgba(205, 116, 74, 1)'],
        },
        {
          label: '',
          data: [data2],
          borderColor: [
            'rgba(252, 150, 0, 1)',
            'rgba(205, 116, 74, 1)'],
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

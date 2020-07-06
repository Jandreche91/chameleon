
require("chart.js")

console.log("Chartjs page is loading!");

let overallPerformanceChart = document.getElementById('overallPerformance');
console.log(overallPerformanceChart.dataset)
const overallPerformance = new Chart(overallPerformanceChart, {
  type: 'line',
  data: {
    labels: [1,2,3,4,5,6,7,8,9,10,11,12],
    datasets: [{
      label: 'Billed',
      data: JSON.parse(overallPerformanceChart.dataset.value),
      borderColor: ['rgba(170, 239, 104, 0.9)'],
      backgroundColor: ['rgba(170, 239, 104, 0.0)'],
      // backgroundColor: ['rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)', 'rgba(75, 192, 192, 0.2)', 'rgba(153, 102, 255, 0.2)', 'rgba(255, 159, 64, 0.2)'],
      // borderColor: ['rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)', 'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)', 'rgba(255, 159, 64, 1)'],
      borderWidth: 4,
      pointRadius: 0.1,
      pointHitRadius: 2
    }]
  },
  options: {
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero: true
        }
      }]
    }
  }
});


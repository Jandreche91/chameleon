
require("chart.js");
require("datejs");

// Function that constructs an array with the past X months to be shown on the X Axis

const constructXAxisMonths = (months) => {
  results = [];
  date = Date.parse(Date.today());
  for (let i =1; i <= months; i++) {
    month = date.toString('MMM yy');
    results.push(month);
    date = Date.parse(date).add(-1).month();
  }
  return results.reverse()
};


let overallPerformanceChart = document.getElementById('overallPerformance');
// console.log(overallPerformanceChart.dataset)
const overallPerformance = new Chart(overallPerformanceChart, {
  type: 'line',
  data: {
    labels: constructXAxisMonths(12),
    datasets: [{
      label: 'Billed',
      data: JSON.parse(overallPerformanceChart.dataset.value),
      borderColor: ['rgba(170, 239, 104, 0.9)'],
      backgroundColor: ['rgba(170, 239, 104, 0.0)'],
      borderWidth: 4,
      pointRadius: 0.1,
      pointHitRadius: 5
    }]
  },
  options: {
    legend: {
      position: "bottom"
    },
    layout: {
            padding: {
                left: 25,
                right: 25,
                top: 25,
                bottom: 25
            }
        },
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero: true
        }
      }]
    }
  }
});


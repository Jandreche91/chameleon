
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


const overallPerformanceChart = document.getElementById('overallPerformance');
// console.log(overallPerformanceChart.dataset)
const overallPerformance = new Chart(overallPerformanceChart, {
  type: 'line',
  data: {
    labels: constructXAxisMonths(12),
    datasets: [
    {
      label: 'Billed',
      yAxisID: 'Billed',
      data: JSON.parse(overallPerformanceChart.dataset.value),
      borderColor: ['rgba(170, 239, 104, 0.9)'],
      backgroundColor: ['rgba(170, 239, 104, 0.0)'],
      borderWidth: 4,
      pointRadius: 2,
      pointHitRadius: 5,
      pointBackgroundColor: 'rgba(170, 239, 104, 0.9)',
      pointBorderColor:'rgba(170, 239, 104, 0.9)'
      },
    {
      label: 'Hours spent',
      yAxisID: 'Hours',
      data: JSON.parse(overallPerformanceChart.dataset.hoursSpent),
      borderColor: ['rgba(144, 12, 63, 0.9)'],
      backgroundColor: ['rgba(170, 239, 104, 0.0)'],
      borderWidth: 4,
      pointRadius: 2,
      pointHitRadius: 5,
      pointBackgroundColor: 'rgba(144, 12, 63, 0.9)',
      pointBorderColor: 'rgba(144, 12, 63, 1)'
    }
    ]
  },
  options: {

    //

    animation: {
            duration: 3000
        },

    //

    tooltips: {
        multiKeyBackground: '#1E334D',
        callbacks: {
          label: function(tooltipItem, data) {
            let value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
            value = value.toString();
            value = value.split(/(?=(?:...)*$)/);
            value = `${value.join('.')}`;
            let label = data.datasets[tooltipItem.datasetIndex].label
            if (label === "Billed") {
              return `${label}: $${value}`;
            };
            return `${label}: ${value}`;
          }
        }, // end callbacks
      }, //end tooltips

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
        }, // end legend
    scales: {
      yAxes: [{
        id: 'Billed',
        type: 'linear',
        position: 'left',
        //
          ticks: {
            beginAtZero: false,
            userCallback: function(value, index, values) {
                value = value.toString();
                  value = value.split(/(?=(?:...)*$)/);
                  value = value.join('.');
                  return `$ ${value}`;
            }
          }


        //
      },
      {
        id: 'Hours',
        type: 'linear',
        position: 'right',
        ticks: {
          max: 4000,
          min: 0,
          userCallback: function(value, index, values) {
                  value = value.toString();
                  value = value.split(/(?=(?:...)*$)/);
                  value = value.join('.');
                  return value;
              } // end callBack
        }
      }] // end yAxes arrays
    } // end scales
  } // end options
});


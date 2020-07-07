
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


//#########################################################################
//######################### Dashboard general performance##################
//#########################################################################


const overallPerformanceChart = document.getElementById('overallPerformance');

if (overallPerformanceChart) {
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
              duration: 4000
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

}

//#########################################################################
//######################### END OF CHART ##################################
//#########################################################################


//#########################################################################
//#########################Project general performance   ##################
//#########################################################################

const projectDashboard = document.getElementById("individualProjectChart");

if (projectDashboard) {

let milestoneData = JSON.parse(projectDashboard.dataset.milestoneValues)
milestoneData = Object.entries(milestoneData)

let actualData = JSON.parse(projectDashboard.dataset.actualValues);
actualData = Object.entries(actualData);

console.log(milestoneData);

// method to log the data of the milestones as an array of objects

const dataLogger = (arrayOfData) => {
  let arrayOfResults = [];
  arrayOfData.forEach( (array) => {
    let anObject = new Object;
    anObject.x = new Date(array[0]);
    anObject.y = array[1];
    arrayOfResults.push(anObject)
    });
  return arrayOfResults
  }

  const projectDashboardChart = new Chart(projectDashboard, {
    type: 'line',
    // data starts
    data: {
      datasets: [{
        data: dataLogger(actualData),
        label: "Budget evolution",
        borderColor: ['rgba(30, 51, 77, 1)'],
        backgroundColor: ['rgba(170, 239, 104, 0.0)'],
        borderWidth: 4,
        pointRadius: 0,
        pointHitRadius: 5
      }, // first dataset ends
      { // dataset 2
        data: dataLogger(milestoneData),
        borderColor: ['rgba(170, 239, 104, 0.9)'],
        backgroundColor: ['rgba(170, 239, 104, 0.2)'],
        label: "Evolution according to milestones"
      }
      ] // datasets end
    }, // data ends
    options: {
      animation: {
              duration: 4000
          },
      tooltips: {
          multiKeyBackground: '#1E334D',
          callbacks: {
            label: function(tooltipItem, data) {
              // console.log(data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].x)
              // console.log(data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].y)
              let tipValue = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].y
              tipValue = tipValue.toString();
              tipValue = tipValue.split(/(?=(?:...)*$)/);
              tipValue = tipValue.join(".");
              return `Cummulative budget: $ ${tipValue}`;
            }
          }, // end callbacks
        }, //end tooltips

      scales: { xAxes: [{
                    type: 'time',
                    //
                     time: {
              parser: 'DD/MM/YYYY',
              tooltipFormat: 'DD/MM/YYYY',
              unit: 'day',
              unitStepSize: 1,
              displayFormats: {
                'day': 'MM/YYYY'
              }
            },
                    //
                    ticks: {
                        autoSkip: true,
                        maxTicksLimit: 20
                    }
                }], // XAxes ends

                yAxes: [{
                  type: 'linear',
                  position: 'left',
                 ticks: {
                          beginAtZero: true,
                          userCallback: function(value, index, values) {
                            value = value.toString();
                            value = value.split(/(?=(?:...)*$)/);
                            value = value.join('.');
                            return `$ ${value}`;
                            }
                      } // yAxes ticks ends
                }] // yAxes ends
      }, // scales ends
      legend: {
        position: "bottom"
      } // legend ends

    } // options ends
  } // Chart definition ends
    ); // Chart new ends
} // conditional ends

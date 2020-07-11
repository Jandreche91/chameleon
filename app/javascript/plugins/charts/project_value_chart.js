//#########################################################################
//#########################Project general performance   ##################
//#########################################################################

const projectDashboard = document.getElementById("individualProjectChart");

if (projectDashboard) {

let milestoneData = JSON.parse(projectDashboard.dataset.milestoneValues)
milestoneData = Object.entries(milestoneData)

let actualData = JSON.parse(projectDashboard.dataset.actualValues);
actualData = Object.entries(actualData);

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
        pointHitRadius: 8
      }, // first dataset ends
      { // dataset 2
        data: dataLogger(milestoneData),
        borderColor: ['rgba(170, 239, 104, 0.9)'],
        backgroundColor: ['rgba(51, 133, 8, 0.1)'],
        label: "Evolution according to milestones",
        pointRadius: 5,
        pointHitRadius: 10,
        pointBorderColor: 'rgba(51, 133, 8, 0.9)',
        pointBackgroundColor: 'rgba(51, 133, 8, 0.2)',


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
      }, // legend ends
      maintainAspectRatio: false,
      responsive: true
    } // options ends
  } // Chart definition ends
    ); // Chart new ends
} // conditional ends




//#########################################################################
//######################### END OF CHART ##################################
//#########################################################################


require("datejs");
require("chart.js");



const initGeneralDashboardChart = () => {

  const overallPerformanceChart = document.getElementById('overallPerformance');



  const constructXAxisMonths = (months) => {
    let results = [];
    let date = Date.parse(Date.today());
    for (let i =1; i <= months; i++) {
      let month = date.toString('MMM yy');
      results.push(month);
      date = Date.parse(date).add(-1).month();
    }
    return results.reverse()
  };

  if (overallPerformanceChart) {

    const dataHoursSpent = JSON.parse(overallPerformanceChart.dataset.hoursSpent);
    const dataValueSpent = JSON.parse(overallPerformanceChart.dataset.value);


    const overallPerformanceDraw = new Chart(overallPerformanceChart, {
      type: 'line',
      data: {
        labels: constructXAxisMonths(12),
        datasets: [
        {
          label: 'Billed',
          yAxisID: 'Billed',
          data: dataValueSpent,
          borderColor: ['#B37600'],
          backgroundColor: ['rgba(170, 239, 104, 0.0)'],
          borderWidth: 4,
          pointRadius: 2,
          pointHitRadius: 5,
          pointBackgroundColor: '#B37600',
          pointBorderColor:'#B37600'
          },
        {
          label: 'Hours spent',
          yAxisID: 'Hours',
          data: dataHoursSpent,
          borderColor: ['#7900B3'],
          backgroundColor: ['rgba(170, 239, 104, 0.0)'],
          borderWidth: 4,
          pointRadius: 2,
          pointHitRadius: 5,
          pointBackgroundColor: '#7900B3',
          pointBorderColor: '#7900B3'
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
        }, // end scales
        maintainAspectRatio: false,
      } // end options
    });
  //#########################################################################
  //######################### END OF CHART ##################################
  //#########################################################################
  } //  end of conditional
} // end of function to export

export default initGeneralDashboardChart

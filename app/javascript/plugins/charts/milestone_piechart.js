
require("chart.js");


  const initMilestonePiechart = () => {

  const milestoneProgressCanvas = document.getElementById("milestone-pie-chart")

  if (milestoneProgressCanvas){
    // let milestoneProgressData = milestoneProgressCanvas.dataset.milestoneProgressRates
    // milestoneProgressData = JSON.parse(milestoneProgressData);
    // milestoneProgressData = Object.entries(milestoneProgressData);

    // index 0 is labels and index 1 is values
    // let labelsValues = [[],[]];

    // populate the array with the data gathered from the HTML

    // milestoneProgressData.forEach( (arrayOfData) => {
    //   labelsValues[0].push(arrayOfData[0]);
    //   labelsValues[1].push(arrayOfData[1]);
    // });

    // assing to different variables

    const myLabels = JSON.parse(milestoneProgressCanvas.dataset.milestoneDescriptions);
    const myValues = JSON.parse(milestoneProgressCanvas.dataset.milestoneValues);
    const myColors = JSON.parse(milestoneProgressCanvas.dataset.milestoneColors);

    // array of colors to be used by the chart




    //automatically create an array of colors based on the length

    // let myColors = arrayOfColors.slice(0,myLabels.length)


    // create the piechart

    const milestonePieChart = new Chart(milestoneProgressCanvas,{
      type: 'doughnut',
      data: {
        labels: myLabels,
        datasets:[{
          data: myValues,
          backgroundColor: myColors,
        borderColor: myColors,
        borderWidth: 1
        }] // end datasets
      }, // end data
      options: {
        legend: {
          display: false}, // end legend

          //

          tooltips: {
            callbacks: {
              label: function(tooltipItem, data) {
                let value = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
                let label = data.labels[tooltipItem.index]
                value = value.toString();
                value = value.split(/(?=(?:...)*$)/);
                value = value.join('.');
                return `${label}: $${value}`
                }
              } //end callbacks
            }, // end tooltips
            // layout: {
            //     padding: {
            //         left: 0,
            //         right: 0,
            //         top: 0,
            //         bottom: 25
            //     }
            //   }
          } //  // end options

          //
    }); // end of piechart
  } // end of conditional

} // end of function

export default initMilestonePiechart


console.log("This file is charging!")

const milestoneProgressCanvas = document.getElementById("milestone-pie-chart")

if (milestoneProgressCanvas){
  let milestoneProgressData = milestoneProgressCanvas.dataset.milestoneProgressRates
  milestoneProgressData = JSON.parse(milestoneProgressData);
  milestoneProgressData = Object.entries(milestoneProgressData);

  // index 0 is labels and index 1 is values
  labelsValues = [[],[]];

  // populate the array with the data gathered from the HTML

  milestoneProgressData.forEach( (arrayOfData) => {
    labelsValues[0].push(arrayOfData[0]);
    labelsValues[1].push(arrayOfData[1]);
  });

  // assing to different variables

  const myLabels = labelsValues[0];
  const myValues = labelsValues[1];

  // array of colors to be used by the chart

  const arrayOfColors = [
        'rgba(255,99,132,1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(170, 239, 104, 1)',
        'rgba(144, 12, 63, 1)',
        'rgba(248, 169, 22,1)',
        'rgba(51, 133, 8, 1)',
        'rgba(28, 104, 172, 1)'];

  //automatically create an array of colors based on the length



  // create the piechart

  const milestonePieChart = new Chart(milestoneProgressCanvas,{
    type: 'doughnut',
    data: {
      labels: myLabels,
      datasets:[{
        data: myValues,
        backgroundColor: [
        'rgba(255, 99, 132, 0.5)',
        'rgba(54, 162, 235, 0.2)',
        'rgba(255, 206, 86, 0.2)',
        'rgba(75, 192, 192, 0.2)'
      ],
      borderColor: [
        'rgba(255,99,132,1)',
        'rgba(54, 162, 235, 1)',
        'rgba(255, 206, 86, 1)',
        'rgba(75, 192, 192, 1)'
      ],
      borderWidth: 1
      }] // end datasets
    }, // end data
    options: {
      legend: {
        position: 'bottom'}
    }

  });
}



const ProgressBar = require('progressbar.js');


// constant with an array of the ids of the project

let projects = document.getElementById("projects-general-view")



// method to adjust colors in progressbars according to progression of container

const colorPicker = (container) => {

  const getColor = parseFloat(container.dataset.percentage);

  if (getColor < 0.4) {
    return '#338508'
  } else if (getColor < 0.8) {
    return '#1C68AC'
  } else {
    return '#900C3F'
  };
};


if (projects) {

projects = projects.dataset.array;
projects = JSON.parse(projects);


// method to generate progressbars


const barGenerator = (container) => {

          let bar = new ProgressBar.Line( container ,{
                  strokeWidth: 4,
                  easing: 'easeInOut',
                  duration: 1400,
                  color: '#AAEF68',
                  trailColor: '#E2EAF4',
                  trailWidth: 4,
                  svgStyle: {width: '100%', height: '12px'},
                  from: {color: '#AAEF68'},
                  to: {color: colorPicker(container)},
                  step: (state, bar) => {
                    bar.path.setAttribute('stroke', state.color);
                  }
                });

        bar.animate(parseFloat(container.dataset.percentage));  // Number from 0.0 to 1.0
      }; // end of barGeneratorBudget


// method to generate progressbars (time)





// iterate to render all progression bars in the project

projects.forEach( (projectId) => {

let budgetBar = document.getElementById(`${projectId}-budget-bar`);
let timeBar = document.getElementById(`${projectId}-time-bar`);
budgetBar.innerHTML = "";
timeBar.innerHTML = "";


  barGenerator(budgetBar);
  barGenerator(timeBar);
});


// barGenerator(projects[0]);

}

console.log("Progressbar page is loading!");








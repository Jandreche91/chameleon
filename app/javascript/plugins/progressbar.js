
const ProgressBar = require('progressbar.js');


// constant with an array of the ids of the project

let projects = document.getElementById("projects-general-view").dataset.array;
projects = JSON.parse(projects);

// method to generate progressbars (budget)


const barGenerator = (container) => {

          let bar = new ProgressBar.Line( container ,{
                  strokeWidth: 4,
                  easing: 'easeInOut',
                  duration: 1400,
                  color: '#AAEF68',
                  trailColor: '#E2EAF4',
                  trailWidth: 4,
                  svgStyle: {width: '100%', height: '100%'},
                  from: {color: '#AAEF68'},
                  to: {color: '#900C3F'},
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

  barGenerator(budgetBar);
  barGenerator(timeBar);
});


// barGenerator(projects[0]);


console.log("Progressbar page is loading!");








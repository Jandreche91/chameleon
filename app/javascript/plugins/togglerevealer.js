

// let manageMilestonesDashboard = document.getElementById("milestone-board")
// let buttonToggler = document.getElementById("button-toggler-milestone-dashboard");

// if (manageMilestonesDashboard) {

//   buttonToggler.addEventListener("click", (event) => {

//     event.preventDefault();
//       if (manageMilestonesDashboard.style.display === "none") {
//     manageMilestonesDashboard.style.display = "block";
//   } else {
//     manageMilestonesDashboard.style.display = "none";
//   }
// }
//   );
//   };


console.log("this page togglerevealer is loading!");

const header = document.getElementById("manage-ongoing-milestones");

const arrayOfMilestoneIds = JSON.parse(header.dataset.milestonesIds);

const budget = parseInt(header.dataset.budget);

const logTheValue = (id) => {
  let milestoneWeight = document.getElementById(`form-progress-milestone-${id}`);
  milestoneWeight.addEventListener("change", (event) => {
    console.log(milestoneWeight.value);
  });
}

arrayOfMilestoneIds.forEach( (id) => {
    logTheValue(id);
});



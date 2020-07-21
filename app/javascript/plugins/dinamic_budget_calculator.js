const initDinamicBudgetCalculator = () => {

const header = document.getElementById("manage-ongoing-milestones");

if (header) {

const arrayOfMilestoneIds = JSON.parse(header.dataset.milestonesIds);

const budget = parseInt(header.dataset.budget);

const logTheValue = (id) => {
  let milestoneWeight = document.getElementById(`form-progress-milestone-${id}`);
  let budgetValue = document.getElementById(`milestone-form-dollars-id-${id}`);

  budgetValue.innerText = `(USD ${parseInt(milestoneWeight.value) * budget / 100})`;


    milestoneWeight.addEventListener("change", (event) => {
    budgetValue.innerText = `(USD ${parseInt(milestoneWeight.value) * budget / 100})`;
    // console.log(milestoneWeight.value);
  });
}

arrayOfMilestoneIds.forEach( (id) => {

    logTheValue(id);
});

};

}; // end of the function to export


export default initDinamicBudgetCalculator

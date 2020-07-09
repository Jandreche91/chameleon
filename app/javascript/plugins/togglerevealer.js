

let manageMilestonesDashboard = document.getElementById("milestone-board")
let buttonToggler = document.getElementById("button-toggler-milestone-dashboard");

if (manageMilestonesDashboard) {

  buttonToggler.addEventListener("click", (event) => {

    event.preventDefault();
      if (manageMilestonesDashboard.style.display === "none") {
    manageMilestonesDashboard.style.display = "block";
  } else {
    manageMilestonesDashboard.style.display = "none";
  }
}
  );
  };

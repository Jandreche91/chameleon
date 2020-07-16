// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels");
require("datejs");



// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import "../plugins/flatpickr"

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import initProgressBar from '../plugins/progressbar';
import {togglerevealer} from '../plugins/togglerevealer.js';

// importing specific charts
import initUserChart from '../plugins/charts/user_chart';
import initProjectValueChart from '../plugins/charts/project_value_chart';
import initGeneralDashboardChart from '../plugins/charts/general_dashboard_chart';
import initMilestonePiechart from '../plugins/charts/milestone_piechart';


const toggleCard = () => {
  console.log('coucou')
  const userChoices = document.querySelectorAll('.user-choice');
  userChoices.forEach((item) => {
    console.log(item)
    item.addEventListener('click', (e) => {
      console.log(e.currentTarget)
      e.currentTarget.classList.toggle('active')
      const checkboxInput = e.currentTarget.querySelector('input')
      if (checkboxInput.checked == false) {
        checkboxInput.checked = true;
      } else {
        checkboxInput.checked = false;
      }
    })
  })
}

document.addEventListener('turbolinks:load', () => {
  toggleCard()

  // const userChoices = document.querySelectorAll(".user-choice");

  // userChoices.forEach((userChoice) => {
  //   userChoice.addEventListener('click', function(event) {
  //     console.log(event.currentTarget);
  //     const elementClicked = event.currentTarget;


  //     if (elementClicked.classList.contains("active")) {
  //       elementClicked.classList.remove("active");
  //     } else {
  //       elementClicked.classList.add("active");
  //     }
  //     // elementClicked.classList.toggle('active')


  //   })
  // })


  // Call your functions here, e.g:
  // initSelect2();
  // charts
  initUserChart();
  initProjectValueChart();
  initGeneralDashboardChart();
  initMilestonePiechart();

  // progress bars

  initProgressBar();
});

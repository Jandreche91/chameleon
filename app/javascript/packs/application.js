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


// importing specific charts
import initUserChart from '../plugins/charts/user_chart';
import initProjectValueChart from '../plugins/charts/project_value_chart';
import initGeneralDashboardChart from '../plugins/charts/general_dashboard_chart';
import initMilestonePiechart from '../plugins/charts/milestone_piechart';
import toggleCard from '../plugins/toggle_card';
import initDinamicBudgetCalculator from '../plugins/dinamic_budget_calculator';



document.addEventListener('turbolinks:load', () => {

  // togglecard is the method that manages the selection of users in the edit and new forms of projects

  toggleCard();

  // this function dinamically shows the budget in the update milestone forms

  initDinamicBudgetCalculator();

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

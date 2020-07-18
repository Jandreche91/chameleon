require("chart.js");

const initUserChart = () => {
  const canvas = document.querySelectorAll(".user-chart");
  canvas.forEach(canva => {
    const ctx = canva.getContext('2d')
    let projects
    let data
    let label
    let color
    if (canva.dataset.projectsHours) {
      const projectsHours = JSON.parse(canva.dataset.projectsHours)
      projects = projectsHours.projects
      data = projectsHours.hours
      label = ' Hours spent per project'
      color = '#7900B3'
    } else {
      const projectsBudgets = JSON.parse(canva.dataset.projectsBudgets)
      projects = projectsBudgets.projects
      data = projectsBudgets.budgets
      label = ' Budgets spent per project'
      color = '#B37600'
    }
    const myChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: projects,
            datasets: [{
                label: label,
                data: data,
                backgroundColor: color,
                borderColor: [
                ],
                borderWidth: 1
            }]
        },
        options: {
          // responsive: true,
            scales: {
                yAxes: [{
                  barThickness : 30,
                  categorySpacing: 0,
                  barPercentage:1,
                  categoryPercentage: 0.3,
                  ticks: {
                      beginAtZero: true,
                    }
                }]
            }
        }
    });
  })
}

export default initUserChart

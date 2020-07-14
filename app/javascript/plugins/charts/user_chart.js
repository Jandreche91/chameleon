require("chart.js");

const initUserChart = () => {
  const canvas = document.querySelectorAll(".user-chart");
  canvas.forEach(canva => {
    const ctx = canva.getContext('2d')
    console.log(canva.dataset.projectsHours)
    const projectsHours = JSON.parse(canva.dataset.projectsHours)
    const projects = projectsHours.projects
    const hours = projectsHours.hours
    const myChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: projects,
            datasets: [{
                label: '# of Votes',
                data: hours,
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
  })
}

export default initUserChart

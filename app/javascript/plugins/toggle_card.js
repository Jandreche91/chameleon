const toggleCard = () => {
  const userChoices = document.querySelectorAll('.user-choice');
  userChoices.forEach((item) => {
    item.addEventListener('click', (e) => {
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

export default toggleCard

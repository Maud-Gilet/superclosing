const formField = document.getElementById("form-add-investor-toggle");
const buttonAdd = document.getElementById("btn-add-investor");


const displayInvestorForm = (data) => {
  buttonAdd.addEventListener('click', (event) => {
    if (formField.className === 'hidden') {
      formField.className = "";
    } else {
      formField.className = "hidden";
    }

  });
};

export { displayInvestorForm };

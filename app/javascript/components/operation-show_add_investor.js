const formField = document.getElementById("form-add-investor-toggle");
const buttonAdd = document.getElementById("btn-add-investor");
const buttonAddDiv = document.getElementById("add-investor-btn-show");
const submitButtonAdd = document.getElementById("submit-add-investor");

const displayInvestorForm = (data) => {
  buttonAdd.addEventListener('click', (event) => {
    buttonAddDiv.innerHTML = "";
    formField.className = "";
  });
};

export { displayInvestorForm };

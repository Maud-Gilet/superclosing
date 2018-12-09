const formField = document.querySelector(".operation_category");
const categoryField = document.getElementById("operation_category");

const displayOperationForm = (data) => {
  categoryField.addEventListener('change', (event) => {
    if (event.currentTarget.value === "Levée de fonds") {
      document.getElementById("form-fundraising").className = "";
    };
    if (event.currentTarget.value !== "Levée de fonds") {
      document.getElementById("form-fundraising").className = "hidden";
    };
  });
};

export { displayOperationForm };

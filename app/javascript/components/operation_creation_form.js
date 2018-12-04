const categoryField = document.getElementById("operation_category");
const dateField = document.getElementById("operation_date")

const displayOperationForm = (data) => {
  categoryField.addEventListener('change', (event) => {
    if (event.currentTarget.value === "Levée de fonds") {
      categoryField.insertAdjacentHTML('afterend', `<a href="/companies/2/operations">Cancel</a>`)
      categoryField.insertAdjacentHTML('afterend', `<input type="submit" name="commit" value="Create Operation" class="btn" data-disable-with="Create Operation">`)
      categoryField.insertAdjacentHTML('afterend', `<div> <label class="control-label" for="date">Date</label>
        <input class="form-control" id="date" name="operation[expected_closing_date]" placeholder="MM/DD/YYY" type="text"/> </div>`)
      categoryField.insertAdjacentHTML('afterend',`<div class="form-group integer optional operation_target_amount_cents form-group-valid"><label class="form-control-label integer optional" for="operation_target_amount_cents">Quel est le montant visé ?</label><input class="form-control is-valid numeric integer optional" type="number" step="1" value="0" name="operation[target_amount_cents]" id="operation_target_amount_cents"></div>`);
  };
  });
};


export { displayOperationForm };

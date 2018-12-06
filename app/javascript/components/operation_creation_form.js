const formField = document.querySelector(".operation_category");
const categoryField = document.getElementById("operation_category");

const displayOperationForm = (data) => {
  categoryField.addEventListener('change', (event) => {
    if (event.currentTarget.value === "Levée de fonds") {
      formField.insertAdjacentHTML('afterend', `<div><button type="button" class="btn btn-cancel-operation">Annuler</button></div>`)
      formField.insertAdjacentHTML('afterend', `<div><button type="submit" class="btn btn-create-operation">Créer</button></div>`)
      formField.insertAdjacentHTML('afterend', `<div> <label class="control-label" for="date">Date de clôture envisagée</label>
        <input class="form-control" id="date" name="operation[expected_closing_date]" placeholder="JJ/MM/AAAA" type="text"/> </div>`)
      formField.insertAdjacentHTML('afterend',`<div class="form-group integer optional operation_target_amount_cents form-group-valid"><label class="form-control-label integer optional" for="operation_target_amount_cents">Montant visé ? (€) </label><input class="form-control is-valid numeric integer optional" type="number" step="1000" value="0" name="operation[target_amount_cents]" id="operation_target_amount_cents"></div>`);
    formField.insertAdjacentHTML('afterend',`<div class="form-group integer optional operation_premoney_cents form-group-valid"><label class="form-control-label integer optional" for="operation_premoney_cents">Valorisation pre-money? (€) </label><input class="form-control is-valid numeric integer optional" type="number" step="1000" value="0" name="operation[premoney_cents]" id="operation_premoney_cents"></div>`);
  };
  });
};

export { displayOperationForm };

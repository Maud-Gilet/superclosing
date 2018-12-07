const formField = document.querySelector(".operation_category");
const categoryField = document.getElementById("operation_category");

const displayOperationForm = (data) => {
  categoryField.addEventListener('change', (event) => {
    if (event.currentTarget.value === "Levée de fonds") {
      formField.insertAdjacentHTML('afterend', `<div class="buttons-new-operation"><button type="submit" class="btn btn-create-operation">Créer</button><button type="button" class="btn btn-cancel-operation">Annuler</button></div>`)
      formField.insertAdjacentHTML('afterend', `<div> <label class="control-label" for="date">Date de clôture envisagée</label>
        <input class="form-control" id="date" name="operation[expected_closing_date]" placeholder="JJ/MM/AAAA" type="text"/> </div>`)
      formField.insertAdjacentHTML('afterend',`<div class="form-group integer optional operation_target_amount form-group-valid"><label class="form-control-label integer optional" for="operation_target_amount">Montant visé ? (€) </label><input class="form-control is-valid numeric integer optional" type="number" step="1000" value="0" name="operation[target_amount]" id="operation_target_amount"></div>`);
    formField.insertAdjacentHTML('afterend',`<div class="form-group integer optional operation_premoney form-group-valid"><label class="form-control-label integer optional" for="operation_premoney">Valorisation pre-money? (€) </label><input class="form-control is-valid numeric integer optional" type="number" step="1000" value="0" name="operation[premoney]" id="operation_premoney"></div>`);
  };
  });
};

export { displayOperationForm };

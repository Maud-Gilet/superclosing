const inputSiren = document.getElementById('company-siren-field');
const inputName = document.getElementById('company-name-field');
const inputAddress = document.getElementById('company-address-field');
const inputLegalForm = document.getElementById('company-legal-form-field');
const inputCreationDate = document.getElementById('company-creation-date-field');
const inputFiscalDate = document.getElementById('company-fiscal-date-field');

const drawResponse = (data) => {

  const name = data.siege_social.nom_raison_sociale;
  const address = data.siege_social.geo_adresse;
  const legalForm = data.siege_social.libelle_nature_juridique_entreprise;
  const creationDate = data.siege_social.date_debut_activite;

  inputName.value = name;
  inputAddress.value = address;
  inputLegalForm.value = legalForm;
  inputCreationDate.value = creationDate;
};

const autocomplete = (event) => {
  const sirenQuery = inputSiren.value;
  const url = `https://entreprise.data.gouv.fr/api/sirene/v1/siren/${sirenQuery}`;
  fetch(url, {
    headers: {'Authorization': 'Bearer 1301b165-dc2e-327f-aa1b-1366e2698423'}
  })
    .then(response => response.json())
    .then(data => drawResponse(data));
};

const autocompleteApiSirene = () => {
  inputSiren.addEventListener('change', autocomplete);
};

export { autocompleteApiSirene };

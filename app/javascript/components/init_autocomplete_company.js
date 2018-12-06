const inputSirenForm = document.getElementById('company_siren');
const inputName = document.getElementById('company_name');
const inputAddress = document.getElementById('company_address');
const inputLegalForm = document.getElementById('company_legal_form');
const inputCreationDate = document.getElementById('company_creation_date');

const drawResponse = (data) => {

console.log(data);
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
  const sirenQuery = event.currentTarget.value;
  const url = `https://entreprise.data.gouv.fr/api/sirene/v1/siren/${sirenQuery}`;
  fetch(url, {
    headers: {'Authorization': 'Bearer 7cc91bfa-cf8d-396e-9df2-56fc40ee08d2'}
  })
    .then(response => response.json())
    .then(data => drawResponse(data));
};

const autocompleteApiSirene = () => {
  inputSirenForm.addEventListener('focusout', autocomplete);
};

export { autocompleteApiSirene };

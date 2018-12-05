const inputSirenForm = document.getElementById('company_siren');
const inputName = document.getElementById('company_name');
const inputAddress = document.getElementById('company_address');
const inputLegalForm = document.getElementById('company_legal_form');
const inputCreationDate = document.getElementById('company_creation_date');

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
  const sirenQuery = event.currentTarget.value;
  const url = `https://entreprise.data.gouv.fr/api/sirene/v1/siren/${sirenQuery}`;
  fetch(url, {
    headers: {'Authorization': 'Bearer bfd874df-3924-3396-b372-541e25bbfbd9'}
  })
    .then(response => response.json())
    .then(data => drawResponse(data));
};

const autocompleteApiSirene = () => {
  inputSirenForm.addEventListener('focusout', autocomplete);
};

export { autocompleteApiSirene };

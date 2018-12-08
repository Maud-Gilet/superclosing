import "bootstrap";

// Datepicker for form (import from Node package)
import flatpickr from 'flatpickr';
import { French } from "flatpickr/dist/l10n/fr.js"
import 'flatpickr/dist/flatpickr.min.css';

// Autofilling fields (adding a company) when typing SIREN number of this company
import { autocompleteApiSirene } from '../components/init_autocomplete_company';
// Display subform when adding new operation
import { displayOperationForm } from '../components/operation_creation_form';

// Display graphs
import { graph } from '../components/init_operation_graph'
import { graphsecond } from '../components/init_operation_secondgraph'

// Dynamic text for landing page banner
import { loadDynamicBannerText } from '../components/typed_landing';


// Functions calls

if(document.querySelector('.datepicker')) {
  flatpickr(".datepicker", {
    "locale": French,
    altInput: true,
    altFormat: "d-m-Y",
    dateFormat: "Y-m-d",
  });
}

if(document.getElementById('company_siren')){
 autocompleteApiSirene();
}

if(document.getElementById("operation_category")){
  displayOperationForm();
}

if(document.getElementById('myChart')){
 graph();
}
if(document.getElementById('mySecondChart')){
 graphsecond();
}

if(document.getElementById('typed_text')){
  loadDynamicBannerText();
}

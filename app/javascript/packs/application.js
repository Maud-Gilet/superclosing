import "bootstrap";

import { displayOperationForm } from '../components/operation_creation_form';
import { autocompleteApiSirene } from '../components/init_autocomplete_company';

import { graph } from '../components/init_operation_graph'

if(document.getElementById('myChart')){
 graph();
}
if(document.getElementById("operation_category")){
displayOperationForm();
}
if(document.getElementById('company_siren')){
 autocompleteApiSirene();
}



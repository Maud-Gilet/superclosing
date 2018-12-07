import "bootstrap";

import { autocompleteApiSirene } from '../components/init_autocomplete_company';
import { displayOperationForm } from '../components/operation_creation_form';

import { graph } from '../components/init_operation_graph'
import { graphsecond } from '../components/init_operation_secondgraph'
import { loadDynamicBannerText } from '../components/typed_landing';

if(document.getElementById('myChart')){
 graph();
}
if(document.getElementById('mySecondChart')){
 graphsecond();
}
if(document.getElementById("operation_category")){
displayOperationForm();
}
if(document.getElementById('company_siren')){
 autocompleteApiSirene();
}

if(document.getElementById('typed_text')){
loadDynamicBannerText();
}

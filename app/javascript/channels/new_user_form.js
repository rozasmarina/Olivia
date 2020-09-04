let options = document.querySelectorAll('.businessaccount');

let optionpf = options[0];
let optionpj = options[1];

optionpf.addEventListener('click', () => {
  $('#pjfield').hide();
  $('#pffield').show();
});

optionpj.addEventListener('click', () => {
  $('#pjfield').show();
  $('#pffield').hide();
});

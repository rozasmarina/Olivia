let options = document.querySelectorAll('.businessaccount');

if (options) {
    let optionpf = options[0];
    let optionpj = options[1];

    if (optionpf) {
        optionpf.addEventListener('click', () => {
            $('#pjfield').hide();
            $('#pffield').show();
        });
    }

    if (optionpj) {
        optionpj.addEventListener('click', () => {
            $('#pjfield').show();
            $('#pffield').hide();
        });
    }
}
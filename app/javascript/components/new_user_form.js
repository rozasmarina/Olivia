// let businessChoice = document.querySelectorAll('.businessaccount');

// let pf = options[0];
// let pj = options[1];

// pf.addEventListener('click', () => {
//   $('#pjfield').hide();
//   $('#pffield').show();
// });

// pj.addEventListener('click', () => {
//   $('#pjfield').show();
//   $('#pffield').hide();
// });

let businessAccount = document.querySelectorAll('.businessaccount');

if (businessAccount) {
    $(document).on('change','.businessaccount', () => {
        $(document).on('click', () => {
              if($("#user_is_business_true").is(':checked') && !$("#user_is_business_false").is(':checked')) {
                  $('#pjfield').show();
                  $('#pffield').hide();
              }else {
                  $('#pjfield').hide();
                  $('#pffield').show();
              }
        });
    });
};

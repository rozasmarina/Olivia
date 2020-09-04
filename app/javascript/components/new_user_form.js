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



$(document).on('change','.evaluation', () => {
  $(document).on('click', () => {
      if($("#review_is_good_false").is(':checked') && !$("#review_is_good_true").is(':checked')) {
          $('#anonymous').show();
      }else{
          $('#anonymous').hide();
      }
  });
});
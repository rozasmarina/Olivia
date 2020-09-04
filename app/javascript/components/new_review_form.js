console.log("New review form")
// let experience = document.querySelectorAll('.evaluation');

// let good = experience[0];
// let bad = experience[1];
// console.log(good)
// console.log(bad)
// good.addEventListener('click', () => {
//   $('#anonymous').hide();
// });

// bad.addEventListener('click', () => {
//   $('#anonymous').show();
// });

let experience = document.querySelectorAll('.evaluation');
if (experience) {
    $(document).on('change','.evaluation', () => {
        $(document).on('click', () => {
            if($("#review_is_good_false").is(':checked') && !$("#review_is_good_true").is(':checked')) {
                $('#anonymous').show();
            }else{
                $('#anonymous').hide();
            }
        });
    });
};

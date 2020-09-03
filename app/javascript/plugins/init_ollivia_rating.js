import "jquery-bar-rating";
// import $ from 'jquery'; // <-- if you're NOT using a Le Wagon template (cf jQuery section)

const initOlliviaRating = () => {
    $('#ollivia_rating').barrating({
        theme: 'css-stars',
        allowEmpty: true
      });
};

export { initOlliviaRating };
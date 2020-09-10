// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("components/new_user_form.js")
require("components/new_review_form.js")
require("components/ratings_with_icons.js")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css';

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { initMapbox } from '../plugins/init_mapbox';
import { getRating } from '../components/ratings_with_icons.js';
import { formBusiness } from '../components/new_user_form.js';
import { formReview } from '../components/new_review_form.js';
import { initToast } from '../components/toast.js'
import { initNotificationChannel } from '../channels/notification_channel';

document.addEventListener('turbolinks:load', () => {
    // Call your functions here, e.g:
    // initSelect2();
    getRating();
    initMapbox();
    formBusiness();
    formReview();
    initToast();
    initNotificationChannel();
});

import "controllers"
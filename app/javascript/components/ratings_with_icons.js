// Rating
let rating = document.getElementById("number-rating");
// Total icons
let iconTotal = 5;

// Run getRating when DOM loads
if (rating) {
    document.addEventListener('DOMContentLoaded', getRating);
};


// Get rating
function getRating() {
    // Get percentage
    const iconPercentage = (rating.innerHTML / iconTotal) * 100;
    console.log(iconPercentage)
        // Round to nearest
    const iconPercentageRounded = `${Math.round(iconPercentage / 10) * 10}%`;
    console.log(iconPercentageRounded)
        // Set width of rates-inner to percentage
    document.querySelector('.rates-inner').style.width = iconPercentageRounded;
};
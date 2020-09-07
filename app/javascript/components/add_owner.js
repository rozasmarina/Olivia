let hasPlace = document.getElementById('place-exists');
if (hasPlace) {
    $(document).on('click','#place-exists', () => {
        $('#add-place-to-owner').toggle();
    });
};
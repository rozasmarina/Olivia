const initToast = () => {
    $('.toast').toast({
        'autohide': false
      });
    
      $('.toast').toast('show');
};

export { initToast }
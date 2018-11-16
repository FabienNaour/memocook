
document.addEventListener("DOMContentLoaded", () => {
  //get moadals by class name

  const modals = document.querySelectorAll(".iframemodal");

  //if no modals, return
  if(!modals.length)
    return;

  //on efface les modals quant on clique sur quitte ou a coté de la modal
  $('#myModal').on('hide.bs.modal',() => {
    document.querySelectorAll('#myModal iframe').forEach((iframe)=>{
      setIframeLink(iframe,'');
    });
  })

  //for each modal, we will listen for a click and bind click with named function
    modals.forEach((link) => {
      link.addEventListener("click", bindModalClick);
    });

  });

//Set ifram src

  const setIframeLink = (iframe, value) => {
      iframe.src = value
  }


  const bindModalClick = (event) => {
      //event.preventDefault();

      //set all iframe srcs
       document.querySelectorAll('#myModal iframe').forEach((iframe)=>{

      setIframeLink(iframe,event.currentTarget.dataset.value);


    });

     //open modal with JQuery
     $('#myModal').modal();
}


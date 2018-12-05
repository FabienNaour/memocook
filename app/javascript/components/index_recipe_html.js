
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

/////////////////////////////////////////////
document.addEventListener("DOMContentLoaded", () => {
const modales = document.querySelectorAll(".iframemodale");

  //if no modals, return
  if(!modales.length)
    return;

  //on efface les modals quant on clique sur quitte ou a coté de la modal
  $('#myModale').on('hide.bs.modal',() => {
    document.querySelectorAll('#myModale iframe').forEach((iframe)=>{
      setIframeLinke(iframe,'');
    });
  })

  //for each modal, we will listen for a click and bind click with named function
    modales.forEach((link) => {
      link.addEventListener("click", bindModalClicke);
    });

  });

//Set ifram text

  const setIframeLinke = (iframe, value) => {
      iframe.innerText = value
  }


  const bindModalClicke = (event) => {
      //event.preventDefault();

      //set all iframe srcs
       document.querySelectorAll('#myModale p').forEach((iframe)=>{

      setIframeLinke(iframe,event.currentTarget.dataset.value);


    });
      document.querySelectorAll('#myModale h3').forEach((iframe)=>{

      setIframeLinke(iframe,event.currentTarget.dataset.name);


    });
     //open modal with JQuery
     $('#myModale').modal();
}

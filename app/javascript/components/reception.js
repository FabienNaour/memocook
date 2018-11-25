$(document).ready(function(){
  $(".category-choice").click(function(){

    $(this).toggleClass("active");

  });
});


$(document).ready(function(){
  $(".category-choice0").click(function(){
    $(this).toggleClass("active");
  });
});

$(document).ready(function(){
  $(".category-choice1").click(function(){
    $(this).toggleClass("active");
  });
});

$(document).ready(function(){
  $(".category-choice-avatar").click(function(){

     document.querySelectorAll('.category-choice-avatar').forEach((iframe)=>{
      $(iframe).removeClass("active");

    });
    $(this).toggleClass("active");
  });
});

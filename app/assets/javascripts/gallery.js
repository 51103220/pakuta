$(document).ready(function(){
	$(".close-button").click(function(e){
		e.preventDefault(); 
		$("body").removeAttr("style");
		$('.gallery #review-img').hide();
		$('.gallery #review-img').removeAttr("id","review-img");
		//$(".gallery .closeImg-btn").hide();
		$(".gallery .close-button").hide();
		$(".gallery .nextImg-btn").hide();
		$(".gallery .prevImg-btn").hide();
	});
	$(".gallery .gl-item").on("click", function(event){
		event.preventDefault();
		$("a.close-button").css("display","block");
		//$(".gallery .closeImg-btn").show(); //this is the dark background behind the images in "review mode"
		$(".gallery .nextImg-btn").show();
		$(".gallery .prevImg-btn").show();
		

		if($(".gallery ul li").index($(this))== 0) { //if the clicked picture is the first picture, then hide the "prev image" button.
			$(".gallery .prevImg-btn").hide();
	}
		if($(".gallery ul li").index($(this)) == $(".gallery ul li").length - 1 ) { //if the clicked picture is the last picture, then hide the "next image" button.
			$(".gallery .nextImg-btn").hide();
	}
		$(this).find('.gl-preview').attr("id", "review-img"); //add the review-img -Id to the clicked image (makes the image larger) 
		//alert($(this).find('.gl-preview').html());
		$("body").css("overflow","hidden");
		$(this).find('.gl-preview').show();
	});
	$("ul.gallery .gl-item .gl-preview .gl-preview-wrapper").click(function(){ //when the black background is clicked, the user will be taken back to the "gallery view" and all the elements associated with the "review mode" are hidden
		$(".close-button").click();
	});
	$(".cm-title a").click(function(){
		window.location.replace($(this).attr('href'));
	});
});
//IMAGE NAVIGATION BUTTONS
$(document).ready(function(){

	$(".gallery .nextImg-btn").on("click", function() {
		var activeImage = $("ul.gallery .gl-item").find("#review-img");
		 //find the image with the ID "review-img" and save it in the variable
		var activeParentDiv = $(activeImage).parent(); //save the parent element of the image with "review-img"-ID to this variable
		$(".gallery .prevImg-btn").show(); //when the user clicks the first picture, the image is shown without the prev-button. This will make sure that the prev-button appears after the user clicks the "next image"-button
		if ($("ul.gallery .gl-item").index($(activeParentDiv)) + 1 == $("ul.gallery .gl-item").length-1) { //if the next picture is the last picture of the container, then hide the "next image" button.
			$(".gallery .nextImg-btn").hide();
			$(".gallery .prevImg-btn").show();
		}
		$(activeImage).hide();
		$(activeImage).removeAttr("id", "review-img"); //remove the "review-img"-ID from the picture
		$(activeParentDiv).next("li").find(".gl-preview").attr("id", "review-img"); //find the picture next to the current picture and add the review-img-ID to it, i.e. next pictuer will be shown.
		$(activeParentDiv).next("li").find(".gl-preview").show();
	});

	$(".gallery .prevImg-btn").on("click", function() { //Same things happen in this section that happen in the above one, just in reverse.
		var activeImage = $("ul.gallery .gl-item").find("#review-img");
		var activeParentDiv = $(activeImage).parent();
		$(".gallery .nextImg-btn").show(); 
		if($("ul.gallery .gl-item").index($(activeParentDiv)) - 1 == 0) { //if the next picture is the first picture of the container, then hide the "previous image" button.
			$(".gallery .prevImg-btn").hide();
		$(".gallery .nextImg-btn").show();
	}
	$(activeImage).hide();
		$(activeImage).removeAttr("id", "review-img"); //remove the "review-img"-ID from the picture
		$(activeParentDiv).prev("li").find(".gl-preview").attr("id", "review-img"); //find the picture next to the current picture and add the review-img-ID to it, i.e. next pictuer will be shown.
		$(activeParentDiv).prev("li").find(".gl-preview").show();
	});
	$("body").keydown(function(e) {
	  if(e.keyCode == 37) { // left
	  	if ($(".gallery .prevImg-btn").css('display') != 'none')
	  		$(".gallery .prevImg-btn").click();
	  }
	  if(e.keyCode == 27) { // left
	  		$(".close-button").click();
	  }
	  else if(e.keyCode == 39) { // right
	  	if ($(".gallery .nextImg-btn").css('display') != 'none')
	  		$(".gallery .nextImg-btn").click();
	  }
	});
});

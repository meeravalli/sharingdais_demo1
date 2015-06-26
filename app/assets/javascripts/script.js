$(function(){
	$('.header.blk-header').css({'background':'#000'});
	$(window).scroll(function(){
		if($(window).scrollTop() >100){
		$('.header').css({'background':'#000'});
	}
	else { 
		if($(window).width() > 850){ $('.header').css({'background':'rgba(0,0,0,0.6)'});
		$('.header.blk-header').css({'background':'#000'}); }}
	});
	
	 $('.header .login .sign-btn').click(function(){
		$('.sign').toggle();
	}); 
	if($('.carousel-inner .item').hasClass('active')){
		slidenav();
	}
function slidenav(){
	var current = $('.carousel-inner .item.active p.head').text();
	$('.nav ul li a').each(function(i){
		var value = $(this).text();
		if(value == current) {
			$('.nav ul li a').eq(i).addClass('active');
		}
	});
}
// Lightbox
$('.light').click(function(){
	var val = $(this).data('box');
	$('.lightbox').css({'display':'block'});
	$('.lightbox').find('.'+val).css({'display':'block'});
	//$('.lightbox .post').load('postrequirementcar.php');
	$('.close-bx').click(function(){
		close();
	});
	$('body').off('keyup').on('keyup', function(e){
		        	var code = (e.keyCode ? e.keyCode : e.which);
		        	// Escape
					if(code == 27) close();
		        	
				});
    function close(){
    $('.lightbox').hide();
		$('.lightbox .register,.lightbox .list,.lightbox .post').css({'display':'none'});
		} 
});

//Profile 
$('.profile-bx .rgt .row .shows').click(function(){
	$(this).hide();
	var value = $(this).html();
	$(this).next().show();
	
});
$('.profile-bx  .rgt .row .hides').focusout(function(){
	var newval = $(this).val();
	$(this).prev().html(newval);
	$(this).hide();
	$(this).prev().show();
});
// On Changing Radio Btn 

$('.carousel-caption .food').change(function(){
var values = $(this).data('food');
$('.food-chg').html(values);
$('input.food-chg').attr('placeholder',values);
if(values == "I'm"){
	//$('select#bulkdeal').find('option').remove();
	//$('select#bulkdeal').append("<option>A Caterer</option><option>A Chef</option><option>Looking for a Caterer</option><option>Looking for a Chef</option>");
	$('input.food-chg').hide();
	if($('input.food-chg').siblings().length<1){
	$('input.food-chg').parent().append("<select class='form-control'><option>A Caterer</option><option>A Chef</option><option>Looking for a Caterer</option><option>Looking for a Chef</option></select>").show();}
	$('input.food-chg').siblings().hide();
	$('input.food-chg').parent().find('select').show();
	$('label.bulk-dl').html('No.of.Guest');
	$('select.bulk-dl').hide();
	$('select.bulk-dl').parent().append("<input class='form-control' type='text' />");
	$('select.bulk-dl').parent().parent().removeClass('col-md-2').addClass('col-md-4');
	$('input.bulk-dl').attr('placeholder','No.of.Guest');
	$('.bulk-rmv').hide();
	
}
else {
	
	if($('.bulk-dl').html()=='No.of.Guest'){
	$('.bulk-rmv').show(); 
	$('.bulk-dl').parent().parent().removeClass('col-md-4').addClass('col-md-2');
	$('input.food-chg').siblings().hide();
	$('input.food-chg').show();
	$('label.bulk-dl').html('Meal');
	$('select.bulk-dl').attr('placeholder','Meal');
	$('select.bulk-dl').siblings().hide();
	$('select.bulk-dl').show();
	}
	
	$('select#bulkdeal').find('option').remove();
	$('select#bulkdeal').append("<option value=''>Bangalore</option><option value=''>Chennai</option><option value=''>Mumbai</option>");
	$('#people').html('at');
}
});	
$('.carousel-caption .book').click(function(){
var value = $(this).data('book');
$('.book-chg').html(value);
$('input.book-chg').attr('placeholder',value);
});
$('.carousel-caption .car').click(function(){
var value = $(this).data('car');
$('.car-chg').html(value);
$('input.car-chg').attr('placeholder',value);
});

// Mobile
if($(window).width() < 850){
	$('.nav-mob').click(function(){
		$(this).next().toggle();
	});
}
if($(window).width() < 650){ 
	$('.sign-btn').html("<span class='fa fa-sign-in'></span>");
	}
// Lightbox
$('.nivo-lightbox-wrap').css('top', $(window).scrollTop() + 100 + 'px');
});

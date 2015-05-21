function useLoadingSpinner(){
	var $body = $("body");
	$body.append(
			$("<div />",{
				"class" : "modal"
			}));
	$(document).on({
	    ajaxStart: function() { $body.addClass("loading");    },
	     ajaxStop: function() { $body.removeClass("loading"); }    
	});
}

function buttonAndEnterFiresFunction(button, field, func){
	$(button).click(func);
	$(field).keypress(function(event) {
		if (event.which === 13){
			func();
		}
	});
}
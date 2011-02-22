// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
jQuery.ajaxSetup({
	'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

function toggleArrow(element) {
	if ($(element).hasClass('open')) {
		$(element).removeClass('open').addClass('closed');
	} else {
		$(element).removeClass('closed').addClass('open');		
	}
}

jQuery.fn.submitWithAjax = function() {
	this.submit(function() {
		$.post($(this).attr("action"), $(this).serialize(), null, "script");
		return false;
	})
};

function deleteTag(elem, name, object, object_id, auth_token) {
	deleteUrl = "/tags/" + name + "/" + object + "/" + object_id;
    // alert(deleteUrl);
	$.ajax({ url: deleteUrl, type: "POST", data: "authenticity_token=" +encodeURIComponent(auth_token), success: function(){
    $(elem).closest("li").remove();
  }});
}

$(document).ready(function() {
	$("#addtag").submitWithAjax();
  $("#addpostit").submitWithAjax();
	$(".fix-error-report").submitWithAjax();
	// $(".line_relation_form").submitWithAjax();
	
	$('a.line-relation-form-button').live("click", function() {
		form = $(this).parents("form");
		spinner = $($(this).attr("href"));
		spinner.css('display', 'inline');
		$.post(
			form.attr("action"),
			form.serialize(),
			function(data, textStatus, request) {
				spinner.css('display', 'none');
			},
			"script");
		return false;
	});
	
	$("input.input-search-field").live("keydown", function(event) {
		if (event.keyCode == 13) {
			form = $(this).parents("form");
			$.post(form.attr("action"), form.serialize(), null, "script");
			return false;
		}
	})
})

$(document).ready(function() {
  $('#search li').click(function() {
    $("#search li").removeClass("selected");
    $(this).addClass("selected"); 
  });
});

function toggleCollapse(link) {
	var hiddenRows = $("tr.hide-row");
	var visibleRows = $("tr.show-row");
	if (hiddenRows.length > 0) {
		$.each(hiddenRows, function(index, value) {
			$(value).attr("class", "show-row");
		});
		$(link).html("<img src='/Rhythmyx/rx_resources/images/minus.gif'/>Hide");
	}
	else if (visibleRows.length > 0) {
		$.each(visibleRows, function(index, value) {
			$(value).attr("class", "hide-row");
		});
		$(link).html("<img src='/Rhythmyx/rx_resources/images/plus.gif'/>Show More");
	}

}

function validateTextFields() {
	var valListItems = "The following fields are required: <ul>";
	var retVal = true;
	var normalClass = "controlname";
	var errorClass = "controlnameerror";
	$('input.required:text').each(function(index,element) {
		var label = $('label[for='+element.id+']');
		var parent = label.parent();
		if (element.value == "") {
			retVal = false;
			parent.removeClass(normalClass);
			parent.addClass(errorClass);
			valListItems = valListItems + "<li>" + label.html() + "</li>";
		}
		else {
			parent.removeClass(errorClass);
			parent.addClass(normalClass);
		}
	});
	$('input.required:radio').each(function(index,element) {
		var label = $('label[for='+element.name+']');
		var parent = label.parent();
		if (($("input[id='" + element.id + "']").attr('disabled') != 'disabled') && 
			(undefined === $("input[name='" + element.name + "']:checked").val())) {
			retVal = false;
			parent.removeClass(normalClass);
			parent.addClass(errorClass);
			valListItems = valListItems + "<li>" + label.html() + "</li>";			
		}
		else {
			parent.removeClass(errorClass);
			parent.addClass(normalClass);		
		}
	});
	valListItems = valListItems + "</ul>";
	if (!retVal) {
		$('#error_messages').html(valListItems);
	}
	else {
		$('#error_messages').html("");
	}

	return retVal;
}
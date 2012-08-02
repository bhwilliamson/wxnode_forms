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

function cleanValue(value) {
	if (value) {
		while (value.indexOf("\"") >= 0) {
			value = value.replace("\"", "&amp;quot;");
		}
	}
	return value;
}

function validateTextFields() {
	var retVal = true;
	var normalClass = "controlname";
	var errorClass = "controlnameerror";
	$('#error_messages').html("");
	$('td[class=' + errorClass + ']').each(function(n,element) {
		$(element).removeClass(errorClass);
		$(element).addClass(normalClass);
	});

	var missingRequiredFields = false;
	var valListItems = "<p>The following fields are required: <ul>";
	$('input.required:text').each(function(index,element) {
		var label = $('label[for='+element.id+']');
		var parent = label.parent();
		if (element.value == "") {
			retVal = false;
			missingRequiredFields = true;
			parent.removeClass(normalClass);
			parent.addClass(errorClass);
			valListItems += "<li>" + label.html() + "</li>";
		}
	});
	$('input.required:radio').each(function(index,element) {
		var label = $('label[for='+element.name+']');
		var parent = label.parent();
		if (($("input[id='" + element.id + "']").attr('disabled') != 'disabled') &&
			(undefined === $("input[name='" + element.name + "']:checked").val())) {
			retVal = false;
			missingRequiredFields = true;
			parent.removeClass(normalClass);
			parent.addClass(errorClass);
			valListItems += "<li>" + label.html() + "</li>";
		}
	});
	valListItems = valListItems + "</ul></p>";
	if (missingRequiredFields) {
		var errorMsgs = $('#error_messages');
		errorMsgs.html(errorMsgs.html() + valListItems);
	}

	return retVal;
}
<%@ page import="java.util.*,com.percussion.i18n.PSI18nUtils" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
   String locale = PSI18nUtils.getSystemLanguage();
   String root = request.getContextPath();
%>
<!DOCTYPE html>  
<html lang="en">  
	<head>
		<meta charset="utf-8" />
		<title>Embed InPartnership</title>
		<link rel="stylesheet" type="text/css" href="<%= root %>/sys_resources/css/templates.css"/>
		<link rel="stylesheet" type="text/css" href="<%= root %>/sys_resources/css/aa/styles.css"/>
		<link href="<%= root %>/rx_resources/css/templates.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript" src="<%= root %>/sys_resources/js/globalErrorMessages.js">;</script>
		<script type="text/javascript" src="<%= root %>/sys_resources/js/<%= locale %>/globalErrorMessages.js">;</script>
		<script type="text/javascript" src="<%= root %>/tmx/tmx.jsp?sys_lang=<%= locale %>">;</script>
		<script type="text/javascript" src="<%= root %>/rx_resources/js/wxnodeform.js">;</script>

		<script src="http://code.jquery.com/jquery-latest.js"></script>
		<script type="text/javascript" >
			//http://api.jquery.com/ready/
			$(document).ready(function(){
				//on form submit, try to grap the opener editliveinstance
				//opener is a reference to the content editor page, which gives you access to all global javascript variables
				$('form').submit(function() {
					var allInputNameValuePairs = '';
					//Get text fields
					$('input:text').each(function(n,element) {
						var input_name = $(this).attr("name");
						if (input_name && input_name.indexOf('link_') == -1)
							allInputNameValuePairs += input_name + '="' + $(this).val() + '" ';
					});
					//Get radio buttons
					$('input:radio').each(function(n,element) {
						if($(this).attr("checked") == "checked") {
							allInputNameValuePairs += $(this).attr("name") + '="' + $(this).val() + '" ';
						}
					});
					//Get select options
					$('select').each(function(n,element) {
						allInputNameValuePairs += $(this).attr("name") + '="' + $(this).val() + '" ';
					});					
					//Build links
					var links_txt = '';
					for (var i=1; i<=6; i++) {
						var curr_link = $('#link_' + i + '_path');
						var curr_txt = $('#link_' + i + '_text');
						if (curr_link.length && curr_txt.length) {
							if (i > 1) {
								links_txt += ',';
							}						
							links_txt += curr_txt.val() + '::' + curr_link.val();
						}
					}
					allInputNameValuePairs += 'partnerlinks="' + links_txt + '" ';					
					window.opener._editLiveInstance.InsertHTMLAtCursor("<wxnode:module " + allInputNameValuePairs + "/>");
					//close the JSP page
					window.close();
				});
				
				$.ajax({
					url: '../twcProviderLookup/providerIds',
					success: function(data, status) {
						updateProviderField(data);
					},
					error: function(jqXHR, textStatus, errorThrown) {
						alert("Failure getting provider IDs: " + errorThrown);
					},
					type: "get",
					dataType: "xml"
				});				
			});
			var numLinks = 2;
			function addLinkFields(link) {
				numLinks++;
				var text_to_insert ='<tr><td class="controlname"><label for="link_' + numLinks + '_text">Link ' + numLinks + ' Text:</label></td><td><input class="datadisplay" size="50" id="link_' + numLinks + '_text" name="link_' + numLinks + '_text" type="text" value=""/></td></tr><tr><td class="controlname"><label for="link_' + numLinks + '_path">Link ' + numLinks + ' Path:</label></td><td><input class="datadisplay" size="50" id="link_' + numLinks + '_path" name="link_' + numLinks + '_path" type="text" value=""/></td></tr>';
				$('#insertbefore').before(text_to_insert);
				if (numLinks >= 6) {
					$('#insertbefore').attr('style', 'display:none');
				}
			}
			
			function updateProviderField(data) {
				var select = document.forms[0].elements['providerid'];
				var items = jQuery(data).find("PSXEntry").get();
				var selectedValue = select.options[select.selectedIndex].value;
				var emptyValue;
				select.options.length=0;

				auxArr = [];

				for (i = 0; i < items.length; i++) {
				    var value = items[i].getElementsByTagName("Value")[0].childNodes[0].nodeValue;
				    var displayText = items[i].getElementsByTagName("PSXDisplayText")[0].childNodes[0].nodeValue;
				    var isSelected = "";
				    if (value == selectedValue) {
					isSelected = "selected='selected'";
				    }
				    auxArr[i] = "<option value='" + value + "' " + isSelected + ">" + displayText + "</option>";

				}

				//Attempt the faster, if IE and it fails, do the slower
				select.innerHTML =auxArr.join('');
				if (select.innerHTML == "") {
					jQuery(select).append(auxArr.join(''));	
				}				
			}			
		</script>
	</head>
	<body>
		<form id="embed_inpartnership">	
		<table border="0" cellpadding="0" cellspacing="5" width="100%">		
                	<tr>
                        	<td colspan="2" id="error_messages" class="headercell2errorfont"></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="class">Class:</label></td>
                      		<td><input class="datadisplay required" size="50" id="class" name="class" type="text" tabindex="0" value="partners" readonly/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="providerid">Provider Id:</label></td>
                      		<td>
                      			<select id="providerid" name="providerid">
                      				<option value="loading">Loading</option>
					</select>                      		
                      		</td>
<%--                      		<input class="datadisplay required" size="50" id="providerid" name="providerid" type="text" value="" />
--%>
                      	</tr>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="link_1_text">Link 1 Text:</label></td>
                      		<td><input class="datadisplay" size="50" id="link_1_text" name="link_1_text" type="text" value=""/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="link_1_path">Link 1 Path:</label></td>
                      		<td><input class="datadisplay" size="50" id="link_1_path" name="link_1_path" type="text" value=""/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="link_2_text">Link 2 Text:</label></td>
                      		<td><input class="datadisplay" size="50" id="link_2_text" name="link_2_text" type="text" value=""/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="link_2_path">Link 2 Path:</label></td>
                      		<td><input class="datadisplay" size="50" id="link_2_path" name="link_2_path" type="text" value=""/></td>
                      	</tr>
						<tr id="insertbefore">
							<td></td>
							<td><a href="#" onclick="addLinkFields(this);return false;"><img src="<%= root %>/rx_resources/images/plus.gif"/>Add Link</a></td>
						</tr>
<!--
                      	<tr>
                      		<td class="controlname"><label for="partnerlinks">Partner Links:</label></td>
                      		<td><input class="datadisplay" size="50" id="partnerlinks" name="partnerlinks" type="text" value="" /></td>
                      	</tr>
-->
                      	<tr>
                      		<td class="controlname"><label for="align">Align:</label></td>
                      		<td>
								<input class="datadisplay" type="radio" id="align_left" name="align" value="left" checked="checked"/><span class="controlname">left</span>
								<input class="datadisplay" type="radio" id="align_right" name="align" value="right"/><span class="controlname">right</span><br/>
                      		</td>
                      	</tr>
                      	<tr>
                      		<td align="center" class="headercell2" colspan="2">
                      			<button type="submit" name="submit" onclick="return validateTextFields()">Submit</button>
                      		</td>
                      	</tr>		
		</table>			
		</form>
	</body>
</html>

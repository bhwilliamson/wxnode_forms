<%@ page import="java.util.*,com.percussion.i18n.PSI18nUtils" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
   String locale = PSI18nUtils.getSystemLanguage();
   String root = request.getContextPath();
%>
<!DOCTYPE html>  
<html lang="en">  
	<head>
		<meta charset="utf-8" />
		<title>Embed YouTube</title>
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
						allInputNameValuePairs += $(this).attr("name") + '="' + cleanValue($(this).val()) + '" ';
					});
					//Get radio buttons
					$('input:radio').each(function(n,element) {
						if($(this).attr("checked") == "checked") {
							allInputNameValuePairs += $(this).attr("name") + '="' + $(this).val() + '" ';
						}
					});
					//alert(allInputNameValuePairs);
					window.opener._editLiveInstance.InsertHTMLAtCursor("<wxnode:module " + allInputNameValuePairs + "/>");
					//close the JSP page
					window.close();
				});
			});
		</script>
	</head>
	<body>
		<form id="embed_youtube">
		<table border="0" cellpadding="0" cellspacing="5" width="100%">
                	<tr>
                        	<td colspan="2" id="error_messages" class="headercell2errorfont"></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="class">Class:</label></td>
                      		<td><input class="datadisplay" size="50" id="class" name="class" type="text" tabindex="0" value="youtube" readonly/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="title">Title:</label></td>
                      		<td><input class="datadisplay required" size="50" id="title" name="title" type="text" value="" /></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="src">Source:</label></td>
                      		<td><input class="datadisplay required" size="50" id="src" name="src" type="text" value="" /></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="height">Height:</label></td>
                      		<td><input class="datadisplay required" size="50" id="height" name="height" type="text" value="366px" /></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="width">Width:</label></td>
                      		<td><input class="datadisplay required" size="50" id="width" name="width" type="text" value="650px" /></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="frameborder">Frame Border:</label></td>
                      		<td><input class="datadisplay" size="50" id="frameborder" name="frameborder" type="text" value="0" /></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="allowfullscreen">Allow Fullscreen:</label></td>
				<td>
					<input class="datadisplay" type="radio" id="allowfullscreen_yes" name="allowfullscreen" value="true" checked="checked"/><span class="controlname">Yes</span>
					<input class="datadisplay" type="radio" id="allowfullscreen_no" name="allowfullscreen" value="false"/><span class="controlname">No</span><br/>
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

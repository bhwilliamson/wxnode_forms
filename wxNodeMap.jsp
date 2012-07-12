<%@ page import="java.util.*,com.percussion.i18n.PSI18nUtils" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
   String locale = PSI18nUtils.getSystemLanguage();
   String root = request.getContextPath();
%>
<!DOCTYPE html>  
<html lang="en">  
	<head>
		<meta charset="utf-8" />
		<title>Embed Map</title>
		<link rel="stylesheet" type="text/css" href="<%= root %>/sys_resources/css/templates.css"/>
		<link href="<%= root %>/rx_resources/css/templates.css" rel="stylesheet" type="text/css"/>
		<link rel="stylesheet" type="text/css" href="<%= root %>/sys_resources/css/aa/styles.css"/>
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
					//Build links
					var links_txt = '';
					for (var i=1; i<=6; i++) {
						var curr_link = $('#link_' + i + '_path');
						var curr_txt = $('#link_' + i + '_text');
						if (i > 1) {
							link_txt += ',';
						}
						if (curr_link.length && curr_txt.length) {
							links_txt += curr_txt.val() + '::' + curr_link.val();
						}
					}
					allInputNameValuePairs += 'links="' + links_txt + '" ';
					window.opener._editLiveInstance.InsertHTMLAtCursor("<wxnode:module " + allInputNameValuePairs + "/>");
					//close the JSP page
					window.close();
				});
			});
			function onSizeChange(radio) {
				if ((radio.id == 'sizecode_inset_43' || radio.id == 'sizecode_inset_169') && radio.checked) {
					$('#align_left').attr('disabled', false);
					$('#align_right').attr('disabled', false);
				}
				else if ((radio.id == 'sizecode_lead_43' || radio.id == 'sizecode_lead_169') && radio.checked) {
					$('#align_left').attr('disabled', true);
					$('#align_right').attr('disabled', true);
				}
				$('#clicksizecode').val($(radio).val());
			}
			var numLinks = 2;
			function addLinkFields(link) {
				numLinks++;
				var text_to_insert ='<tr><td class="controlname"><label for="link_' + numLinks + '_text">Link ' + numLinks + ' Text:</label></td><td><input class="datadisplay" size="50" id="link_' + numLinks + '_text" name="link_' + numLinks + '_text" type="text" value=""/></td></tr><tr><td class="controlname"><label for="link_' + numLinks + '_path">Link ' + numLinks + ' Path:</label></td><td><input class="datadisplay" size="50" id="link_' + numLinks + '_path" name="link_' + numLinks + '_path" type="text" value=""/></td></tr>';
				$('#insertbefore').before(text_to_insert);
				if (numLinks >= 6) {
					$('#insertbefore').attr('style', 'display:none');
				}
			}			
		</script>
	</head>
	<body>
<%-- [BW] Using tables here to match the content editor form & re-use styles --%>
		<form id="map_embed">
		<table border="0" cellpadding="0" cellspacing="5" summary="wx node map form" width="100%">		
                		<tr>
                        	<td colspan="2" id="error_messages" class="headercell2errorfont"></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="class">Class:</label></td>
                      		<td><input class="datadisplay" size="50" id="class" name="class" type="text" tabindex="0" value="staticmap" readonly/></td>
                      	</tr>                      	
                      	<tr>
                      		<td class="controlname"><label for="sizecode">Size Code:</label></td>
                      		<td>
					<input class="datadisplay required" type="radio" id="sizecode_lead_43" name="sizecode" value="4:3 Lead" checked="checked" onChange="onSizeChange(this)"/><span class="controlname">4:3 Lead</span>
					<input class="datadisplay required" type="radio" id="sizecode_lead_169" name="sizecode" value="16:9 Lead" onChange="onSizeChange(this)"/><span class="controlname">16:9 Lead</span>
					<input class="datadisplay required" type="radio" id="sizecode_inset_43" name="sizecode" value="4:3 Inset" onChange="onSizeChange(this)"/><span class="controlname">4:3 Inset</span>
					<input class="datadisplay required" type="radio" id="sizecode_inset_169" name="sizecode" value="16:9 Inset" onChange="onSizeChange(this)"/><span class="controlname">16:9 Inset</span><br/>
                      		</td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="clicksizecode">Click Size Code:</label></td>
                      		<td><input class="datadisplay required" size="50" id="clicksizecode" name="clicksizecode" type="text" value="4:3 Lead"/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="align">Align:</label></td>
                      		<td>
					<input class="datadisplay required" type="radio" id="align_left" name="align" value="left" disabled="true"/><span class="controlname">left</span>
					<input class="datadisplay" type="radio" id="align_right" name="align" value="right" disabled="true"/><span class="controlname">right</span><br/>
                      		</td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="title">Title:</label></td>
                      		<td><input class="datadisplay required" size="50" id="title" name="title" type="text"/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="mapid">Map ID:</label></td>
                      		<td><input class="datadisplay required" size="50" id="mapid" name="mapid" type="text"/></td>
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
<%--
                      	<tr>
                      		<td class="controlname"><label for="links">Links:</label></td>
                      		<td><input class="datadisplay" size="50" id="links" name="links" type="text"/></td>
                      	</tr>
--%>
                      	<tr>
                      		<td class="controlname"><label for="enlarge">Enlarge:</label></td>
                      		<td><input class="datadisplay" size="50" id="enlarge" name="enlarge" type="text" value="no"/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="enlarged_size_code">Enlarge Size Code:</label></td>
                      		<td><input class="datadisplay" size="50" id="enlarged_size_code" name="enlarged_size_code" type="text" value=""/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="helptext">Help Text:</label></td>
                      		<td><input class="datadisplay" size="50" id="helptext" name="helptext" type="text"/></td>
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

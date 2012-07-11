<%@ page import="java.util.*,com.percussion.i18n.PSI18nUtils" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
   String locale = PSI18nUtils.getSystemLanguage();
   String root = request.getContextPath();
%>
<!DOCTYPE html>  
<html lang="en">  
	<head>
		<meta charset="utf-8" />
		<title>Embed Internal Image</title>
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
						if (input_name && input_name.indexOf('topic_') == -1)
							allInputNameValuePairs += input_name + '="' + $(this).val() + '" ';
					});
					//Get radio buttons
					$('input:radio').each(function(n,element) {
						if($(this).attr("checked") == "checked") {
							allInputNameValuePairs += $(this).attr("name") + '="' + $(this).val() + '" ';
						}
					});
					//Get text area
					$('textarea').each(function(n,element) {
						allInputNameValuePairs += $(this).attr("name") + '="' + $(this).val() + '" ';
					});
					//Build links
					var links_txt = '';
					for (var i=1; i<=6; i++) {
						var curr_link = $('#topic_' + i + '_link');
						var curr_txt = $('#topic_' + i + '_text');
						if (curr_link.length && curr_txt.length) {
							links_txt += '<a href=\'' + curr_link.val() + '\'>' + curr_txt.val() + '</a>';
						}
					}
					allInputNameValuePairs += 'links="' + links_txt + '" ';
					window.opener._editLiveInstance.InsertHTMLAtCursor("<wxnode:module " + allInputNameValuePairs + "/>");
					//close the JSP page
					window.close();
				});
			});
			
			function onSizeChange(radio) {
				if (radio.value.indexOf('Inset') != -1 && radio.checked) {
					$('#align_left').attr('disabled', false);
					$('#align_right').attr('disabled', false);
				}
				else if (radio.value.indexOf('Lead') != -1 && radio.checked) {
					$('#align_left').attr('disabled', true);
					$('#align_right').attr('disabled', true);
				}
				$('#clicksizecode').val($(radio).val());
			}
			var numTopics = 2;
			function addLinkFields(link) {
				numTopics++;
				var text_to_insert ='<tr><td class="controlname"><label for="topic_' + numTopics + '_text">Topic ' + numTopics + ' Text:</label></td><td><input class="datadisplay" size="50" id="topic_' + numTopics + '_text" name="topic_' + numTopics + '_text" type="text" value=""/></td></tr><tr><td class="controlname"><label for="topic_' + numTopics + '_link">Topic ' + numTopics + ' Link:</label></td><td><input class="datadisplay" size="50" id="topic_' + numTopics + '_link" name="topic_' + numTopics + '_link" type="text" value=""/></td></tr>';
				$('#insertbefore').before(text_to_insert);
				if (numTopics >= 6) {
					$('#insertbefore').attr('style', 'display:none');
				}
			}			
		</script>
	</head>
	<body>
		<form id="embed_internal_image">	
		<table border="0" cellpadding="0" cellspacing="5" summary="wx internal image form" width="100%">		
                	<tr>
                        	<td colspan="2" id="error_messages" class="headercell2errorfont"></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="sizecode">Size Code:</label></td>
                      		<td>
					<input class="datadisplay" type="radio" id="sizecode_lead_16:9" name="sizecode" value="Lead 16:9" checked="checked" onChange="onSizeChange(this)"/><span class="controlname">Lead 16:9</span>
					<input class="datadisplay" type="radio" id="sizecode_inset_16:9" name="sizecode" value="Inset 16:9" onChange="onSizeChange(this)"/><span class="controlname">Inset 16:9</span>
					<input class="datadisplay" type="radio" id="sizecode_vertical_lead" name="sizecode" value="Vertical Lead" onChange="onSizeChange(this)"/><span class="controlname">Vertical Lead</span>
					<input class="datadisplay" type="radio" id="sizecode_vertical_inset" name="sizecode" value="Vertical Inset" onChange="onSizeChange(this)"/><span class="controlname">Vertical Inset</span><br/>
                            	</td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="align">Align:</label></td>
				<td>
					<input class="datadisplay" type="radio" id="align_left" name="align" value="left" disabled="true"/><span class="controlname">left</span>
					<input class="datadisplay" type="radio" id="align_right" name="align" value="right" disabled="true"/><span class="controlname">right</span><br/>
                             	</td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="assetid">Asset ID:</label></td>
                      		<td><input class="datadisplay required" size="50" id="assetid" name="assetid" type="text"/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="credit">Provider:</label></td>
                      		<td><input class="datadisplay required" size="50" id="credit" name="credit" type="text" value=""/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="alt">Alt:</label></td>
                      		<td><input class="datadisplay" size="50" id="alt" name="alt" type="text"/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="title">Title:</label></td>
                      		<td><input class="datadisplay" size="50" id="title" name="title" type="text" value=""/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="link">Link:</label></td>
                      		<td><input class="datadisplay" size="50" id="link" name="link" type="text" value=""/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="synopsis">Description:</label></td>
                      		<td><textarea rows="6" cols="45" id="synopsis" name="synopsis"></textarea></td>
                      		<!--<td><input class="datadisplay" size="50" id="synopsis" name="synopsis" type="text" value=""/></td>-->
                      	</tr>
<%--
                      	<tr>
                      		<td class="controlname"><label for="links">Topic Links:</label></td>
                      		<td><input class="datadisplay" size="50" id="links" name="links" type="text" value=""/></td>
                      	</tr>
--%>
                      	<tr>
                      		<td class="controlname"><label for="topic_1_text">Topic 1 Text:</label></td>
                      		<td><input class="datadisplay" size="50" id="topic_1_text" name="topic_1_text" type="text" value=""/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="topic_1_link">Topic 1 Link:</label></td>
                      		<td><input class="datadisplay" size="50" id="topic_1_link" name="topic_1_link" type="text" value=""/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="topic_2_text">Topic 2 Text:</label></td>
                      		<td><input class="datadisplay" size="50" id="topic_2_text" name="topic_2_text" type="text" value=""/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="topic_2_link">Topic 2 Link:</label></td>
                      		<td><input class="datadisplay" size="50" id="topic_2_link" name="topic_2_link" type="text" value=""/></td>
                      	</tr>
<%--                      	
			<tr id="insertbefore">
				<td></td>
				<td><a href="#" onclick="addLinkFields(this);return false;"><img src="<%= root %>/rx_resources/images/plus.gif"/>Add Topic</a></td>
			</tr>
--%>			
			<tr>
				<td colspan="2"><a href="#" onclick="toggleCollapse(this);return false;"><img src="<%= root %>/rx_resources/images/plus.gif"/>Show More</a></td>
			</tr>
                      	<tr class="hide-row">
                      		<td class="controlname"><label for="class">Class:</label></td>
                      		<td><input class="datadisplay" size="50" id="class" name="class" type="text" tabindex="0" value="singleimage" readonly/></td>
                      	</tr>
                      	<tr class="hide-row">
                      		<td class="controlname"><label for="type">Type:</label></td>
                      		<td><input class="datadisplay" size="50" id="type" name="type" type="text" value="internalasset" readonly/></td>
                      	</tr>
                      	<tr class="hide-row">
                      		<td class="controlname"><label for="clicksizecode">Click Size Code:</label></td>
                      		<td><input class="datadisplay" size="50" id="clicksizecode" name="clicksizecode" type="text" value=""/></td>
                      	</tr>                      	
                      	<tr class="hide-row">
                      		<td class="controlname"><label for="captionoverride">Caption Override:</label></td>
                      		<td><input class="datadisplay" size="50" id="captionoverride" name="captionoverride" type="text"/></td>
                      	</tr>
                      	<tr class="hide-row">
                      		<td class="controlname"><label for="showcaption">Show Caption:</label></td>
                      		<td><input class="datadisplay" size="50" id="showcaption" name="showcaption" type="text" value="no"/></td>
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

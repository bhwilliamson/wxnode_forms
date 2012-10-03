<%@ page import="java.util.*,com.percussion.i18n.PSI18nUtils" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
   String locale = PSI18nUtils.getSystemLanguage();
   String root = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>Embed Resource</title>
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
					$('input:not(:button)').each(function(n,element) {
						allInputNameValuePairs += $(this).attr("name") + '="' + cleanValue($(this).val()) + '" ';
					});
					window.opener._editLiveInstance.InsertHTMLAtCursor("<wxnode:module " + allInputNameValuePairs + "/>");
					//close the JSP page
					window.close();
				});
			});

			function loadExisting() {				
				$.getJSON('<%= root %>/user/apps/lfcopencontentwell/get.htm',
					function(data) {
						$('#title').val(data.title);
						$('#providercode').val(data.providercode);
						$('#property').val(data.property);
					});

				$('#submit').attr('style', 'display:none');
				$('#update').attr('style', 'display:inline');
				$('#delete').attr('style', 'display:inline');
			}
			
			function update() {
				$.getJSON('<%= root %>/user/apps/lfcopencontentwell/update.htm',
					{id:$('#resource').val()},
					function(data) {
						$('#display_messages').html(data.msg);
					});
			}
			
			function delete() {
				$.getJSON('<%= root %>/user/apps/lfcopencontentwell/delete.htm',
					{id:$('#resource').val()},
					function(data) {
						$('#display_messages').html(data.msg);
					});			
			}
			
			function create() {
				$.getJSON('<%= root %>/user/apps/lfcopencontentwell/update.htm',
					{
						id:$('#resource').val(),
						title:$('#title).val(),
						providercode:$('#providercode').val(),
						property:$('#property').val()
					},
					function(data) {
						$('#display_messages').html(data.msg);
					});			
			}
		</script>
	</head>
	<body>
		<form id="resource_embed">
		<table border="0" cellpadding="0" cellspacing="5" summary="wx node resource form" width="100%">
                	<tr>
                        	<td colspan="2" id="error_messages" class="headercell2errorfont"></td>
                      	</tr>
                	<tr>
                        	<td colspan="2" id="display_messages" class="headercell2font"></td>
                      	</tr>                      	
                      	<tr>
                      		<td class="controlname"><label for="class">Class:</label></td>
                      		<td><input class="datadisplay required" size="50" id="class" name="class" type="text" tabindex="0" value="static-reference" readonly/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="title">Title:</label></td>
                      		<td><input class="datadisplay required" size="50" id="title" name="title" type="text"/></td>
                      	</tr>
                        <tr>
				<td class="controlname"><label for="providercode">Provider Code:</label></td>
				<td><textarea rows="6" cols="45" id="providercode" name="providercode"></textarea></td>
                        </tr>
                      	<tr>
                      		<td class="controlname"><label for="resource">Resource Id:</label></td>
                      		<td><input class="datadisplay" size="34" id="resource" name="resource" type="text" value=""/>&nbsp;<input type="button" value="Load Existing..." onclick="loadExisting();"></input></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="property">Property:</label></td>
                      		<td>
                      			<select id="property" name="property">
                      				<option value="desktop">Desktop</option>
                      				<option value="mobile" selected="selected">Mobile</option>
					</select>
                      		</td>
                      	</tr>
                      	<tr>
                      		<td align="center" class="headercell2" colspan="2">
                      			<button type="submit" name="submit" id="submit" onclick="return validateTextFields()">Submit</button>
                      			<button style="display: none;" type="submit" name="update" id="update" onclick="return validateTextFields()">Update</button>
                      			<button style="display: none;" type="submit" name="delete" id="delete">Delete</button>
                      		</td>
                      	</tr>
		</table>
		</form>
	</body>
</html>
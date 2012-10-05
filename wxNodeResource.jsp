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
				
				//TODO: Add functions as binding to click of input buttons
				$('#clear').click(function() {
					clearForm();
				});
				$('#load').click(function() {
					loadResource();
				});
				$('#update').click(function() {
					updateResource();
				});
				$('#delete').click(function() {
					deleteResource();
				});
				$('#create').click(function() {
					createResource();
				});				
			});

			function loadResource() {
				clearMessages();
				
				$.getJSON('<%= root %>/user/apps/lfcopencontentwell/get.htm',
					{resource:$('#resource').val()},
					function(data) {
						$('#title').val(data.title);
						$('#providercode').val(data.providercode);
						$('#property').val(data.property);
					});

				$('#create').attr('style', 'display:none');
				$('#update').attr('style', 'display:inline');
				$('#delete').attr('style', 'display:inline');
			}
			
			function deleteResource() {
				clearMessages();			
				$.getJSON('<%= root %>/user/apps/lfcopencontentwell/delete.htm',
					{resource:$('#resource').val()},
					function(data) {
						//alert("Delete return: " + data.msg);
						$('#display_messages').html(data.msg);
					});
				clearForm();
				$('#create').attr('style', 'display:inline');
				$('#update').attr('style', 'display:none');
				$('#delete').attr('style', 'display:none');				
				
			}
			
			function updateResource() {
				clearMessages();
				if (!validateTextFields()) {return;}
				$.ajax({
				  url: '<%= root %>/user/apps/lfcopencontentwell/update.htm',
				  dataType: 'json',
				  data: {
						resource:$('#resource').val(),
						title:$('#title').val(),
						providercode:$('#providercode').val(),
						property:$('#property').val()
					},
				  type: "post",
				  success: function(data, status) {
				  		//alert("Update return: " + data.msg);
						$('#display_messages').html(data.msg);
					}
				});
			}			
			
			function createResource() {
				clearMessages();				
				if (!validateTextFields()) {return;}
				
				$.ajax({
				  url: '<%= root %>/user/apps/lfcopencontentwell/create.htm',
				  dataType: 'json',
				  data: {
						resource:$('#resource').val(),
						title:$('#title').val(),
						providercode:$('#providercode').val(),
						property:$('#property').val()
					},
				  type: "post",
				  success: function(data, status) {
				  		//alert("Create return: " + data.msg);
						$('#display_messages').html(data.msg);
					}
				});
				
				$('#create').attr('style', 'display:none');
				$('#update').attr('style', 'display:inline');
				$('#delete').attr('style', 'display:inline');				
			}			
			
			function clearForm() {
				clearMessages();
				
				$('#title').val('');
				$('#providercode').val('');
				$('#resource').val('');
				$('#property').val('mobile');
				
				$('#create').attr('style', 'display:inline');
				$('#update').attr('style', 'display:none');
				$('#delete').attr('style', 'display:none');				
			}
			
			function clearMessages() {
				$('#display_messages').html('');
				$('#error_messages').html('');
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
                      		<td><input class="datadisplay" size="30" id="resource" name="resource" type="text" value=""/>&nbsp;<input id="load" type="button" value="Load Existing..."></input></td>
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
                      			<input id="create" type="button" value="Create"></input>
                      			<input style="display: none;" id="update" type="button" value="Update"></input>
                      			<input style="display: none;" id="delete" type="button" value="Delete"></input>
                      			<input id="clear" type="button" value="Clear"></input>
                      			<button type="submit" name="close" id="close" onclick="window.close();">Insert wxnode</button>
                      		</td>
                      	</tr>
		</table>
		</form>
	</body>
</html>
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
    		<link rel="stylesheet" href="http://code.jquery.com/ui/1.9.0/themes/base/jquery-ui.css " />    		
    		
		<script src="http://code.jquery.com/jquery-latest.js"></script>
		<script src="http://code.jquery.com/ui/1.9.0/jquery-ui.js "></script>
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
							allInputNameValuePairs += input_name + '="' + cleanValue($(this).val()) + '" ';
					});
					//Get select options
					$('select').each(function(n,element) {
						allInputNameValuePairs += $(this).attr("name") + '="' + $(this).val() + '" ';
					});
					window.opener._editLiveInstance.InsertHTMLAtCursor("<wxnode:module " + allInputNameValuePairs + "/>");
					//close the JSP page
					window.close();
				});
								
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
				
				$("#resource").autocomplete({
					source: function(request, response) {
						$.getJSON('<%= root %>/user/apps/lfcopencontentwell/resourceAutocomplete.htm',
							{resource:$('#resource').val(),platform:$('#platform').val()},
							response);
					},
					minLength: 3					
				});				
				
			});
			function loadResource() {
				clearMessages();
				if (!validateTextFields()) {return;}				
				$.getJSON('<%= root %>/user/apps/lfcopencontentwell/get.htm',
					{resource:$('#resource').val(),platform:$('#platform').val()},
					function(data) {
						$('#providercode').val(data.providercode);
						$('#platform').val(data.platform);
						$('#display_messages').html(data.msg);
						$('#error_messages').html(data.error);
						if (undefined === data.error) {
							$('#create').attr('style', 'display:none');
							$('#update').attr('style', 'display:inline');
							$('#delete').attr('style', 'display:inline');						
						}
					});


			}
			
			function deleteResource() {
				clearMessages();
				if (!validateTextFields()) {return;}				
				$.getJSON('<%= root %>/user/apps/lfcopencontentwell/delete.htm',
					{resource:$('#resource').val(),platform:$('#platform').val()},
					function(data) {
						if (undefined === data.error) {
							clearForm();
							$('#create').attr('style', 'display:inline');
							$('#update').attr('style', 'display:none');
							$('#delete').attr('style', 'display:none');						
						}
						$('#display_messages').html(data.msg);
						$('#error_messages').html(data.error);						
					});				
				
			}
			
			function updateResource() {
				clearMessages();
				if (!validateTextFields()) {return;}
				$.ajax({
				  url: '<%= root %>/user/apps/lfcopencontentwell/update.htm',
				  dataType: 'json',
				  data: {
						resource:$('#resource').val(),
						providercode:$('#providercode').val(),
						platform:$('#platform').val()
					},
				  type: "post",
				  success: function(data, status) {
						$('#display_messages').html(data.msg);
						$('#error_messages').html(data.error);
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
						providercode:$('#providercode').val(),
						platform:$('#platform').val()
					},
				  type: "post",
				  success: function(data, status) {
						$('#display_messages').html(data.msg);
						$('#error_messages').html(data.error);
						if (undefined === data.error) {
							$('#create').attr('style', 'display:none');
							$('#update').attr('style', 'display:inline');
							$('#delete').attr('style', 'display:inline');						
						}						
					}
				});								
			}			
			
			function clearForm() {
				clearMessages();
				
				$('#providercode').val('');
				$('#resource').val('');
				$('#platform').val('mobile');
				
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
<!--                      	
                      	<tr>
                      		<td class="controlname"><label for="title">Title:</label></td>
                      		<td><input class="datadisplay" size="50" id="title" name="title" type="text"/></td>
                      	</tr>
-->                      	
                        <tr>
				<td class="controlname"><label for="providercode">Provider Code:</label></td>
				<td><textarea rows="6" cols="45" id="providercode" name="providercode"></textarea></td>
                        </tr>
                      	<tr>
                      		<td class="controlname"><label for="resource">Resource Id:</label></td>
                      		<td><input class="datadisplay required" size="30" id="resource" name="resource" type="text" value=""/>&nbsp;<input id="load" type="button" value="Load Existing..."></input></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="platform">Platform:</label></td>
                      		<td>
                      			<select id="platform" name="platform">
                      				<option value="desktop" selected="selected">Desktop</option>
                      				<option value="desktopi">Desktopi</option>
                      				<option value="touch">Touch</option>
                      				<option value="touchi">Touchi</option>
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
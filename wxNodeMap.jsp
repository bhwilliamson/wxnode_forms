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

		<script src="http://code.jquery.com/jquery-latest.js"></script>
		<script type="text/javascript" >
			//http://api.jquery.com/ready/
			$(document).ready(function(){
				//on form submit, try to grap the opener editliveinstance
				//opener is a reference to the content editor page, which gives you access to all global javascript variables
				$('form').submit(function() {
					var allInputNameValuePairs = '';
					$('input:not(:button)').each(function(n,element) {
						allInputNameValuePairs += $(this).attr("name") + '="' + $(this).val() + '" ';
					});
					window.opener._editLiveInstance.InsertHTMLAtCursor("<wxnode:module " + allInputNameValuePairs + "/>");
					//close the JSP page
					window.close();
				});
			});
		</script>
	</head>
	<body>
<%-- [BW] Using tables here to match the content editor form & re-use styles --%>
		<form id="map_embed">
		<table border="0" cellpadding="0" cellspacing="5" summary="wx node map form" width="100%">		
                	<tr>
                        	<td colspan="2"></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="class">Class:</label></td>
                      		<td><input class="datadisplay" size="50" id="class" name="class" type="text" tabindex="0" value="staticmap" readonly/></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="mapid">Map ID:</label></td>
                      		<td><input class="datadisplay" size="50" id="mapid" name="mapid" type="text"/></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="sizecode">Size Code:</label></td>
                      		<td><input class="datadisplay" size="50" id="sizecode" name="sizecode" type="text" value=""/></td>
                      	</tr> 
                      	<tr>                      	
                      		<td class="controlname"><label for="title">Title:</label></td>
                      		<td><input class="datadisplay" size="50" id="title" name="title" type="text"/></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="links">Links:</label></td>
                      		<td><input class="datadisplay" size="50" id="links" name="links" type="text"/></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="helptext">Help Text:</label></td>
                      		<td><input class="datadisplay" size="50" id="helptext" name="helptext" type="text"/></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="clicksizecode">Click Size Code:</label></td>
                      		<td><input class="datadisplay" size="50" id="clicksizecode" name="clicksizecode" type="text"/></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="align">Align:</label></td>
                      		<td><input class="datadisplay" size="50" id="align" name="align" type="text" value="left"/></td>
                      	</tr>   
                      	<tr>                      	
                      		<td class="controlname"><label for="enlarge">Enlarge:</label></td>
                      		<td><input class="datadisplay" size="50" id="enlarge" name="enlarge" type="text" value="no"/></td>
                      	</tr> 
                      	<tr>                      	
                      		<td class="controlname"><label for="enlarged_size_code">Enlarge Size Code:</label></td>
                      		<td><input class="datadisplay" size="50" id="enlarged_size_code" name="enlarged_size_code" type="text" value=""/></td>
                      	</tr>                       	
                      	<tr>
                      		<td align="center" class="headercell2" colspan="2">
                      			<button type="submit" name="submit">Submit</button>
                      		</td>
                      	</tr>			
		</table>
		</form>
	</body>
</html>

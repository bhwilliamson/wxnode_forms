<%@ page import="java.util.*,com.percussion.i18n.PSI18nUtils" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
   String locale = PSI18nUtils.getSystemLanguage();
   String root = request.getContextPath();
%>
<!DOCTYPE html>  
<html lang="en">  
	<head>
		<meta charset="utf-8" />
		<title>Embed Image Slideshow</title>
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
						allInputNameValuePairs += $(this).attr("name") + '="' + $(this).val() + '" ';
					});
					//Get radio buttons
					$('input:radio').each(function(n,element) {
						if($(this).attr("checked") == "checked") {
							allInputNameValuePairs += $(this).attr("name") + '="' + $(this).val() + '" ';
						}
					});
					window.opener._editLiveInstance.InsertHTMLAtCursor("<wxnode:module " + allInputNameValuePairs + "/>");
					//close the JSP page
					window.close();
				});
			});
		</script>
	</head>
	<body>
		<form id="embed_image_slideshow">
		<table border="0" cellpadding="0" cellspacing="5" summary="wx external image form" width="100%">
		<wxnode:module class="slideshow" providerid="" articleid="" sizecode="3" title=""/>
                	<tr>
                        	<td colspan="2" id="error_messages" class="headercell2errorfont"></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="class">Class:</label></td>
                      		<td><input class="datadisplay required" size="50" id="class" name="class" type="text" tabindex="0" value="slideshow" readonly/></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="title">Title:</label></td>
                      		<td><input class="datadisplay" size="50" id="title" name="title" type="text"/></td>
                      	</tr>                        	                      	
                      	<tr>                      	
                      		<td class="controlname"><label for="collectionid">Collection ID:</label></td>
                      		<td><input class="datadisplay required" size="50" id="collectionid" name="collectionid" type="text"/></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="sizecode">Size Code:</label></td>
                      		<td>
					<input class="datadisplay required" type="radio" id="sizecode_lead" name="sizecode" value="10" checked="checked"/><span class="controlname">16:9 Lead</span>
					<input class="datadisplay" type="radio" id="sizecode_immersive" name="sizecode" value="12"/><span class="controlname">16:9 Immersive</span><br/>                      		
				</td>
                      	</tr> 
			<tr>
				<td colspan="2"><a href="#" onclick="toggleCollapse(this);return false;"><img src="<%= root %>/rx_resources/images/plus.gif"/>Show More</a></td>
			</tr>                      	
                      	<tr class="hide-row">                      	
                      		<td class="controlname"><label for="refreshPageViewBeacon">Refresh Page View Beacon:</label></td>
                      		<td><input class="datadisplay" size="50" id="refreshPageViewBeacon" name="refreshPageViewBeacon" type="text" value="true"/></td>
                      	</tr> 
                      	<tr class="hide-row">                      	
                      		<td class="controlname"><label for="refreshPageViewBeaconNSlides">Refresh Page View Beacon After N Slides:</label></td>
                      		<td><input class="datadisplay" size="50" id="refreshPageViewBeaconNSlides" name="refreshPageViewBeaconNSlides" type="text" value="1"/></td>
                      	</tr> 
                      	<tr class="hide-row">                      	
                      		<td class="controlname"><label for="refreshAds">Refresh Ads:</label></td>
                      		<td><input class="datadisplay" size="50" id="refreshAds" name="refreshAds" type="text" value="false"/></td>
                      	</tr> 
                      	<tr class="hide-row">                      	
                      		<td class="controlname"><label for="refreshADsAfterNSlides">Refresh Ads After N Slides:</label></td>
                      		<td><input class="datadisplay" size="50" id="refreshADsAfterNSlides" name="refreshADsAfterNSlides" type="text" value="3"/></td>
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

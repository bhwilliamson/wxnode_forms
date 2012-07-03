<%@ page import="java.util.*,com.percussion.i18n.PSI18nUtils" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%
   String locale = PSI18nUtils.getSystemLanguage();
   String root = request.getContextPath();
%>
<!DOCTYPE html>  
<html lang="en">  
	<head>
		<meta charset="utf-8" />
		<title>Embed Video</title>
		<link rel="stylesheet" type="text/css" href="<%= root %>/sys_resources/css/templates.css"/>
		<link rel="stylesheet" type="text/css" href="<%= root %>/sys_resources/css/aa/styles.css"/>
		<link href="<%= root %>/rx_resources/css/templates.css" rel="stylesheet" type="text/css"/>
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
		<form id="embed_video">	
		<table border="0" cellpadding="0" cellspacing="5" width="100%">		
                	<tr>
                        	<td colspan="2"></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="class">Class:</label></td>
                      		<td><input class="datadisplay" size="50" id="class" name="class" type="text" tabindex="0" value="corsican-video" readonly/></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="position">Align:</label></td>
                      		<td><input class="datadisplay" size="50" id="position" name="position" type="text" value="left" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="showheadline">Show Headline:</label></td>
                      		<td><input class="datadisplay" size="50" id="showheadline" name="showheadline" type="text" value="true" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="showplaylist">Show Playlist:</label></td>
                      		<td><input class="datadisplay" size="50" id="showplaylist" name="showplaylist" type="text" value="true" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="gridsize">Grid Size:</label></td>
                      		<td><input class="datadisplay" size="50" id="gridsize" name="gridsize" type="text" value="4" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="bcplayerkey">Player Key:</label></td>
                      		<td><input class="datadisplay" size="50" id="bcplayerkey" name="bcplayerkey" type="text" value="AQ~~,AAAAAAQxtuk~,N9g8AOtC12eobrWkZvrqKiXxOtGg-8h1" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="bcplayerid">Player Id:</label></td>
                      		<td><input class="datadisplay" size="50" id="bcplayerid" name="bcplayerid" type="text" value="1543561898001" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="videos">Videos:</label></td>
                      		<td><input class="datadisplay" size="50" id="videos" name="videos" type="text" value="class=video;q=clip:360,clip:361,clip:362,clip:363|class=video;q=coll:169" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="inpage">In Page:</label></td>
                      		<td><input class="datadisplay" size="50" id="inpage" name="inpage" type="text" value="true" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="companionadpos">Companion Ads:</label></td>
                      		<td><input class="datadisplay" size="50" id="companionadpos" name="companionadpos" type="text" value="WX_Top300Variable" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="showrelatedlinks">Show Related Links:</label></td>
                      		<td><input class="datadisplay" size="50" id="showrelatedlinks" name="showrelatedlinks" type="text" value="false" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="showdescription">Show Description:</label></td>
                      		<td><input class="datadisplay" size="50" id="showdescription" name="showdescription" type="text" value="false" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="autoplay">AutoPlay:</label></td>
                      		<td><input class="datadisplay" size="50" id="autoplay" name="autoplay" type="text" value="true" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="forceautoplay">Force Autoplay:</label></td>
                      		<td><input class="datadisplay" size="50" id="forceautoplay" name="forceautoplay" type="text" value="false" /></td>
                      	</tr>
                      	<tr>                      	
                      		<td class="controlname"><label for="primary">Primary:</label></td>
                      		<td><input class="datadisplay" size="50" id="primary" name="primary" type="text" value="false" /></td>
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

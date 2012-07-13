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
					var video_fld = 'videos="class=video';
					$('input:text').each(function(n,element) {
						if ($(this).attr('name') == 'videos') {
							var ids = $(this).val();
							var idsAry = ids.split(",");
							var isFirst = true;
							for (var i = 0; i < idsAry.length; i++) {
								var id = $.trim(idsAry[i]);
								if (id != "") {
									if (!isFirst) {
										video_fld += ',';
									}
									else {
										video_fld += ';q=';
									}
									video_fld += 'clip:' + id;
									isFirst = false;
								}
							}
						}
						else if ($(this).attr('name') == 'collection' && $(this).val() != "") {
							video_fld += ';q=coll:'	+ $(this).val();
						}
						else {
							allInputNameValuePairs += $(this).attr("name") + '="' + $(this).val() + '" ';
						}
					});
					video_fld += '" ';
					allInputNameValuePairs += video_fld;
					//Get radio buttons
					$('input:radio').each(function(n,element) {
						if($(this).attr('name') == 'videos_type' && $(this).attr("checked") == "checked") {
						}
						else if($(this).attr("checked") == "checked") {
							allInputNameValuePairs += $(this).attr("name") + '="' + $(this).val() + '" ';
						}
					});
					//alert(allInputNameValuePairs);
					window.opener._editLiveInstance.InsertHTMLAtCursor("<wxnode:module " + allInputNameValuePairs + "/>");
					//close the JSP page
					window.close();
				});
			});
			function onGridSizeChange(radio) {
				if (radio.value == '2' && radio.checked) {
					$('#position_left').attr('disabled', false);
					$('#position_right').attr('disabled', false);
					$('#bcplayerkey').val('AQ~~,AAAAAAQxtuk~,N9g8AotC12flp8PmRxlLqTu0V7oMP9Ia');
					$('#bcplayerid').val('1543561927001');
					$('#forceautoplay').val('false');
					$('#autoplay').val('false');
					$('#primary').val('false');
				}
				else if (radio.value == '4' && radio.checked) {
					$('#position_left').attr('disabled', true);
					$('#position_right').attr('disabled', true);
					$('#bcplayerkey').val('AQ~~,AAAAAAQxtuk~,N9g8AotC12eobrWkZvrqKiXxOtGg-8h1');
					$('#bcplayerid').val('1543561897001');
					$('#forceautoplay').val('false');
					$('#autoplay').val('true');
					$('#primary').val('true');					
				}
			}
			function onVideoIdBlur() {
				var ids = $('#videos').val();
				var idsAry = ids.split(",");
				if (idsAry && idsAry.length <= 1) {
					$('#showplaylist_no').attr('checked', 'checked');
				}
				else {
					$('#showplaylist_yes').attr('checked', 'checked');
				}
			}
			
			function validateVideoFields() {
				var retVal = validateTextFields();
				var normalClass = "controlname";
				var errorClass = "controlnameerror";
				var video_ids = $('#videos').val();
				var collection_id = $('#collection').val();
				var videosParent = $('label[for=videos]').parent();
				var collectionParent = $('label[for=collection]').parent();
				if (video_ids == "" && collection_id == "") {
					videosParent.removeClass(normalClass);
					collectionParent.removeClass(normalClass);
					videosParent.addClass(errorClass);
					collectionParent.addClass(errorClass);
					var errorMsgs = $('#error_messages')
					errorMsgs.html(errorMsgs.html() + "<p>Either Videos (IDs) or Collection (ID) are required</p>");
					retVal = false;
				}
				else {
					videosParent.removeClass(errorClass);
					collectionParent.removeClass(errorClass);
					videosParent.addClass(normalClass);
					collectionParent.addClass(normalClass);
					if (retVal) {
						$('#error_messages').html("");
					}
				}
				return retVal;
			}			
		</script>
	</head>
	<body>
		<form id="embed_video">
		<table border="0" cellpadding="0" cellspacing="5" width="100%">
                	<tr>
                        	<td colspan="2" id="error_messages" class="headercell2errorfont"></td>
                      	</tr>
                      	<tr>
				<td class="controlname"><label for="gridsize">Size:</label></td>
				<td>
					<input class="datadisplay" type="radio" name="gridsize" value="4" checked="checked" onChange="onGridSizeChange(this)"/><span class="controlname">lead</span>
					<input class="datadisplay" type="radio" name="gridsize" value="2" onChange="onGridSizeChange(this)"/><span class="controlname">inset</span><br/>
                             	</td>
                        </tr>
                      	<tr style="margin-left:20px;">
                      		<td></td>
                      		<td><span class="controlname"><label for="bcplayerkey">Player Key:</label></span><input readonly="readonly" class="datadisplay" size="50" id="bcplayerkey" name="bcplayerkey" type="text" value="AQ~~,AAAAAAQxtuk~,N9g8AotC12eobrWkZvrqKiXxOtGg-8h1" /></td>
                      	</tr>
                      	<tr>
                      		<td></td>
                      		<td><span class="controlname"><label for="bcplayerid">Player Id:</label></span><input readonly="readonly" class="datadisplay" size="50" id="bcplayerid" name="bcplayerid" type="text" value="1543561897001" /></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="position">Align:</label></td>
				<td>
					<input class="datadisplay" type="radio" id="position_left" name="position" value="left" disabled="true"/><span class="controlname">left</span>
					<input class="datadisplay" type="radio" id="position_right" name="position" value="right" disabled="true"/><span class="controlname">right</span><br/>
                             	</td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="videos">Videos (IDs):</label></td>
				<td><input class="datadisplay" type="text" id="videos" name="videos" size="50" value="" onblur="onVideoIdBlur()"/></td>
                      	</tr>
                      	<tr>
				<td class="controlname"><label for="collection">Collection (ID):</label></td>
                      		<td><input class="datadisplay" type="text" id="collection" name="collection" size="50" value=""/></td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="showheadline">Show Headline:</label></td>
				<td>
					<input class="datadisplay" type="radio" id="showheadline_yes" name="showheadline" value="Yes" checked="checked"/><span class="controlname">Yes</span>
					<input class="datadisplay" type="radio" id="showheadline_no" name="showheadline" value="No"/><span class="controlname">No</span><br/>
                             	</td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="showplaylist">Show Playlist:</label></td>
				<td>
					<input class="datadisplay" type="radio" id="showplaylist_yes" name="showplaylist" value="Yes" checked="checked"/><span class="controlname">Yes</span>
					<input class="datadisplay" type="radio" id="showplaylist_no" name="showplaylist" value="No"/><span class="controlname">No</span><br/>
                             	</td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="showdescription">Show Description:</label></td>
				<td>
					<input class="datadisplay" type="radio" id="showdescription_show" name="showdescription" value="Show"/><span class="controlname">Show</span>
					<input class="datadisplay" type="radio" id="showdescription_hide" name="showdescription" value="Hide" checked="checked"/><span class="controlname">Hide</span><br/>
                             	</td>
                      	</tr>
                      	<tr>
                      		<td class="controlname"><label for="showrelatedlinks">Related Links:</label></td>
				<td>
					<input class="datadisplay" type="radio" id="showrelatedlinks_show" name="showrelatedlinks" value="Show"/><span class="controlname">Show</span>
					<input class="datadisplay" type="radio" id="showrelatedlinks_hide" name="showrelatedlinks" value="Hide" checked="checked"/><span class="controlname">Hide</span><br/>
                             	</td>                        	
                      	</tr>
			<tr>
				<td colspan="2"><a href="#" onclick="toggleCollapse(this);return false;"><img src="<%= root %>/rx_resources/images/plus.gif"/> Show More</a></td>
			</tr>
<!-- Begin Collapsable Region -->
                      	<tr class="hide-row">
                      		<td class="controlname"><label for="class">Class:</label></td>
                      		<td><input class="datadisplay" size="50" id="class" name="class" type="text" value="corsican-video" readonly/></td>
                      	</tr>
                      	<tr class="hide-row">
                      		<td class="controlname"><label for="inpage">In Page:</label></td>
                      		<td><input class="datadisplay" size="50" id="inpage" name="inpage" type="text" value="true" /></td>
                      	</tr>
                      	<tr class="hide-row">
                      		<td class="controlname"><label for="companionadpos">Companion Ads:</label></td>
                      		<td><input class="datadisplay" size="50" id="companionadpos" name="companionadpos" type="text" value="WX_Top300Variable" /></td>
                      	</tr>
                      	<tr class="hide-row">
                      		<td class="controlname"><label for="forceautoplay">Force Autoplay:</label></td>
                      		<td><input class="datadisplay" size="50" id="forceautoplay" name="forceautoplay" type="text" value="false" /></td>
                      	</tr>
                      	<tr class="hide-row">
                      		<td class="controlname"><label for="autoplay">AutoPlay:</label></td>
                      		<td><input class="datadisplay" size="50" id="autoplay" name="autoplay" type="text" value="true" /></td>
                      	</tr>
                      	<tr class="hide-row">
                      		<td class="controlname"><label for="primary">Primary:</label></td>
                      		<td><input class="datadisplay" size="50" id="primary" name="primary" type="text" value="false" /></td>
                      	</tr>
                      	<tr>
                      		<td align="center" class="headercell2" colspan="2">
                      			<button type="submit" name="submit" onclick="return validateVideoFields()">Submit</button>
                      		</td>
                      	</tr>
		</table>
		</form>
	</body>

</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	$(document).ready(function(){
		var idx = $(".selectLine").find(".fk_folder_idx").val();
		var startDate = new Date( $("#"+idx).find(".startDateTd").text() );
		var lastDate = new Date ( $("#"+idx).find(".lastDateTd").text() );
		
		$("#startDate, #lastDate").datepicker({
			dateFormat: 'yy-mm-dd',
			minDate:startDate,
			maxDate:lastDate,
			dayNames:['월','화','수','목','금','토','일'],
			dayNamesMin:['월','화','수','목','금','토','일'],
			monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort:['1','2','3','4','5','6','7','8','9','10','11','12']
		});
		
	});
</script>

<tr class="trLine">
	<td class="infoClass">시작일</td>
	<td class="infoData">
		<input type="text" readonly id="startDate" name="startDate" style="border:none;" value="${map.fvo.startDate}"/>
	</td>
</tr>

<tr class="trLine">
	<td class="infoClass">마감일</td>
	<td class="infoData">
		<input type="text" readonly id="lastDate" name="lastDate" style="border:none;" value="${map.fvo.lastDate}"/>
	</td>
</tr>

<%-- <tr class="trLine">
	<td class="infoClass">시작일</td>
	<td class="infoData showInfo">${map.fvo.startDate}</td>
	<td class="infoData hiddenEdit">
		<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="startDate" value="${map.fvo.startDate}" />
	</td>
</tr>

<tr class="trLine">
	<td class="infoClass">마감일</td>
	<td class="infoData showInfo">${map.fvo.lastDate}</td>
	<td class="infoData hiddenEdit">
		<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="lastDate" value="${map.fvo.lastDate}" />
	</td>
</tr> --%>
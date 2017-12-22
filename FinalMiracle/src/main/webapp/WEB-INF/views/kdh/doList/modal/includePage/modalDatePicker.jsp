<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	$(document).ready(function(){		
		var idx = $(".selectLine").find(".fk_folder_idx").val();
		var startDate = new Date( $("#"+idx).find(".fullStartDate").val() );
		var lastDate = new Date ( $("#"+idx).find(".fullLastDate").val() );
		
		$("#startDate, #lastDate").datepicker({
			dateFormat: 'yy-mm-dd',
			minDate:startDate,
			maxDate:lastDate,
			dayNames:['월','화','수','목','금','토','일'],
			dayNamesMin:['월','화','수','목','금','토','일'],
			monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort:['1','2','3','4','5','6','7','8','9','10','11','12']
		});
		
		// 시작일이 마감일보다 크지 않도록 하기
		$("#startDate").change(function(){
			var startDate = $("#startDate").val();
			var lastDate = $("#lastDate").val();
			if(startDate > lastDate) {
				$("#lastDate").val(startDate);
			}
		}); // end of $("#startDate").change(function() ------------------------------------------------------------------------
		$("#lastDate").change(function(){
			var startDate = $("#startDate").val();
			var lastDate = $("#lastDate").val();
			if(startDate > lastDate) {
				$("#startDate").val(lastDate);
			}
		}); // end of $("#lastDate").change(function() -----------------------------------------------------------------------
	});
</script>

<tr class="trLine">
	<td class="infoClass">시작일</td>
	<td class="infoData">
		<input type="text" readonly id="startDate" class="trLine pointer" name="startDate" style="width:100%; border:none; background-color:#F0F0F0;" value="${map.fvo.startDate}"/>
	</td>
</tr>

<tr class="trLine">
	<td class="infoClass">마감일</td>
	<td class="infoData">
		<input type="text" readonly id="lastDate" class="trLine pointer" name="lastDate" style="width:100%; border:none; background-color:#F0F0F0;" value="${map.fvo.lastDate}"/>
	</td>
</tr>
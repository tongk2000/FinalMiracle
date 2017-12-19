<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	// 파일추가 input 박스 더하기
	function addFileInput(element) {
		var $tr = $(element).parents(".fileInput");
		var html = "<tr class='fileInput trLine'>"+$tr.html()+"</tr>";
		$tr.after(html);
	} // end of function addFileInput(element) --------------------------------------------------------------------------------------------------------------------
	
	// 파일추가 input 박스 빼기
	function minusFileInput(element) {
		var $tr = $(element).parents(".fileInput");
		var length = $tr.parent().find(".fileInput").length; // input 박스의 갯수를 구함
		
		if(length > 1) { // input 박스의 갯수가 1개 이상이라면 그냥 지움
			$tr.remove();
		} else if (length == 1){ // input 박스의 갯수가 1개라면 새로 1개 만들어주고 해당 박스는 지움(올려진 파일을 초기화 하기 위함)
			var html = "<tr class='fileInput trLine'>"+$tr.html()+"</tr>";
			$tr.after(html);
			$tr.remove();
		}
	} //  end of function minusFileInput(element) ------------------------------------------------------------------------------------------------------
</script>

<tr>
	<td class="infoClass">파일추가</td>
	<td class="infoData">
		<table style="width:100%;"> <!-- trLine 효과를 각 tr마다 주고 싶어서 이렇게 따로 테이블로 뺌 -->
			<tr class="fileInput trLine">
				<td style="border:none;">
					<input type="button" value="+" class="addFileInput" onclick="addFileInput(this)"/>
					<input type="file" name="attach" id="attach" style="display:inline-block;" onclick="javascript:changeFlag=true;"/>
					<input type="button" value="-" style="display:inline-block;" onclick="minusFileInput(this)" />
				</td>
			</tr>
		</table>
	</td>
</tr>



















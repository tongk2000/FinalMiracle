<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	.selectedLineInAllCheck {
		background-color:lightgray;
	}
</style>

<script type="text/javascript">
	// 파일 전체 선택/해제 하기
	function allCheckToFile(element) {
		var bool = $(element).hasClass("selectedLineInAllCheck");
		if(bool) { // 이미 전체 선택 했다면
			$(element).removeClass("selectedLineInAllCheck");
			$(".checkTofile").prop("checked", false);
		} else { // 아직 전체 선택 안했다면
			$(element).addClass("selectedLineInAllCheck");
			$(".checkTofile").prop("checked", true);
		}
	} // end of function allCheckToFile(element) -------------------------------------------------------------------------------------------------
	
	// 파일 삭제 누르면 숨겨주기(바로 삭제는 아니고 hide만 했다가 정보수정 눌러야만 변동됨)
	function delToFile() {
		changeFlag = true;
		var bool1 = $("#allCheckToFile").hasClass("selectedLineInAllCheck");
		if(bool1) { // 전체 삭제라면
			$("#allCheckToFile").removeClass("selectedLineInAllCheck"); // 전체선택 css 없애고
			$(".checkTofile").prop("checked", false); // 체크박스를 모두 해재한 후에
			$(".fildIdx").hide(); // 모든줄을 숨기고
			$(".delFileArr").attr("disabled", false); // 모든 삭제할 파일 frm 을 연다.
			$("#noAttach").remove();
			$("#allCheckToFile").after('<tr id="noAttach"><td style="border:none;">등록된 첨부파일이 없습니다.</td></tr>'); // 첨부파일 없다고 적어줌
		} else { // 일부 삭제라면
			$(".checkTofile").each(function(){ // 체크돼있는지 반복문 돌려서 확인하고 처리
				var bool2 = $(this).is(":checked");
				if(bool2) { // 만약 체크돼어 있다면
					var idx = $(this).val();
					$("#fileIdx"+idx).hide(); // 해당 줄을 숨기고
					$("#delFileArr"+idx).attr("disabled", false); // 삭제할 파일 frm 을 연다.
				}
			});
		}
	} // end of function delToFile() -------------------------------------------------------------------------------------------------------------------
		
	// 체크박스하고 다운받기 제외하고 나머지 줄 선택하면 체크박스 선택해주기
	function addSelectedLineInAllCheck(event) {
		var bool1 = $(event.target).hasClass("checkTofile");
		var bool2 = $(event.target).hasClass("pointer");		
		if(!bool1 && !bool2) { // 체크박스나 다운받기가 아니라면
			var $checkTofile = $(event.target).find(".checkTofile") 
			var bool3 = $checkTofile.is(":checked");
			if(bool3) { // 이미 체크 돼있다면
				$checkTofile.prop("checked", false);
			} else { // 아직 체크 안됐다면
				$checkTofile.prop("checked", true);
			}
		}
		
		var bool4 = false;
		$(".checkTofile").each(function(){
			bool4 = $(this).is(":checked");
			if(!bool4) {
				$("#allCheckToFile").removeClass("selectedLineInAllCheck");
				return false;
			}
		});
		if(bool4) {
			$("#allCheckToFile").addClass("selectedLineInAllCheck");
		}
	} // function addSelectedLineInAllCheck(event) --------------------------------------------------------------------------------------------
	
	// 파일 복원 누르면 첨부파일 리스트 처음 상태 그대로 다시 보여주기
	function restoreToFile() {
		$(".fildIdx").show();
		$("#noAttach").remove();
		$(".delFileArr").attr("disabled", true); // 삭제할 파일 frm 을 전부 닫는다.
		if( $(".checkTofile").val() =! undefined ) {
			$("#allCheckToFile").after('<tr id="noAttach"><td style="border:none;">등록된 첨부파일이 없습니다.</td></tr>'); // 첨부파일 없다고 적어줌
		}		
	} // end of function restoreToFile() --------------------------------------------------------------------------------------------------------------
</script>

<tr>
	<td class="infoClass">첨부파일</td>
	<td class="infoData" style="height:10px;"> <!-- style="height:10px;" : 삭제 div에 height:100% 먹이기 위해서 줬음-->
		<div style="float:left; width:90%">
			<table style="width:100%;"> <!-- trLine 효과를 각 tr마다 주고 싶어서 이렇게 따로 테이블로 뺌 -->
				<tr class="trLine pointer" id="allCheckToFile" onclick="allCheckToFile(this)">
					<td style="border:none; border-bottom:1px dotted gray; font-weight:bold;">&nbsp;[전체선택] </td>
				</tr>
				<c:if test="${empty map.folder_fileList}">
					<tr id="noAttach">
						<td style="border:none;">등록된 첨부파일이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty map.folder_fileList}">
					<c:forEach var="ffvo" items="${map.folder_fileList}" varStatus="status">
						<tr class="trLine fildIdx" id="fileIdx${ffvo.idx}" onclick="javascript:addSelectedLineInAllCheck(event)">
							<td style="border:none;">
								<span>
									<input type="checkbox" class="checkTofile" value="${ffvo.idx}">
									<input type="hidden" disabled class="delFileArr" id="delFileArr${ffvo.idx}" name="delFileArr" value="${ffvo.serFilename}">
									<a style="text-decoration:none;" class="pointer" 
									   href="<%=request.getContextPath()%>/do_fileDownload.mr?orgFilename=${ffvo.orgFilename}&serFilename=${ffvo.serFilename}">
										${ffvo.orgFilename}(${ffvo.filesize})
									</a>:${ffvo.userid}
								</span>
							</td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
		</div>
		<div style="height:100%; width:10%; float:left;" >
			<div class="trLine pointer" style="height:50%; width:100%; float:top; display:table;" onclick="delToFile()">
				<div style="display:table-cell; vertical-align:middle; text-align:center; border-left:1px dotted gray;">[삭제]</div>
			</div>
			<div class="trLine pointer" style="height:50%; width:100%; float:top; display:table;" onclick="restoreToFile()">
				<div style="display:table-cell; vertical-align:middle; text-align:center; border-left:1px dotted gray; border-top:1px dotted gray;">[복원]</div>
			</div>
		</div>
	</td>
<tr>















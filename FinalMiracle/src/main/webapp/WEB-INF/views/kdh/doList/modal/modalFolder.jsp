<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.miracle.kdh.model.FolderVO" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	#teamwonList{
		float:left;
		z-index:1000;
		position: absolute;
		background-color:white;
		border:1px solid black;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		$(".hiddenEdit").hide();
	});
	
	function deleteFolderTeamwon(element) {
		changeFlag = true;
		var cnt = 0;
		var userid = $(element).find("span").text(); 
		$(".folderTeamwon").each(function(){
			cnt++;
		});
		if(cnt > 1) { // 담당자가 둘 이상이라면
			$(element).remove();
		} else { // 담당자가 하나라면
			alert("담당자는 최소 1명 이상이여야 하므로\n"+userid+"님을 제외하실 수 없습니다.");
		}
	}
</script>

<div class="modal-dialog">
	<div class="modal-content" align="center">
		<div class="modal-header">
			<button type="button" class="close modalClose">&times;</button>
			<!-- &times; : x버튼으로 표시됨 -->
			<h4 class="modal-title" align="center">
				::: 폴더 상세정보 :::<br/>
				<span style="font-size: 9pt; margin-left: -25px;">
					(<span style="color: green;">녹색글자</span>는 수정가능한 항목입니다.)
				</span>
			</h4>
		</div>
		<div class="modal-body" style="width:100%; height:auto; background-color:#F0F0F0 !important;">
			<form name="modalInfoFrm" id="modalInfoFrm" enctype="multipart/form-data" method="post">
			<!-- enctype="multipart/form-data" : 파일 첨부를 위해 인코딩 타입 설정 -->
			<!-- method="post" : 파일 보낼때는 반드시 post 여야만 한다. -->
				<table style="width:100%;">
					<tbody>
						<tr class="trLine">
							<td class="infoClass" style="width:135px;">폴더이름</td>
							<td class="infoData showInfo" style="width:500px;">${map.fvo.subject}
							<td class="infoData hiddenEdit" style="width:500px;">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="subject" id="modalSubject" value="${map.fvo.subject}" />
							</td>
						</tr>
						
						<tr class="trLine">
							<td class="infoClass">폴더개요</td>
							<td class="infoData showInfo">${map.fvo.content}
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="content" value="${map.fvo.content}" />
							</td>
						</tr>

						<jsp:include page="includePage/modalDatePicker.jsp"/> <!-- 날짜페이지 따로 빼둠 -->

						<tr>
							<td id="addTeamwon" class="infoClass">
								담당&nbsp;<div id="btn_add" style="display:inline-block;" class="pointer">[추가▷]</div>
							</td>
							<td class="infoData">
								<div style="float:left; width:100%;" id="selectedTeamwon">
								<c:forEach var="ftvo" items="${map.folder_teamwonList}" varStatus="status">
									<span id="folderTeamwon${ftvo.fk_teamwon_idx}" class="pointer folderTeamwon" onclick="deleteFolderTeamwon(this)">
										<span id="added${ftvo.userid}">${ftvo.userid}</span>(${ftvo.proceedingTaskCnt}:${ftvo.completeTaskCnt})
										<input type="hidden" name="folder_teamwonIdxArr" value="${ftvo.fk_teamwon_idx}">
									</span>
								</c:forEach>
								</div>
							</td>
						</tr>

						<tr class="trLine">
							<td class="infoClass">폴더 중요도</td>
							<td class="infoData showInfo">${map.fvo.importance}</td>
							<td class="infoData hiddenEdit">
								<%-- <input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="importance" value="${map.fvo.importance}" /> --%>
								<select name="importance" class="hiddenEditSelector">
									<%
										@SuppressWarnings("unchecked")
										HashMap<String, Object> map = (HashMap<String, Object>)request.getAttribute("map");
										FolderVO fvo = (FolderVO)map.get("fvo");
										int i = 0;
										for(i=1; i<=10; i++) {
											if(i == fvo.getImportance()) {
									%>
												<option value="<%= i %>" selected><%= i %></option>
									<%
											} else {
									%>
												<option value="<%= i %>"><%= i %></option>
									<%
											}
										}
									%>
								</select>
							</td>
						</tr>
						
						<tr class="trLine">
							<td class="infoClass">하위 요소 중요도</td>
							<td class="infoData">${map.fvo.importanceAvg}</td>
						</tr>
						<jsp:include page="includePage/modalFileAttachList.jsp"/> <!-- 첨부 파일리스트는 공통이라 따로 뺌 -->
						<jsp:include page="includePage/modalFileAddList.jsp"/> <!-- 파일 추가도 공통이라 따로 뺌 -->
					</tbody>
				</table>
				folder_idx:<input type="text" name="idx" id="folder_idx" value="${map.fvo.idx}" /> <!-- 폴더번호 저장용 -->
				<input type="hidden" name="modalClass" value="folder" /> <!-- 폴더인지 할일인지 구분용 -->
				
				<!-- 댓글 페이징값 저장 시작(댓글페이지에도 다음 폼이 있긴함) -->
				<input type="hidden" name="showIdx" value="${map.pvo.showIdx}" /> <!-- 페이징처리값을 vo로 쉽게 받기 위해서 글번호를 저장해둠 -->
				<input type="hidden" name="selectPage" id="copySelectPage" value="${map.pvo.selectPage}" /> <!-- 현재페이지 저장용 -->
				<input type="hidden" name="sizePerPage" value="${map.pvo.sizePerPage}" /> <!-- 사이즈 저장용 -->
				<input type="hidden" name="blockSize" value="${map.pvo.blockSize}" /> <!-- 블록사이즈 저장용 -->
				<input type="hidden" name="function" value="${map.pvo.function}" /> <!-- 함수 이름 저장용 -->
				<!-- 댓글 페이징값 저장 끝 -->
			</form>
			<br/>
			<div id="modalCommentPage">
				<jsp:include page="includePage/modalCommentPage.jsp"/> <!-- 댓글리스트는 공통이라 따로 뺌 -->
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default modalEdit">정보수정</button>
			<button type="button" class="btn btn-default modalClose">취소</button>
		</div>
	</div>
</div>











<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	
	function deleteFolderTeamwon(idx) {
		$("#folderTeamwon"+idx).remove();
	}
</script>

<div class="modal-dialog">
	<div class="modal-content" align="center">
		<div class="modal-header">
			<button type="button" class="close modalClose">&times;</button>
			<!-- &times; : x버튼으로 표시됨 -->
			<h4 class="modal-title" align="center">
				::: 할일 상세정보 :::<br/>
				<span style="font-size: 9pt; margin-left: -25px;">
					(<span style="color: green;">녹색글자</span>는 수정가능한 항목입니다.)
				</span>
			</h4>
		</div>
		<div class="modal-body" style="width: 100%; height: auto;">
			<form name="modalInfoFrm" id="modalInfoFrm" enctype="multipart/form-data" method="post">
			<!-- enctype="multipart/form-data" : 파일 첨부를 위해 인코딩 타입 설정 -->
			<!-- method="post" : 파일 보낼때는 반드시 post 여야만 한다. -->
				<table>
					<tbody>
						<tr>
							<td class="infoClass">할일제목</td>
							<td class="infoData showInfo">${map.fvo.subject}
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="subject" value="${map.fvo.subject}" />
							</td>
						</tr>
						
						<tr>
							<td class="infoClass">할일개요</td>
							<td class="infoData showInfo">${map.fvo.content}
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="content" value="${map.fvo.content}" />
							</td>
						</tr>
	
						<tr>
							<td class="infoClass">시작일</td>
							<td class="infoData showInfo">${map.fvo.startDate}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="startDate" value="${map.fvo.startDate}" />
							</td>
						</tr>
	
						<tr>
							<td class="infoClass">마감일</td>
							<td class="infoData showInfo">${map.fvo.lastDate}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="lastDate" value="${map.fvo.lastDate}" />
							</td>
	
						</tr>
	
						<tr>
							<td id="addTeamwon" class="infoClass">
								<div id="btn_add" class="pointer">담당 [추가▷]</div>
							</td>
							<td class="infoData">
								<div style="float:left; width:100%;" id="selectedTeamwon">
								<c:forEach var="ftvo" items="${map.folder_teamwonList}" varStatus="status">
									<span id="folderTeamwon${ftvo.fk_teamwon_idx}" class="pointer" onclick="deleteFolderTeamwon(${ftvo.fk_teamwon_idx})">
										<span id="added${ftvo.userid}">${ftvo.userid}</span>(${ftvo.proceedingTaskCnt}:${ftvo.completeTaskCnt})
										<input type="hidden" name="folder_teamwonIdxArr" value="${ftvo.fk_teamwon_idx}">
									</span>
								</c:forEach>
								</div>
							</td>
						</tr>
	
						<tr>
							<td class="infoClass">할일 중요도</td>
							<td class="infoData showInfo">${map.fvo.importance}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="importance" value="${map.fvo.importance}" />
							</td>
						</tr>
						
						<tr>
							<td class="infoClass">완료여부</td>
							<td class="infoData">
								<c:if test="${map.fvo.status == 0}"> <!-- 완료된 할일이라면 -->
									<input style="cursor:pointer;" type="checkbox" id="modalStatus${map.fvo.idx}" class="status" checked/>
									<span style="color:green;" id="modalStatus">
										<label style="cursor:pointer;" for="modalStatus${map.fvo.idx}">완료</label>
									</span>
								</c:if>
								<c:if test="${map.fvo.status == 1}"> <!-- 미완료된 할일이라면 -->
									<input style="cursor:pointer;" type="checkbox" id="modalStatus${map.fvo.idx}" class="status"/>
									<span style="color:red;" id="modalStatus">
										<label style="cursor:pointer;" for="modalStatus${map.fvo.idx}">미완료</label>
									</span>
								</c:if>
							</td>
						</tr>
						
						<tr>
							<td>
								<input type="file" name="attach" id="attach" /> <!-- type="file" : 파일을 선택하고 저장할 수 있는 타입 -->
							</td>
						</tr>
					</tbody>
				</table>
				folder_idx:<input type="text" name="idx" id="folder_idx" value="${map.fvo.idx}" /> <!-- 폴더번호 저장용 -->
			</form>
			<br/>
			<div id="modalCommentPage">
				<jsp:include page="modalCommentPage.jsp"/>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default modalEdit">정보수정</button>
			<button type="button" class="btn btn-default modalClose">취소</button>
		</div>
	</div>
</div>














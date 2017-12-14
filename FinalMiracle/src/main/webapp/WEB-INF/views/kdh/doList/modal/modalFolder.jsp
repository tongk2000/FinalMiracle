<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	$(document).ready(function(){
		$(".hiddenEdit").hide();
	});
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
		<div class="modal-body" style="width: 100%; height:auto;">
			<form name="modalInfoFrm">
				<table>
					<tbody>
						<tr>
							<td class="infoClass">폴더이름</td>
							<td class="infoData showInfo">${map.fvo.subject}
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="subject" value="${map.fvo.subject}" />
							</td>
						</tr>
						
						<tr>
							<td class="infoClass">폴더개요</td>
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
							<td class="infoClass">담당</td>
							<td class="infoData">
								<c:forEach var="ftvo" items="${map.folder_teamwonList}" varStatus="status">
									${ftvo.userid}(${ftvo.proceedingTaskCnt}:${ftvo.completeTaskCnt})<c:if test="${status.count != map.folder_teamwonList.size()}">,</c:if>
								</c:forEach>
							</td>
						</tr>

						<tr>
							<td class="infoClass">폴더 중요도</td>
							<td class="infoData showInfo">${map.fvo.importance}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="importance" value="${map.fvo.importance}" />
							</td>
						</tr>
						
						<tr>
							<td class="infoClass">하위 요소 중요도</td>
							<td class="infoData showInfo">${map.fvo.importanceAvg}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="importanceAvg" value="${map.fvo.importanceAvg}" />
							</td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" name="idx" value="${map.fvo.idx}" /> <!-- 폴더번호 저장용 -->
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











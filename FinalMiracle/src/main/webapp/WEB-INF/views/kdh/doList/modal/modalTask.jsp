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
				::: 할일 상세정보 :::<br/>
				<span style="font-size: 9pt; margin-left: -25px;">
					(<span style="color: green;">녹색글자</span>는 수정가능한 항목입니다.)
				</span>
			</h4>
		</div>
		<div class="modal-body" style="width: 100%; height: 400px;">
			<form name="modalInfoFrm">
				<table>
					<tbody>
						<tr>
							<td class="infoClass">할일제목</td>
							<td class="infoData showInfo">${fvo.subject}
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="subject" value="${fvo.subject}" />
							</td>
						</tr>
						
						<tr>
							<td class="infoClass">할일개요</td>
							<td class="infoData showInfo">${fvo.content}
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="content" value="${fvo.content}" />
							</td>
						</tr>
	
						<tr>
							<td class="infoClass">시작일</td>
							<td class="infoData showInfo">${fvo.startDate}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="startDate" value="${fvo.startDate}" />
							</td>
						</tr>
	
						<tr>
							<td class="infoClass">마감일</td>
							<td class="infoData showInfo">${fvo.lastDate}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="lastDate" value="${fvo.lastDate}" />
							</td>
	
						</tr>
	
						<tr>
							<td class="infoClass">담당</td>
							<td class="infoData">
								<c:forEach var="ftvo" items="${folder_teamwonList}" varStatus="status">
									${ftvo.userid}(${ftvo.proceedingTaskCnt}:${ftvo.completeTaskCnt})<c:if test="${status.count != folder_teamwonList.size()}">,</c:if>
								</c:forEach>
							</td>
						</tr>
	
						<tr>
							<td class="infoClass">할일 중요도</td>
							<td class="infoData showInfo">${fvo.importance}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="importance" value="${fvo.importance}" />
							</td>
						</tr>
						
						<tr>
							<td class="infoClass">완료여부</td>
							<td class="infoData">
								<c:if test="${fvo.status == 0}"> <!-- 완료된 할일이라면 -->
									<input type="checkbox" id="modalStatus${fvo.idx}" class="status" checked/>
									<span style="color:green;" id="modalStatus">
										<label for="modalStatus${fvo.idx}">완료</label>
									</span>
								</c:if>
								<c:if test="${fvo.status == 1}"> <!-- 미완료된 할일이라면 -->
									<input type="checkbox" id="modalStatus${fvo.idx}" class="status"/>
									<span style="color:red;" id="modalStatus">
										<label for="modalStatus${fvo.idx}">미완료</label>
									</span>
								</c:if>
							</td>
						</tr>
					</tbody>
				</table>
				<input type="hidden" name="idx" value="${fvo.idx}" /> <!-- 폴더번호 저장용 -->
			</form>
			<br/>
			<div>
				<form name="addCommentFrm">
					<span>댓글 작성</span><br/>
					<input type="text" readonly name="userid" size="10" value="${sessionScope.loginUser.userid}"/>
					<input type="text" name="content" size="40" placeholder="내용을 입력해주세요."/>
					<input type="button" value="작성" onclick="addComment()" />
					<input type="hidden" name="fk_folder_idx" value="${fvo.idx}" /> <!-- 폴더번호 저장용 -->
				</form>
			</div>
			<br/>
			<tables>
				<thead>
					<tr>
						<th>작성자</th>
						<th>댓글내용</th>
						<th>작성일자</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody id="modalCommentList">
					<c:if test="${empty folder_commentList}">
						<td colspan="3">등록된 댓글이 없습니다.</td>
					</c:if>
					<c:if test="${not empty folder_commentList}">
						<c:forEach var="fcvo" items="${folder_commentList}" varStatus="status">
							<tr>
								<td>${fcvo.userid}</td>
								<td>${fcvo.content}</td>
								<td>${fcvo.writeDate}</td>
								<td>
									<c:if test="${sessionScope.loginUser.userid == fcvo.userid}">
										x
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default modalEdit">정보수정</button>
			<button type="button" class="btn btn-default modalClose">취소</button>
		</div>
	</div>
</div>














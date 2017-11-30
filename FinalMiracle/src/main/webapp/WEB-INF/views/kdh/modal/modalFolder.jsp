<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<form name="folderInfoEdit">
	<div class="modal-dialog">
		<div class="modal-content" align="center">
			<div class="modal-header">
				<button type="button" class="close modalClose" data-dismiss="modal">&times;</button>
				<!-- &times; : x버튼으로 표시됨 -->
				<h4 class="modal-title" align="center">
					:::<span style="color: blue; font-weight: bold;">${fvo.subject}</span> 폴더 상세정보 :::<br/>
					<span style="font-size: 9pt; margin-left: -25px;">
						(<span style="color: green;">녹색글자</span>는 수정가능한 항목입니다.)
					</span>
				</h4>
			</div>
			<div class="modal-body" style="width: 100%; height: 400px;">
				<table>
					<tbody>
						<tr>
							<td class="infoClass">폴더개요</td>
							<td class="infoData">${fvo.content}
								<input type="hidden" name="content" value="${fvo.content}" />
							</td>
						</tr>

						<tr>
							<td class="infoClass">시작일</td>
							<td class="infoData showInfo">${fvo.startDate}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" name="startDate" value="${fvo.startDate}" />
							</td>
						</tr>

						<tr>
							<td class="infoClass">마감일</td>
							<td class="infoData showInfo">${fvo.lastDate}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" name="lastDate" value="${fvo.lastDate}" />
							</td>

						</tr>

						<tr>
							<td class="infoClass">담당</td>
							<td class="infoData">
								<c:forEach var="ftvo" items="${folder_teamwonList}" varStatus="status">
									${ftvo.userid}<c:if test="${status.count != folder_teamwonList.size()}">,</c:if>
								</c:forEach>
							</td>
						</tr>

						<tr>
							<td class="infoClass">폴더 중요도</td>
							<td class="infoData showInfo">${fvo.importance}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" name="importance" value="${fvo.importance}" />
							</td>
						</tr>
						
						<tr>
							<td class="infoClass">하위 요소 중요도</td>
							<td class="infoData showInfo">${fvo.importanceAvg}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" name="fvo.importanceAvg" value="${fvo.importanceAvg}" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div>
				<table>
					<thead>
						<tr>
							<th>작성자</th>
							<th>댓글내용</th>
							<th>작성일자</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty folder_commentList}">
							<td colspan="3">등록된 댓글이 없습니다.</td>
						</c:if>
						<c:if test="${not empty folder_commentList}">
							<c:forEach var="fcvo" items="${folder_commentList}" varStatus="status">
								<tr>
									<td>${fcvo.userid}</td>
									<td>${fcvo.content}</td>
									<td>${fcvo.writeDate}</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" onClick="goEdit();">정보수정</button>
				<button type="button" class="btn btn-default modalClose">취소</button>
			</div>
		</div>
	</div>
</form>














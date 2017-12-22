<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
	/* img {
		width:25px;
		heigth:25px;
	} */
	tr, td, th {
		border:2px dotted lightgray;
		text-align:center;
	} 
</style>
<div class="modal-dialog">
	<%-- Modal content --%>
	<div class="modal-content" align="center">
		<!-- 모달의 header -->
		<div class="modal-header">
			<button type="button" class="close modalClose" data-dismiss="modal">&times;</button>
			<h4 class="modal-title">유저 정보</h4>
		</div>
		<!-- 모달의 content -->
		<div class="modal-body" style="width: 100%; height: 300px;">
			<div>
				<div style="align: center;">
					<table style="width:80%;">
						<c:if test="${n == 1}">
							<c:if test="${empty googleMap}">
								<tr><td colspan="4">데이터가 없습니다.</td></tr>						
							</c:if>
							<c:if test="${not empty googleMap}">
								<thead>
									<tr>
										<th style="width:20%;">유저번호</th>
										<th style="width:27%;">유저아이디</th>
										<th style="width:27%;">유저이름</th>
										<th style="width:27%;">역활</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="google" items="${googleMap}">
									<tr>
										<td style="width:20%;">${google.memberidx}</td>
										<td style="width:27%;"><img src="<%=request.getContextPath() %>/resources/images/${google.img}" style="width:35px; height:35px; word-spacing:10px;" /> ${google.userid}</td>
										<td style="width:27%;">${google.memberName}</td>
										<c:if test="${google.status == 1}">
											<td style="width:27%;">팀원</td>
										</c:if>
										<c:if test="${google.status == 2}">
											<td style="width:27%;">팀장</td>
										</c:if>
									</tr>
									</c:forEach>
								</tbody>	
							</c:if>				
						</c:if>
						<c:if test="${n == 0}">
							<c:if test="${googleMap==null}">
								<tr><td colspan="3">데이터가 없습니다.</td></tr>						
							</c:if>
							<c:if test="${googleMap!=null}">
								<thead>
									<tr>
										<th style="width:33%;">이미지</th>
										<th style="width:33%;">제목</th>
										<th style="width:33%;">내용</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td style="width:33%;"><img src="<%=request.getContextPath() %>/resources/images/${googleMap.img}" style="width:35px; height:35px;"/></td>
										<td style="width:33%;">${googleMap.subject}</td>
										<td style="width:33%;">${googleMap.contents}</td>
									</tr>
								</tbody>					
							</c:if>
						</c:if>
					</table>
				</div>
			</div>
		</div>
		<!-- 모달의 footer -->
		<div class="modal-footer">
			<button type="button" class="btn btn-default modalClose" data-dismiss="modal">Close</button>
		</div>
	</div>
</div>
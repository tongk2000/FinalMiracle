<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="map" value="${userinfo}" />
<div class="modal-dialog">
	<%-- Modal content --%>
	<div class="modal-content" align="center">
		<div class="modal-header">
			<button type="button" class="close modalClose" data-dismiss="modal">&times;</button>
			<h4 class="modal-title">유저 정보</h4>
		</div>
		<div class="modal-body" style="width: 100%; height: 300px;">
			<div>
				<div style="align: center;">
					<table style="border:1px solid black; padding:5px;">
						<thead style="border:1px solid black;">
							<tr style="border:1px solid black;">
								<th colspan="2">회원정보</th>
							</tr>
						</thead>
						<tbody style="border:1px solid black;">
							<tr>
								<td style="border:1px solid black;">유저 아이디 :</td>
								<td style="border:1px solid black;"><img src="<%= request.getContextPath() %>/resources/images/${map.img}" style="width:50px; height:50px;"> ${map.userid}</td>
							</tr>
							<tr>
								<td style="border:1px solid black;">이름 :</td>
								<td style="border:1px solid black;">${map.name}</td>
							</tr>
							<tr>
								<td style="border:1px solid black;">나이 :</td>
								<td style="border:1px solid black;">${map.age}</td>
							</tr>
							<tr>
								<td style="border:1px solid black;">전화번호 :</td>
								<td style="border:1px solid black;">${map.hp}</td>
							</tr>
							<tr>
								<td style="border:1px solid black;">주소 :</td>
								<td style="border:1px solid black;">${map.addr}</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default modalClose"
				data-dismiss="modal">Close</button>
		</div>
	</div>
</div>
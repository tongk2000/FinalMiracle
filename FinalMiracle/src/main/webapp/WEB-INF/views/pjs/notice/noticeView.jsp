<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="modal-dialog">
	<%-- Modal content --%>
	<div class="modal-content" align="center">
		<div class="modal-header">
			<button type="button" class="close myclose" data-dismiss="modal">&times;</button>
			<h4 class="modal-title">유저 정보</h4>
		</div>
		<div class="modal-body" style="width: 100%; height: 300px;">
			<div>
				<div class="container">
					<div style="align: center;">
						<table>
							<thead>
								<tr>
									<th colspan="2">회원정보</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>유저 아이디 :</td>
									<td>${img} ${userid}</td>
								</tr>
								<tr>
									<td>이름 :</td>
									<td>${name}</td>
								</tr>
								<tr>
									<td>나이 :</td>
									<td>${age}</td>
								</tr>
								<tr>
									<td>전화번호 :</td>
									<td>${hp}</td>
								</tr>
								<tr>
									<td>주소 :</td>
									<td>${addr}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default myclose"
				data-dismiss="modal">Close</button>
		</div>
	</div>
</div>
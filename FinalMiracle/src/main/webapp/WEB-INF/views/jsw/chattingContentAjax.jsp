<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<style type="text/css">

.rounded {
  border-radius: 5px;
  font-size: 15px;
  margin: 5px;
}





</style>

</head>
<body>
		<c:forEach var="list" items="${chattingList}" varStatus="status">
			<c:if test="${list.midx == sessionScope.loginUser.idx}">
				<div style="border: 0px solid blue; min-height: 20px; overflow: hidden; color: black;">
					<div onclick="" style="border: 0px solid blue; cursor: pointer; float: right; margin-right: 10px;"><img style="border: 0px solid blue;" class="img-circle" height="35px" width="35px" src="<%=request.getContextPath() %>/resources/files/${list.img}"></div>
					<span style="float: right; font-weight: bold;">나</span><br/>
					<div style="float: right; border: 0px solid black;"><div style="color: gray; font-size: xx-small; display: inline-table; vertical-align: bottom;">${list.chattime}</div> <div class="rounded" style="background-color: yellow; max-width: 180px; display: inline-table; text-align: right;">${list.message}</div></div><br/><br/>
				</div>
			</c:if>
			<c:if test="${list.midx != sessionScope.loginUser.idx}">
			<div style="border: 0px solid blue; min-height: 20px; overflow: hidden; color: black;">
				<div onclick="" style="border: 0px solid blue; cursor: pointer; float: left;"><img style="border: 0px solid blue;" class="img-circle" height="35px" width="35px" src="<%=request.getContextPath() %>/resources/files/${list.img}"></div>
				<div><span style="color: black; float: left;" id="chat${status.count}">${list.name}</span></div><br/>
				<div style="float: left; border: 0px solid black;"><div class="otherchat rounded" style="background-color: white; max-width: 180px; display: inline-table; text-align: left;">${list.message}</div> <div style="color: gray; font-size: xx-small; display: inline; vertical-align: bottom;">${list.chattime}</div></div><br/><br/>
				</div>
			</c:if>
		</c:forEach>




<!-- 회원 상세정보 모달 창 -->
<!-- Modal -->
<!-- <div class="modal fade modal-center" id="chatModal" role="dialog">
	<div class="modal-dialog modal-sm modal-center">
		Modal content
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">회원 상세 정보</h4>
			</div>
			<div class="modal-body">
			<p></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div> -->



</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress"%>

<%-- ===== tiles 중 header 페이지 만들기  ===== --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<%
	// === 서버 IP 주소 알아오기 === //
	InetAddress inet = InetAddress.getLocalHost();
	String serverIP = inet.getHostAddress();
	int portnumber = request.getServerPort();

	String serverName = "http://" + serverIP + ":" + portnumber;
%>

<style type="text/css">
	
	.modal.modal-center {
	  text-align: center;
	}
	
	@media screen and (min-width: 768px) { 
	  .modal.modal-center:before {
	    display: inline-block;
	    vertical-align: middle;
	    content: " ";
	    height: 100%;
	  }
	}
	
	.modal-dialog.modal-center {
	  display: inline-block;
	  text-align: left;
	  vertical-align: middle; 
	}

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		
	});

	function showMyInfo() {
		$.ajax({
			url: "member_edit.mr",
			type: "GET",
			dataType: "HTML", // ajax 요청에 의해 url 요청페이지로 부터 리턴받는 데이터타입. xml, json, html, text 가 있음.
			success: function(data) {	
				$("#modalBody").html(data);
				$("#memberEditModal").modal();
			}, // end of success: function()----------
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		}); // end of $.ajax()------------------------
	}
</script>

<!-- 통합검색메뉴 -->
<div style="/* border: 1px solid blue; */ float: left; width: 30%; height: 50px;" align="right">
	<input type="text" class="form-control input-md" style="margin-top: 7px; width: 80%;" placeholder="통합 검색" />
</div>

<div style="/* border: 1px solid blue; */ float: left; width: 3%; height: 50px;" align="center">
	<a href="<%= request.getContextPath() %>/doList.mr" title="검색">
		<img src="<%= request.getContextPath() %>/resources/images/icon/14.png" class="iconPng toggleIconPng" />
	</a>
</div>

<!-- ===== 로그인 성공한 사용자 정보 출력 ===== -->
<c:if test="${sessionScope.loginUser != null}">
	<a href="<%= request.getContextPath() %>/tmForm.mr" title="팀 선택">
		<img src="<%= request.getContextPath() %>/resources/images/icon/12.png" class="iconPng toggleIconPng"/>
	</a>
	<a href="<%= request.getContextPath() %>/member_logout.mr" title="로그아웃">
		<img src="<%= request.getContextPath() %>/resources/images/icon/13.png" class="iconPng toggleIconPng" />
	</a>
	<div style="float:right;">
		<a href="javascript:showMyInfo();" title="${sessionScope.loginUser.name}(${sessionScope.loginUser.userid})">
			<img src="<%= request.getContextPath() %>/resources/images/${sessionScope.loginUser.img}" style="height: 50px; width: 50px;">
		</a>
	</div>
</c:if>


<!-- 내 정보 수정 모달 창 -->
<!-- Modal -->
<div class="modal modal-center fade" id="memberEditModal" role="dialog">
	<div class="modal-dialog modal-md modal-center">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">내 정보 수정</h4>
			</div>
			<div class="modal-body" id="modalBody" style="height: auto;">
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>

	</div>
</div>





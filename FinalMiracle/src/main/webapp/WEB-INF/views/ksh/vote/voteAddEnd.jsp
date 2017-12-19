<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/BootStrapStudy/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<script type="text/javascript">
	
	<c:if test="${x == 1 && (n == 1 || m == 1)}">
		swal({
		  title: "투표를 등록하였습니다.",
		  type: "success",
		  showCancelButton: true,
		  confirmButtonClass: "btn-primary",
		  confirmButtonText: "확인",
		},
		function(isConfirm) {
		  if (isConfirm) {
			 location.href="<%= request.getContextPath() %>/voteList.mr";
		  }
		});
	</c:if>
	
	<c:if test="${x != 1}">
		alert("투표글이 전부 작성되지 않았습니다.");
		location.href="<%= request.getContextPath() %>/voteList.mr";
		
		swal({
		  title: "투표글이 전부 작성되지 않았습니다.",
		  type: "error",
		  showCancelButton: true,
		  confirmButtonClass: "btn-primary",
		  confirmButtonText: "확인",
		},
		function(isConfirm) {
		  if (isConfirm) {
			 location.href="<%= request.getContextPath() %>/voteList.mr";
		  }
		});
	</c:if>
	
	<c:if test="${(n != 1 || m != 1)}">		
		swal({
		  title: "투표의 문항들을 확인하세요.",
		  type: "error",
		  showCancelButton: true,
		  confirmButtonClass: "btn-primary",
		  confirmButtonText: "확인",
		},
		function(isConfirm) {
		  if (isConfirm) {
			 location.href="<%= request.getContextPath() %>/voteList.mr";
		  }
		});
	</c:if>
	
	
	
	//글목록을 보여주는 페이지로 이동하자
	
</script>
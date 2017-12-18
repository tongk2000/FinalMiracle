<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅 초대 선택</title>

<style type="text/css">


</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript">
	if ( $("#inviteMember").length <= 0 ) {
		$("#memberinfo").append("<div id='inviteMember'>초대할 인원</div>");
	}
	var path = "<%=request.getContextPath() %>";
	var data ="";
	<c:forEach var="list" items="${teamwonList}" varStatus="status">
		$("#mem"+${list.idx}).click(function() {
			if ( $("#invite"+${list.idx}).length <= 0 ) { 
				data += "<div id='invite${list.idx}' class='inv' style='border: 1px solid black; cursor: pointer;'>";
				data += "<div style='border: 1px solid blue; cursor: pointer; float: left;'><img height='70px' width='70px' src='"+path+"/resources/images/"+"${list.img}"+"'></div>";
				data +=	"<div>아이디 : ${list.userid}</div>";
				data +=	"<div>이름 : ${list.name}</div><br/><br/>";
				data +=	"<input type='hidden' id='tw${status.index}' class='twon' value='${list.idx}' />";
				data +=	"</div>";
				$("#memberinfo").append(data);
			};
			$("#mem"+${list.idx}).hide();
			data = "";
		});
		
		$(document).on("click", "#invite"+${list.idx}, function(){
			$("#invite"+${list.idx}).remove();
			$("#mem"+${list.idx}).show();
		});
		
		/* $("#invite"+${status.count}).click(function() {
			alert("1");
			$("#invite"+${status.count}).remove();
			$("#mem"+${status.count}).show();
		}); */
	</c:forEach>
</script>

</head>
<body>
	<c:if test="${!empty teamwonList}">
		<c:forEach var="list" items="${teamwonList}" varStatus="status">
			<div id="mem${list.idx}" style="width: 50%; border: 1px solid black; float: left; cursor: pointer;">
			<div style="border: 1px solid blue; float: left;"><img height="70px" width="70px" src="<%=request.getContextPath() %>/resources/images/${list.img}"></div>
			<div>아이디 : ${list.userid}</div>
			<div>이름 : ${list.name}</div><br/>
			</div>
		</c:forEach>
	</c:if>
	<c:if test="${empty teamwonList}">
		<div>검색된 인원이 없습니다</div>
	</c:if>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">
<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>
<!DOCTYPE>
<html>
<head>
<style>
	th {
		background-color:gray;
		padding:10px;
	}
	table, td, tr, th {
		border : 1px solid black;
		padding:20px;
	}
	#content {
		height:100%;
	}
	img {
		height: 40px;
		width: 40px;
	}
</style>
<script>
	$(document).ready(function(){
		$("#addPeople").hide
		$('.summernote').summernote({
	      height: 350,          // 기본 높이값
	      minHeight: null,      // 최소 높이값(null은 제한 없음)
	      maxHeight: null,      // 최대 높이값(null은 제한 없음)
	      focus: true,          // 페이지가 열릴때 포커스를 지정함
	      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
	    });
		
	/* 	$("#spinneroqty").spinner({
  	      spin: function( event, ui ) {
  	        if( ui.value > 100 ) {
  	          $( this ).spinner( "value", 0 ); 
  	          /* 4 -> 3
  	          inPeople+4 
  	          return false;
  	        } 
  	        else if ( ui.value < 0 ) {
  	          $( this ).spinner( "value", 0 );
  	          $("#selectPeople").append($("#addPeople").html());
  	          $("#selectPeople").find("#inPeople").addClass("inPeople"+$("#spinneroqty").val() ) );
  	          return false;
  	        }
  	      }
	  	});
		$("#spinneroqty").change(function(){
			
		}); */
	});	
</script>
<meta charset="UTF-8">
<title>쪽지쓰기</title>
<script type="text/javascript">
	$(document).ready(function(){
		$("#cancel").blur(function(){
			history.back();
		});
		
		/* $(".item").change(function(){
			var item = $(this).val();
		}); */
	});
</script>
</head>
<body>
	<div style="border:1px solid green; padding:9px;">
		<div style="border:1px solid red; padding:9px;">
			<div style="border:1px solid blue; padding:9px;"  align="center">
				<div style="border:1px solid purple;">
					<a href="<%=request.getContextPath()%>/memoWrite.mr"><span style="color:red;">쪽지 쓰기</span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="<%=request.getContextPath()%>/memomemory.mr"><span style="color:red;">보낸 쪽지</span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="<%=request.getContextPath()%>/memoreceiver.mr"><span style="color:red;">받은 쪽지</span></a>
				</div>
				<table>
					<tbody>
						<tr> <!--  teamNum, m.userid, m.idx as memberNum, w.status, m.img -->
							<c:if test="${userTeam.status == 2}">
								<th>유저   </th><td><img src="<%= request.getContextPath() %>/resources/images/${userTeam.img}"> ${userTeam.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[${userTeam.teamNum}팀  팀장]</td> 
							</c:if>
							<c:if test="${userTeam.status == 1}">
								<th>유저   </th><td><img src="<%= request.getContextPath() %>/resources/images/${userTeam.img}"> ${userTeam.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[${userTeam.teamNum}팀   팀원]</td> 
							</c:if>
						</tr>
						<tr>
							<th>보낼 사람</th>
							<td id="d">
							<input id="spinneroqty" name="ibgoqty" value="0" style="width: 30px; height: 20px; z-index:1000;">
							<div id="selectPeople">
								<div class="d" style="border:1px solid pink;">
									<%-- <input type="radio" id="team" name="item" class="item" value="1"><label for="team">팀원</label>
									<select name="choice" id="choice">
										<c:forEach var="team" items="${mapteam}">
											<option value="${team.name}">${team.name +' '+team.teamNum}</option> <!--${team.name +', '+team.teamNum}  -->
										</c:forEach>
									</select>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --%>
								</div>
							</div>
							</td>	
						</tr>
						<tr>
							<th>제목   </th><td><input type="text" name="subject" id="subject"/></td>
						</tr>
						<tr>
							<th>내용   </th><td><textarea name="content" id="content" class="summernote"></textarea></td>
						</tr>
					</tbody>
				</table>
				<div style="border:1px solid gray; display:relative">
					<button type="reset" onClick="javascript:location.reload()" id="cancel">취소</button>
					<button type="button" onClick="goWrite();">완료</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

<!-- <div id="addPeople">
	<div id="inPeople">
		<span>추가요소</span>
	</div>
</div>
-->














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
		padding:7px;
	}
	#content {
		height:100%;
	}
	.imgs {
		height: 40px;
		width: 40px;
	}
</style>
<script>
	$(document).ready(function(){
		$("#cancel").blur(function(){
			window.location.reload();
		});
		$("#addPeople").hide
		$('.summernote').summernote({
	      height: 350,          // 기본 높이값
	      minHeight: null,      // 최소 높이값(null은 제한 없음)
	      maxHeight: null,      // 최대 높이값(null은 제한 없음)
	      focus: true,          // 페이지가 열릴때 포커스를 지정함
	      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
	    });
		$("#spinnerOqty").spinner({
	  	      spin: function( event, ui ) {
	  	        if( ui.value > 10 ) {
	  	          $( this ).spinner( "value", 0 ); 
	  	          return false;
	  	        } 
	  	        else if ( ui.value < 0 ) {
	  	          $( this ).spinner( "value", 0 );
	  	          return false;
	  	        }
	  	      }
	  	    });
			
		$("#spinnerOqty").bind("spinstop", function(){
			// 스핀너는 이벤트가 "change" 가 아니라 "spinstop" 이다.
			var html = "";
			
			var spinnerOqtyVal = $("#spinnerOqty").val();
			var i = $("#spinnerOqty").val();
			if(spinnerOqtyVal == "0") {
				$("#divfileattach").empty();
				return;
			}
			else
			{
				for(var i=0; i<parseInt(spinnerOqtyVal); i++) {
					if(i == 0) {
						html +="<br/><br/>";
						html +="<div style='float:left'>";
						html +="<select name='choice' id='choice"+i+"' class='choice'> ";
						html +="<c:forEach var='team' items='${mapteam}'> ";
						html +="<option value='${team.userid}'>${team.name}    ${team.teamNum}팀</option> ";  
						html +="</c:forEach> ";
						html +="</select>"; 
						html +="</div>";  
						/* html +="<input type='text' name='items' id='num'+i class='form-control' style='width: 300px;' /> "; */
					}
					else {
						html +="<div style='float:left; margin-left:5px;'>";
						html +="<select name='choice' id='choice"+i+"' class='choice'> ";
						html +="<c:forEach var='team' items='${mapteam}'> ";
						html +="<option value='${team.userid}'>${team.name}    ${team.teamNum}팀</option>";  
						html +="</c:forEach> ";
						html +="</select>"; 
						html +="</div>";  
					}
				}	
				$("#divfileattach").empty();
				$("#divfileattach").append(html);
			}
		});
		
	});	
	function goWrite() {
		var arr = new Array();
		var cnt=0;
		$(".choice").each(function(){
			arr[cnt] = $("#choice"+cnt).val();
			cnt++;
		});
		var frm = document.write;
		frm.idx.value = arr;
		alert($("#subject").val());
		alert($("#content").val());
		frm.subject.value = $("#subject").val();
		frm.content.value = $("#content").val();
		frm.userid.value = "${sessionScope.loginUser.userid}";
		frm.action="memoWriteEnd.mr";
		frm.method="post";
		frm.submit();
	}
</script>
<meta charset="UTF-8">
<title>쪽지쓰기</title>
</head>
<body>
	<c:set var="team" value="${teamNum}"></c:set>
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
								<th>유저   </th><td><img src="<%= request.getContextPath() %>/resources/images/${userTeam.img}" class="imgs"> ${userTeam.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[${userTeam.teamNum}팀  팀장]</td> 
							</c:if>
							<c:if test="${userTeam.status == 1}">
								<th>유저   </th><td><img src="<%= request.getContextPath() %>/resources/images/${userTeam.img}" class="imgs"> ${userTeam.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[${userTeam.teamNum}팀   팀원]</td> 
							</c:if>
						</tr>
						<tr>
							<th>보낼 사람</th>
			         		<td>
			         		    <label for="spinnerOqty">선택 : </label>
			  		            <input id="spinnerOqty" value="0" style="width: 30px; height: 20px;">
			         		    <div id="divfileattach" style="display:inline;"></div>
			         		</td>
							<%-- <td id="d">
								<div id="selectPeople">
									<div class="d" style="border:4px dotted pink;">
										<input type="radio" id="team" name="item" class="item" value="1"><label for="team">팀원</label>
										<select name="choice" id="choice">
											<c:forEach var="team" items="${mapteam}">
												<option value="${team.name}">${team.name +' '+team.teamNum}</option> <!--${team.name +', '+team.teamNum}  -->
											</c:forEach>
										</select> 
									</div>
								</div>
							</td>	 --%>
						</tr>
						<tr>
							<th>제목   </th><td><input type="text" id="subject"/></td>
						</tr>
						<tr>
							<th>내용   </th><td><textarea name="content" id="content" class="summernote"></textarea></td>
						</tr>
					</tbody>
				</table>
				<div style="border:1px solid gray; display:relative">
					<button type="reset" onClick="javascript:history.back();" id="cancel">취소</button>
					<button type="button" onClick="goWrite();">완료</button>
				</div>
			</div>
		</div>
	</div>
	<form name="write">
		<input type="hidden" name="userid">
		<input type="hidden" name="idx">
		<input type="hidden" name="subject">
		<input type="hidden" name="content">
	</form>
</body>
</html>

<!-- <div id="addPeople">
	<div id="inPeople">
		<span>추가요소</span>
	</div>
</div>
-->















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
		$('.summernote').summernote({
	      height: 350,          // 기본 높이값
	      minHeight: null,      // 최소 높이값(null은 제한 없음)
	      maxHeight: null,      // 최대 높이값(null은 제한 없음)
	      focus: true,          // 페이지가 열릴때 포커스를 지정함
	      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
	    });
		$("#back").blur(function(){
			window.location.reload();
		});
	});	
	function goDel(ridx,sender) {
		var frm = document.del;
		frm.idx.value=ridx;
		frm.action="memoreceiverDel.mr";
		frm.method="post";
		frm.submit();
	}
</script>
<meta charset="UTF-8">
<title>쪽지쓰기</title>
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
					<c:set var="receiver" value="${map}"></c:set>
						<tr> <!-- IDX, SUBJECT, CONTENT, SENDER, SSTATUS, name, img, w.status -->
							<c:if test="${receiver.status == 2}">
								<th>유저 :  </th><td><img src="<%= request.getContextPath() %>/resources/images/${receiver.img}"> ${receiver.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[${teamNum}팀  팀장]</td> 
							</c:if>
							<c:if test="${receiver.status == 1}">
								<th>유저 :  </th><td><img src="<%= request.getContextPath() %>/resources/images/${receiver.img}"> ${receiver.name} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[${teamNum}팀   팀원]</td> 
							</c:if>
						</tr>
						<tr>
							<th>제목 :  </th><td><input type="text" name="subject" id="subject" readonly value="${receiver.subject}"/></td>
						</tr>
						<tr>
							<th>내용 :  </th><td><textarea name="content" id="content" class="summernote" >${receiver.content}</textarea></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div style="border:1px solid gray; float:right">
				<button type="reset" onClick="javascript:history.back();" id="back">뒤로가기</button>
				<button type="button" onClick="goDel('${receiver.idx}');">삭제</button>
			</div>
		</div>
	</div>
	<form name="del">
		<input type="hidden" name="idx">
	</form>
</body>
</html>
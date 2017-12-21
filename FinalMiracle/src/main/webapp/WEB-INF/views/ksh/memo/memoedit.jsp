<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />
<link href="<%=request.getContextPath() %>/resources/summernote/summernote.css" rel="stylesheet">

<script type="text/javascript" src="<%= request.getContextPath() %>/resources/jqueryuijs/jquery-ui.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/summernote.js"></script>
<script src="<%=request.getContextPath() %>/resources/summernote/lang/summernote-ko-KR.js"></script>

<style type="text/css">
  th {width: 25%;}
  #folderdiv {width:200px; float:left; margin-left: 10px;}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$('.summernote').summernote({
	      height: 300,          // 기본 높이값
	      minHeight: null,      // 최소 높이값(null은 제한 없음)
	      maxHeight: null,      // 최대 높이값(null은 제한 없음)
	      focus: true,          // 페이지가 열릴때 포커스를 지정함
	      lang: 'ko-KR'         // 한국어 지정(기본값은 en-US)
	    });
		
		$("#folder").change(function(){
			
			var folder = $("#folder").val();
			var html = "";
			
			if(folder == "새분류"){
				html += "<input id='newfolder' name='newfolder' class='form-control' style='width: 200px;' placeholder='새분류 입력칸' />"
				
				$("#folderdiv").append(html);
			} else {
				$("#folderdiv").empty();
			}
		});
		
	}); // end of $(document).ready()-----------------------------------
	

	function goEdit() {
		var subject = document.getElementById("subject").value;
		var content = document.getElementById("content").value;
		var folder = document.getElementById("folder").value;
		
		subject = subject.trim();
		folder = folder.trim();
		
		if(subject == "" || content == "" || folder == ""){
			swal("수정 실패!", "모든 항목에 빈 칸 없이 넣어주세요.", "error");
			return
		} else {
			/* if(confirm("메모를 수정하시겠습니까?")){
				var frm = document.EditFrm;
				
				frm.submit();
			} */
			
			swal({
			  title: "수정 여부",
			  text: "메모를 수정하시겠습니까?",
			  type: "warning",
			  showCancelButton: true,
			  confirmButtonClass: "btn-warning",
			  confirmButtonText: "수정",
			  cancelButtonText: "취소",
			  closeOnConfirm: false,
			  closeOnCancel: true
			},
			function(isConfirm) {
			  if (isConfirm) {
				var frm = document.EditFrm;
					
				frm.submit();
			  }
			});
		}
		
		
	}
	
</script>

<div style="width:100%; font-family: verdana;" align="center">
	<h1 style="margin: 2%;">메모 수정</h1>
	
	<form class="form-inline" name="EditFrm" action="<%= request.getContextPath() %>/memoEditEnd.mr" method="post" enctype="multipart/form-data" >
		<div style="border: none;">
			<table id="table" class="table" style="width: 90%; margin-top: 50px; border: none; background-image:url('<%= request.getContextPath() %>/resources/images/noteimage.jpg');">
				<tr>
					<td style="border-top: none;">
						<div style="width: 100%; float: left;">
							<div style="width: 120px; float: left;">
								<select name="folder" id="folder" class="form-control">
									<c:forEach var="memo" items="${memovo}" varStatus="status">
										<option value="${memo.groups}">${memo.groups}(현재)</option>
									</c:forEach>
									<option value="전체">전체</option>
									<option value="중요">중요</option>
									<c:forEach var="folder" items="${folderlist}" varStatus="status">
										<option value="${folder}">${folder}</option>
									</c:forEach>
									<option value="새분류">새분류</option>
								</select>
							</div>
							<div id="folderdiv"></div>
						</div>
					</td>
				</tr>
				<tr>
					<td style="border-top: none;">
						<div style="width: 100%;  float: left;">
							<c:forEach var="memo" items="${memovo}" varStatus="status">
						  		<input type="text" name="subject" id="subject" class="form-control" style="width: 100%;" value="${memo.subject}" placeholder="제목을 입력하세요" />
						  	</c:forEach>
						</div> 
					</td>
				</tr>
				<tr>
					<td style="border-top: none;">
					    <div style="width: 100%">
						   <textarea name="content" id="content" class="summernote">
						   <c:forEach var="memo" items="${memovo}" varStatus="status">
						   		${memo.content}
						   </c:forEach>
						   </textarea>
						</div>
					</td>
				</tr>
			</table>
			<br/>
		</div>
		
		<button type="button" class="btn btn-primary" style="margin-right: 10px;" onClick="goEdit();">메모수정</button>
		<button type="button" class="btn btn-default" style="margin-right: 10px;" onClick="javascript:location.href='<%= request.getContextPath() %>/${gobackURL}'">메모목록</button> 
		
		<c:forEach var="memo" items="${memovo}" varStatus="status">
			<input type="hidden" id="idx" name="idx" value="${memo.idx}" />
		</c:forEach>
		<input type="hidden" name="gobackURL" value="${gobackURL}">
	</form>
</div>
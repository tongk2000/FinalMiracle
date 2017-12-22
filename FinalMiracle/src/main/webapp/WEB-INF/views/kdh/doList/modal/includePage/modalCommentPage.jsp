<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	#modalCommentTable th, #modalCommentTable td {
		border:1px solid lightgray;
		text-align:center;
	}
	#modalCommentTable th {
		
	}
	#modalCommentTable td {
		
	}
</style>

<script type="text/javascript">
	window.onload = function(){
		var selectPage = "${selectPage}";
		if(selectPage != "") {
			document.getElementById("selectPage").value = selectPage;
		}
	}
	function goCommentPage(pageNo){
		document.getElementById("selectPage").value = pageNo;
		document.getElementById("copySelectPage").value = pageNo; // 모달정보수정시 댓글 페이지 유지용
		var frm = $("form[name=addCommentFrm]").serialize();
		$.ajax({
			url:"do_goCommentPage.mr",
			data:frm,
			dataType:"html",
			success:function(data){
				$("#modalCommentPage").html(data);
			}, error:function(request, status){
				alert(request.status+"에러!!\n관리자에게 문의하세요.");
			}
		});
	}
	function commentDelete(idx) {
		alert(idx);
	}
</script>

<br/>
<form name="addCommentFrm">
	<div style="background-color:#DCDCDC; width:100%; border-radius:10px;">
		<div style="display:inline-block; width:80px;">&nbsp;&nbsp;${sessionScope.loginUser.userid}</div> 
		<input type="text" name="content" id="modalContent" size="60" style="background-color:#C8C8C8; border:none;" placeholder="&nbsp;&nbsp;내용을 입력해주세요."/>
		<div style="display:inline-block; width:40px; text-align:left;">
			<input type="button" style="background-color:#DCDCDC; border:none;" onclick="addComment()" value="작성"/>
		</div>
	</div>
	<input type="hidden" readonly name="userid" size="7" value="${sessionScope.loginUser.userid}"/>
	<input type="hidden" name="fk_folder_idx" value="${map.pvo.showIdx}" /> <!-- 폴더번호 저장용 -->
	<input type="hidden" name="showIdx" value="${map.pvo.showIdx}" /> <!-- 페이징처리값을 vo로 쉽게 받기 위해서 글번호를 저장해둠 -->
	<input type="hidden" name="selectPage" id="selectPage" value="${map.pvo.selectPage}" /> <!-- 현재페이지 저장용 -->
	<input type="hidden" name="sizePerPage" value="${map.pvo.sizePerPage}" /> <!-- 사이즈 저장용 -->
	<input type="hidden" name="blockSize" value="${map.pvo.blockSize}" /> <!-- 블록사이즈 저장용 -->
	<input type="hidden" name="function" value="${map.pvo.function}" /> <!-- 함수 이름 저장용 -->
</form>

<table id="modalCommentTable" style="width:100%; table-layout:fixed; margin-top:10px;">
	<thead style="width:100%;">
		<tr style="width:100%;">
			<th style="width:15%;">작성자</th>
			<th style="width:53%;">댓글내용</th>
			<th style="width:25%;">작성일자</th>
			<th style="width:7%;">삭제</th>
		</tr>
	</thead>
	<tbody id="modalCommentList">
		<c:if test="${empty map.folder_commentList}">
			<td colspan="4" style="text-align:center;">등록된 댓글이 없습니다.</td>
		</c:if>
		<c:if test="${not empty map.folder_commentList}">
			<c:forEach var="fcvo" items="${map.folder_commentList}" varStatus="status">
				<tr class="trLine">
					<td>${fcvo.userid}</td>
					<td style="text-align:left;">${fcvo.content}</td>
					<td>${fcvo.writeDate}</td>
					<td align="center">
						<c:if test="${sessionScope.loginUser.userid == fcvo.userid}">
							<span style="cursor:pointer;" onclick="commentDelete(${fcvo.idx})">x</span>
						</c:if>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
<div id="pageBar">${map.pvo.pageBar}</div>







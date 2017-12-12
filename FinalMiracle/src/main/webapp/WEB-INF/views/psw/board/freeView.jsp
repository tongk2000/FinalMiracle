<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
   
<style type="text/css">
	.title {
		border: 1px solid lightgray;
		border-left: none;
		border-right: none;
	}	
	.above {
		background-color: lightblue;
	}
	
	th {
		width: 20%;
	}
	

</style>

<script type="text/javascript">
    function goWrite() {
    	var addWriteFrm = document.addWriteFrm;
    	addWriteFrm.submit();
    }
</script>

<div style="margin-left: 10%; margin-top: 30px; padding: 10px; border: solid 1px red; width: 80%;">
	
	<table id="table" style="width: 70%; border: 1px solid dimgray; border-left: none; border-right: none;">
		<tr class="title above">
			<td colspan="2">자유게시판입니다.</td>
		</tr>
		<tr class="title">
		<td colspan="2">
			미풍양속을 해치지 않는 범위 내에서 자유롭게 작성해주세요.<br/>
			단, 팀원간 마찰은 마음의 소리 게시판을, 1:1 대화를 원하시는 회원님은 쪽지나 채팅 기능을 이용해주시기 바랍니다.
		</td>
		</tr>
		<!-- ====================== *** 공백용 *** ================================ -->
		<tr>
			<td colspan="2"> <br/><br/><br/>
		</tr>
		
		<tr>
           	<th>
				<img src="<%= request.getContextPath() %>/resources/images/${freevo.img}" style="width: 100px; height: 100px;" align="middle">
           	</th>
           	<td style="border: 1px solid lightgray; border-top: none; border-left: none; border-right: none;">
	           	<input type="hidden" name="idx" value="${freevo.idx}" />
	           	<span style="font-weight: bold; font-size: 11pt;">${freevo.subject}</span><br/>
	           	아이디 : ${freevo.userid} / 성명 : ${freevo.name}<br/>
	           	조회수 : ${freevo.readCnt}
           	</td>
       	</tr>
       	<!-- ============================= *** 내용물 *** ================================ -->
		<tr>
			<td colspan="2">
				<br/><br/>
				<span style="font-size: 11pt;">${freevo.content}</span>
				<br/><br/>
			</td>
		</tr>

		<tr>
			<th>등록일자</th>
			<td>${freevo.regDate}</td>
		</tr>
	</table>
	
	<br/>
	
	<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/freeList.mr'">목록보기</button>
	<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/freeEdit.mr?idx=${freevo.idx}'">수정</button>
	<button type="button" onClick="javascript:location.href='<%= request.getContextPath() %>/freeDel.mr?idx=${freevo.idx}'">삭제</button>
		
	<br/><br/>
	
	<!-- === #83. 댓글쓰기 폼 추가 === -->
	<form name="addWriteFrm" action="<%= request.getContextPath() %>/freeComment.mr" method="get">
		ID   <input type="text" name="userid" value="${sessionScope.loginUser.userid}" size="3" readonly />
		name <input type="text" name="name" value="${sessionScope.loginUser.name}" size="3" class="short" readonly />&nbsp;&nbsp;
		댓글 : <input type="text" name="content" class="long" size="50" />
		<!-- 댓글에 달리는 원게시물 글번호(tblBoard seq) -->
		<input type="hidden" name="parentIdx" value="${freevo.idx}" />
		
		<!-- 돌아갈 글목록 페이지 -->
		<input type="hidden" name="gobackURL" value="${gobackURL}">
		&nbsp;&nbsp;<button type="button" onClick="goWrite();">댓글작성</button>
	</form>
	
	<br/>
	
	<div style = "border: 1px solid pink;">
		<!-- === #93. 댓글 내용 보여주기. -->
		<c:if test="${not empty freeCommentList}">
			<table id="comment" style="width: 70%; margin-left: 5%;">
				<c:forEach var="commentvo" items="${freeCommentList}" >
					<tr>
						<td style="border: 1px dashed lightgray; border-left: none; border-right: none; width: 5%;">
							<img src="<%= request.getContextPath() %>/resources/images/${commentvo.img}" style="width: 30px; height: 25px;" align="middle">
						</td>
						<td style="border: 1px dashed lightgray; border-left: none; width: 15%;">
							작성자 ${commentvo.userid} [${commentvo.name}]
						</td>
						<td style="border: 1px dashed lightgray; border-left: none; width: 30%; padding-left: 10px;">
							<span style="font-size: 11pt;">${commentvo.content}</span>
						</td>
						<td style="border: 1px dashed lightgray; border-left: none; border-right: none; width: 15%; padding-left: 10px;">
							${commentvo.regDate}
						</td>
					</tr>
				</c:forEach>
			</table>
		</c:if>
	</div>
	
	
	
</div>












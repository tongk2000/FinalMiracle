<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	th, td{
		border:1px solid black;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$(".modalFolder").click(function(){
		 	var frm = {"idx":$(this).attr("id")};
			$.ajax({
				url:"do_getSelectFolderInfo.mr",
				data:frm,
				dataType:"html",
				success:function(data){
					$("#folderInfo").html(data);
					$("#folderInfo").modal();
				}, error:function(request, status, error){
                    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			return;
		}); // end of $(".modalFolder").click(function() ------------------------------------------------------------------------
		
		$(".folder").click(function(){			
			var $this = $(this);
			var idx = $this.attr("id");
			var depth = getDepth($this); // 클릭한 요소의 깊이 구하기
			while(1==1) {
				$this2 = $this.next();
				var depth2 = getDepth($this2); // 다음 요소의 깊이 구하기
				
				if(depth+1 == depth2) { // 클릭한 요소의 깊이보다 다음 요소의 깊이가 1 크다면 (클릭했을때 +1 깊이만 표시되도록 하기 위해서 구분함)
					if($this2.is(":visible")) {
						$this2.hide();
					} else {
						$this2.show();
					}
				} else if (depth+1 < depth2) { // 클릭한 요소의 깊이보다 다음 요소의 깊이가 2 이상이라면
					if($this2.is(":visible")) {
						$this2.hide();
					}
				} else { // 클릭한것과 깊이가 같은 요소가 나오면 break
					break;
				}
				$this = $this2; // 다음의 다음 요소를 찾기 위함
			}
		}); // end of $(".folder").click(function() -----------------------------------------------------------------------------------------------
		
		$("#allClose").click(function(){ // 폴더 전체 닫기
			$(".folder").hide();
			$(".0").show();
		}); // end of $("#allClose").click(function() -------------------------------------------------------------------------------------
		
		$("#allOpen").click(function(){ // 폴더 전체 펴기
			$(".folder").show();
		}); // end of $("#allOpen").click(function() ---------------------------------------------------------------------------------------------
		
		
		$("#body").keydown(function(){
			var modalFlag = $('#folderInfo').is(':visible');
			if(event.keyCode == 27 && modalFlag) {
				$('#folderInfo').modal('hide');
			} 
		}); // end of $("#body").keydown(function() ------------------------------------------------------------------------------------------------------
			
		$(".modalClose").click(function(){
			$('#folderInfo').modal('hide');
		}); // end of $(".modalClose").click(function() ------------------------------------------------------------------------------------------------------
	});
	
	// 그룹번호 구해주는 함수
	function getGroupNo($this) {
		var className = $this.attr("class");
		var index1 = className.indexOf(" ");
		var index2 = className.indexOf(" ", index1+1);
		var groupNo = className.substr(index1+1, index2-index1-1); // 2번째 클래스를 추출함
		return parseInt(groupNo);
	} // end of function getGroupNo($this) -----------------------------------------------------------------------------------------------------------------------
	
	// 깊이 구해주는 함수
	function getDepth($this) {
		var className = $this.attr("class");
		var index1 = className.indexOf(" ");
		var index2 = className.indexOf(" ", index1+1);
		var depth = className.substr(index2);  // 3번째 클래스를 추출함
		return parseInt(depth);
	} // end of function getDepth($this) ------------------------------------------------------------------------------------------------------------------------	
	
	 function goClose(){
         var ynFlag = confirm("창을 종료하시겠습니까?\r\n(종료시 수정하신 정보는 모두 초기화됩니다)");
         if(ynFlag) {
               changeFlag = false;
               window.location.reload(true);
         } else {
               return;
         }
	} // end of function goClose() --------------------------------------------------------------------------------------------------------------------------------
	
</script>

<div class="container" style="width:40%; float:left">
	<div><span id="allClose">전체접기</span>  ||  <span id="allOpen">전체펴기</span></div>
	<table style="width:100%">
		<thead>
			<tr>
				<th style="width:30%">제목</th>
				<th>시작일</th>
				<th>마감일</th>
				<th>중요도</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty doList}"> <!-- 프로젝트 리스트가 비었다면 -->
				<td colspan="4">등록된 프로젝트가 없습니다.</td>
			</c:if>
			<c:if test="${not empty doList}"> <!-- 프로젝트 리스트가 있다면 -->
				<c:forEach var="dvo" items="${doList}">
					<tr id="${dvo.idx}" class="folder ${dvo.groupNo} ${dvo.depth}">
						<td>
							<span style="margin-left:${dvo.depth*15}px; cursor:pointer;">
								<c:if test="${dvo.category == 1}"> <!-- 폴더라면 -->
									<span class="modalFolder" id="${dvo.idx}">
										<c:if test="${dvo.fk_folder_idx == 0}"> <!-- 최상위 폴더라면 -->
											${dvo.subject}
										</c:if>
										<c:if test="${dvo.fk_folder_idx != 0}"> <!-- 최상위 폴더가 아니라면 -->
											└${dvo.subject}
										</c:if>
									</span>
								</c:if>
								<c:if test="${dvo.category == 2}"> <!-- 할일이라면 -->
									<span class="modalTask" id="${dvo.idx}">
										└<input type="checkbox"/>${dvo.subject}
									</span>
								</c:if>
							</span>
						</td>
						<c:if test="${dvo.dayCnt == 0}"> <!-- 시작일 전이라면 -->
							<td style="background-color:lightgreen;">${dvo.startDate}</td>
							<td style="background-color:lightgreen;">${dvo.lastDate}</td>
						</c:if>
						<c:if test="${dvo.dayCnt == 1}"> <!-- 진행중이라면 -->
							<td style="background-color:green;">${dvo.startDate}</td>
							<td style="background-color:green;">${dvo.lastDate}</td>
						</c:if>
						<c:if test="${dvo.dayCnt == -1}"> <!-- 기한이 지났다면 -->
							<td style="background-color:red;">${dvo.startDate}</td>
							<td style="background-color:red;">${dvo.lastDate}</td>
						</c:if>
						<td>${dvo.importance}</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>

<div class="container" style="width:60%; float:right">
</div>

<div class="modal fade" id="folderInfo" role="dialog">
	<jsp:include page="../kdh/modal/modalFolder.jsp"/> <!-- 폴더 보기 Modal -->
</div>























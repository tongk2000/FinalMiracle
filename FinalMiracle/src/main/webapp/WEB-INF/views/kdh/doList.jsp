<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	th, td{
		border:1px solid black;
	}
	
	td.infoClass {
		border-top:ridge;
		border-bottom:ridge;
		border-right:ridge;
		color:black;
		font-weight:bold;
		width:100px;
	}
	
	td.infoData {
		border-top:ridge;
		border-bottom:ridge;
	}
	
	td.showInfo {
		color:green;
		cursor:pointer;
	}
	
	.custom-menu {
	    z-index:1000;
	    position: absolute;
	    background-color:#C0C0C0;
	    border: 1px solid black;
	    padding: 2px;
	}
	
</style>

<script type="text/javascript">
	$(document).ready(function(){
		var changeFlag = false; // 모달창에서 변경된 값이 있는지 체크하는 변수
		
		// 폴더 모달창 띄우기
		$(".modalFolder").click(function(){
		 	var frm = {"idx":$(this).attr("id").replace("modalIdx","")};
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
			return false;
		}); // end of $(".modalFolder").click(function() ------------------------------------------------------------------------
		
		// 할일 모달창 띄우기
		$(".modalTask").click(function(){
		 	var frm = {"idx":$(this).attr("id").replace("subject","")};
			$.ajax({
				url:"do_getSelectTaskInfo.mr",
				data:frm,
				dataType:"html",
				success:function(data){
					$("#taskInfo").html(data);
					$("#taskInfo").modal();
				}, error:function(request, status, error){
                    alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			return false;
		}); // end of $(".modalFolder").click(function() ------------------------------------------------------------------------
				
		// 선택한 폴더 접고 펴기
		$(".folder").click(function(){
			var $this = $(this);
			var idx = $this.attr("id");
			var depth = getDepth($this); // 클릭한 요소의 깊이 구하기
			var groupNo = getGroupNo($this);
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
		
		$(document).bind("mousedown", "keydown", function(){
			$("div.custom-menu").remove();
		});
		
		
		$(".folder").bind("contextmenu", function(event) {
			$("div.custom-menu").remove();
		    event.preventDefault();
		    $("<div class='custom-menu'>Custom menu</div>")
		        .appendTo("body")
		        .css({top: event.pageY + "px", left: event.pageX + "px"});
			}).bind("click", function(event) {
		    $("div.custom-menu").remove();
		});
				
		// 폴더 전체 닫기
		$("#allClose").click(function(){
			$(".folder").hide();
			$(".0").show();
		}); // end of $("#allClose").click(function() -------------------------------------------------------------------------------------
		
		// 폴더 전체 펴기
		$("#allOpen").click(function(){ 
			$(".folder").show();
		}); // end of $("#allOpen").click(function() ---------------------------------------------------------------------------------------------
		
		// 모달창에서 정보를 선택했을때 수정할 수 있는 input 띄워주기
		$(document).on("click", ".showInfo", function(){
			$(this).hide();
			var $hiddenEdit = $(this).parent().find(".hiddenEdit");
			$hiddenEdit.show();
			
			var $hiddenEditInput = $hiddenEdit.find(".hiddenEditInput");
			$hiddenEditInput.focus();
			
			var endFocus = $hiddenEditInput.val();  // 이렇게
			$hiddenEditInput.val("").val(endFocus); // 짝지어주면 글 커서가 제일 마지막으로 감!!
		}); // end of $(document).on("click", ".showInfo", function() ------------------------------------------------------------------------------
		
		// 모달창에서 정보 수정 input 박스를 벗어나면 show 폼으로 변경하기
		$(document).on("blur", ".hiddenEditInput", function(){
			$(this).parent(".hiddenEdit").hide();
			$(this).parent().parent().find(".showInfo").show();
		}); // end of $(document).on("blur", ".hiddenEditInput", function() -------------------------------------------------------------------------
		
		// 모달창에서 정보 수정을 하면 그 값을 바로 show 폼에 적용시키기
		$(document).on("keyup", ".hiddenEditInput", function(){
			changeFlag = true;
			$(this).parent().parent().find(".showInfo").html($(this).val());
			if(event.keyCode == 13) {
				$(".modalEdit").trigger("click");
			}
		}); // end of $(document).on("keyup", ".hiddenEditInput", function() --------------------------------------------------------------------------
		
		// 폴더 모달창의 정보를 수정하기
		$(document).on("click", ".modalEdit", function(){
			var frm = $("form[name=modalInfoFrm]").serialize(); // 폼값을 직렬화해서 한꺼번에 ajax 로 넘길수 있다. 
			$.ajax({
				url:"do_goModalEdit.mr",
				type:"post",
				data:frm,
				dataType:"JSON",
				success:function(data){
					if(data.result == 1) {
						alert("정보수정이 성공했습니다.");
						$("#subject"+data.idx).text(data.subject);
						changeFlag = false;
					} else {
						alert("정보수정이 실패했습니다. 관리자에게 문의하세요.");
					}
				}, error:function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
		}); // end of function goModalEdit() -------------------------------------------------------------------------------------------------------------
		
		// 할일 완료나 미완료 체크하면 DB수정하고 css 변경해주기
		$(document).on("change", ".status", function(){
			var checked = $(this).is(":checked");
			var idx = $(this).attr("id").replace("modalStatus","").replace("status","");
			var status = "";
			
			if(checked) {
				$("#modalStatus").css({"color":"green"}).html("<label for='modalStatus"+idx+"'>완료</label>");
				$("#status"+idx).prop("checked", true);
				status = "0";
			} else {
				$("#modalStatus").css({"color":"red"}).html("<label for='modalStatus"+idx+"'>미완료</label>");
				$("#status"+idx).prop("checked", false);
				status = "1";
			}
			
			var frm = {"idx":idx, "status":status};
			
			$.ajax({
				url:"do_taskComplete.mr",
				data:frm
			});
		}); // end of $(document).on("change", "#status", function() ----------------------------------------------------------------------
		
		// 페이지 전체에서 esc 키를 누르면 모달창을 닫기
		$(document).on("keydown", function(){
			var modalFlag = $('.modal').is(':visible');
			if(event.keyCode == 27 && modalFlag && changeFlag) { // 입력한 키가 esc 이고, 모달창이 보여지고 있는 상태이면서 바꾼 내용이 있을때
				var ynFlag = confirm("창을 종료하시겠습니까?\r\n(종료시 수정하신 정보는 모두 초기화됩니다)");
				if(ynFlag) {
					changeFlag = false;
					$('.modal').modal('hide');
				}
			} else if (event.keyCode == 27 && modalFlag && !changeFlag) { // 위 조건에 바꾼 내용은 없을때
				$('.modal').modal('hide');
			}
		}); // end of $("#body").keyup(function() ------------------------------------------------------------------------------------------------------
		
		// 모달창에서 x 나 취소를 누르면 esc 누른 효과를 주기(위의 이벤트핸들러로 이동함)
		$(document).on("click", ".modalClose", function(){			
			event.keyCode = 27;
			$(document).trigger("keydown"); // trigger : 해당 이벤트로 전달
		}); // end of $(".modalClose").click(function() ------------------------------------------------------------------------------------------------------
				
	}); // end of $(document).ready(function() --------------------------------------------------------------------------------------------------------
	
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
									<span class="modalFolder" id="modalIdx${dvo.idx}">
										<c:if test="${dvo.fk_folder_idx != 0}"> <!-- 최상위 폴더가 아니라면 -->
											└
										</c:if>
										<span id="subject${dvo.idx}">${dvo.subject}</span>
									</span>
								</c:if>
								<c:if test="${dvo.category == 2}"> <!-- 할일이라면 -->
									<c:if test="${dvo.status == 0}"> <!-- 완료된 할일이라면 -->
										└<input type="checkbox" id="status${dvo.idx}" class="status" checked/>
									</c:if>
									<c:if test="${dvo.status == 1}"> <!-- 미완료된 할일이라면 -->
										└<input type="checkbox" id="status${dvo.idx}" class="status"/>
									</c:if>
									<span class="modalTask" id="subject${dvo.idx}">${dvo.subject}</span>
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

<div class="modal fade" id="folderInfo" role="dialog"></div>
<div class="modal fade" id="taskInfo" role="dialog"></div>























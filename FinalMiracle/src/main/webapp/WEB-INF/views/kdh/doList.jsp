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
	
	#folderRcm {
	    z-index:1000;
	    position: absolute;
	    background-color:white;
	    border: 1px solid black;
	    padding: 2px;
	}
	#folderRcm table {
		width:100%;
	}
	
	#taskRcm {
	    z-index:1000;
	    position: absolute;
	    background-color:white;
	    border: 1px solid black;
	    padding: 2px;
	}
	#taskRcm table {
		width:100%;
	}
	
	.selectLine {
		background-color:lightgray;
	}
	.selectedLine {
		background-color:lightgray;
	}
	.completeLine {
		background-color:green;
	}
	.incompleteLine {
		background-color:red;
	}
	.addLine {
		background-color:blue;
	}
	.delElement {
		background-color:red;
	}
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		var changeFlag = false; // 모달창에서 변경된 값이 있는지 체크하는 변수
		$("#folderRcm").hide();
		$("#taskRcm").hide();
		
		
		// 폴더 모달창 띄우기(값만 가지고 함수로 이동하게됨)
		$(".modalFolder").click(function(){
		 	var frm = {"idx":$(this).attr("id").replace("modalIdx","")};
		 	selectFolderInfo(frm);
		 	return false; // 폴더 접고펴기가 실행되지 않도록 설정해둠
		}); // end of $(".modalFolder").click(function() ------------------------------------------------------------------------
		
		// 할일 모달창 띄우기(값만 가지고 함수로 이동하게됨)
		$(".modalTask").click(function(){
		 	var frm = {"idx":$(this).attr("id").replace("subject","")};
		 	selectTaskInfo(frm);
		 	return false;
		}); // end of $(".modalFolder").click(function() ------------------------------------------------------------------------
		
		// 폴더 모달창 띄우기(우클릭 메뉴)
		$("#modalFolderRcm").click(function(){
			var frm = {"idx":$(".selectedLine").attr("id").replace("subject","")};
			selectFolderInfo(frm);
		});
		
		// 할일 모달창 띄우기(우클릭 메뉴)
		$("#modalTaskRcm").click(function(){
			var frm = {"idx":$(".selectedLine").attr("id").replace("subject","")};
			selectTaskInfo(frm);
		});
		
				
		// 선택한 폴더 접고 펴기
		$(".folder").click(function(){
			var $this = $(this);
			var idx = $this.attr("id");
			var depth = parseInt(getThirdClass($this)); // 클릭한 요소의 깊이 구하기
			var groupNo = getSecondClass($this);
			while(1==1) {
				if($this.next().attr("id") == undefined) { // 다음 요소가 없을때 undefined 오류 막기 위함
					break;
				}
				var $this2 = $this.next();
				var depth2 = parseInt(getThirdClass($this2)); // 다음 요소의 깊이 구하기
				
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
		
				
		// 마우스 클릭 이벤트 있으면 일단 우클릭 메뉴 없애주기
		$(document).on("mousedown", function(e){
			if( !($(e.target).hasClass("rcm")) ) { // 클릭 대상이 rcm(우클릭메뉴) 클래스가 아닐 경우
				$("#folderRcm").hide();
				$("#taskRcm").hide();
				$("tr").removeClass("selectedLine");
			}
		}); // end of $(document).mousedown(function() ------------------------------------------------------
		
				
		// 우클릭시 메뉴 보여주기
		$(".folder").bind("contextmenu", function(event) {
		    event.preventDefault();
		    $(this).addClass("selectedLine");
		    var classname = getFirstClass($(this));
		    
		    var subject = $(this).find(".subject").text();
		    $(".rcmSubject").text("["+subject+"] 메뉴");
		    		    
		    if($(this).find(".modalFolder").hasClass("modalFolder")) {
		    	$("#folderRcm").css({top:event.pageY+"px", left:event.pageX+"px"}).show();
		    } else if($(this).find(".modalTask").hasClass("modalTask")) {
		    	$("#taskRcm").css({top:event.pageY+"px", left:event.pageX+"px"}).show();
		    }
		    return false;
		}); // end of $(".folder").bind("contextmenu", function(event) --------------------------------------------------------------------
				
				
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
		
		
		// 할일 완료나 미완료 체크하면 DB수정하고 css 변경해주기(기본+모달창에서 클릭시)
		$(document).on("change", ".status", function(){
			var checked = $(this).is(":checked");
			var idx = $(this).attr("id").replace("modalStatus","").replace("status","");
			var status = "";
			
			if(checked) {
				$("#modalStatus").css({"color":"green"}).html("<label for='modalStatus"+idx+"'>완료</label>");
				$("#status"+idx).prop("checked", true);
				status = "0";
				
				$("#"+idx).addClass("completeLine"); // 깜빡이는 효과
				setTimeout(function(){
					$("#"+idx).removeClass("completeLine");
				},500);
			} else {
				$("#modalStatus").css({"color":"red"}).html("<label for='modalStatus"+idx+"'>미완료</label>");
				$("#status"+idx).prop("checked", false);
				status = "1";
				
				$("#"+idx).addClass("incompleteLine"); // 깜빡이는 효과
				setTimeout(function(){
					$("#"+idx).removeClass("incompleteLine");
				},500);
			}
			
			var frm = {"idx":idx, "status":status};
			
			$.ajax({
				url:"do_taskComplete.mr",
				data:frm
			});
		}); // end of $(document).on("change", "#status", function() ----------------------------------------------------------------------
		
		// 할일 완료나 미완료 체크하면 DB 수정하기(오른쪽클릭 메뉴)
		$(document).on("click", "#statusRcm", function(){
			var $status = $(".selectedLine").find(".status");
			
			var checked = $status.is(":checked");
			var idx = $status.attr("id").replace("status","");
			var status = "";
			
			$("tr").removeClass("selectedLine");
			
			if(checked) { // 이건 체크박스를 직접 입력하는게 아니기 때문에 위하고는 반대로 되어야함
				$status.prop("checked", false);
				status = "1";
				
				$("#"+idx).addClass("incompleteLine");
				setTimeout(function(){ // 깜빡이는 효과
					$("#"+idx).removeClass("incompleteLine");
				},500);
			} else {
				$status.prop("checked", true);
				status = "0";
				
				$("#"+idx).addClass("completeLine");
				setTimeout(function(){ // 깜빡이는 효과
					$("#"+idx).removeClass("completeLine");
				},500);
			}
			
			var frm = {"idx":idx, "status":status};
			
			$.ajax({
				url:"do_taskComplete.mr",
				data:frm
			});
			
			$("#taskRcm").hide();
		}); // end of $(document).on("click", "#statusRcm", function() ------------------------------------------------------------------------------
				
		// 페이지 전체에서 esc 키를 누르면 모달창을 닫기
		$(document).on("keydown", function(){
			var modalFlag = $('.modal').is(':visible');
			
			if(event.keyCode == 27) {
				$("#folderRcm").hide();
				$("#taskRcm").hide();
				$("tr").removeClass("selectedLine");
			}
			
			if(event.keyCode == 27 && modalFlag && changeFlag){ // 입력한 키가 esc 이고, 모달창이 보여지고 있는 상태이면서 바꾼 내용이 있을때
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
		
		
		// 테이블 라인 선택시 백그라운드칼라로 옅은 회색 주기 
		$("tr:has(td)").hover(function(){ // $("tr:has(td)") : tr 태그 중에서 td 태그인것만 선택함. th는 제외함
			$(this).addClass("selectLine");
		}, function(){
			$(this).removeClass("selectLine");
		}); // end of $("tr").hover(function() --------------------------------------------------------------------------------------------
		
		
		// 우클릭 메뉴에서 삭제 누르면 해당 행 삭제해주기
		$(document).on("click", "#deleteRcm", function(){
			var idx = $(".selectedLine").attr("id");
			var bool = confirm("해당 요소를 정말로 삭제하시겠습니까?\n(포함된 하위 요소 또한 모두 삭제됩니다.)");
			if(bool) {
				delElement(idx);
			}
		});
	}); // end of $(document).ready(function() --------------------------------------------------------------------------------------------------------
	
	
	function delElement(idx) {
		var frm = {"idx":idx};
		var bool = false;
		$.ajax({
			url:,
			data:frm,
			dataType:"json",
			success:function(data){
				if(parseInt(data.result) > 0) {
					var bool = true;
				} else {
					alert("알 수 없는 오류로 삭제할 수 없습니다.\n관리자에게 문의하세요.");
				}
			}, error:function(){
				alert("알 수 없는 오류로 삭제할 수 없습니다.\n관리자에게 문의하세요.");
			}
		});
		
		if(bool) {
			var $this = $("#"+idx);
			var depth = parseInt(getThirdClass($this)); // 클릭한 요소의 깊이 구하기
			var groupNo = getSecondClass($this);
			
			$("#"+idx).addClass("delElement");
			while(1==1) {
				if($this.next().attr("id") == undefined) { // 다음 요소가 없을때 undefined 오류 막기 위함
					break;
				}
				var $this2 = $this.next();
				var depth2 = parseInt(getThirdClass($this2)); // 다음 요소의 깊이 구하기
				
				if(depth < depth2) { // 클릭한 요소의 깊이보다 다음 요소의 깊이가 크다면
					$this2.addClass("delElement");
				} else { // 클릭한것과 깊이가 같은 요소가 나오면 break
					break;
				}
				$this = $this2;
			}
			setTimeout(function(){
				$(".delElement").hide(1000);
			},1000);
			setTimeout(function(){
				$(".delElement").remove();
			},2500);
			$("#folderRcm").hide();
			$("#taskRcm").hide();
		}
	}
	
	// 상위 요소 추가(일단 보류;;)
	function addUpFolder() {
		$("#span1").css({"margin-left":"${3*15}px"});
	} // end of function addUpFolder() ---------------------------------------------------------------------------------------------------------------------------------
	
	
	// 하위 요소 추가
	function addDownElement() {
		var upIdx = $(".selectedLine").attr("id");
		window.open("do_addDownElement.mr?upIdx="+upIdx, "subwinpop", "left=100px, top=100px, width=400px, height=350px");
	} // end of function addDownElement() -----------------------------------------------------------------------------------------------------------------------------
	// 하위 요소 추가되었을때 살짝 깜빡여 주기
	function addLine(id) {
		$("#"+id).addClass("addLine");
		setTimeout(function(){
			$("#"+id).removeClass("addLine");
		},1000);
	} // end of function addLine(id) ---------------------------------------------------------------------------------------------------------------------------------
	
	
	// 첫번째 클래스 구해주는 함수
	function getFirstClass($this) {
		var className = $this.attr("class");
		var index = className.indexOf(" ");
		var firstClass = className.substr(0, index); // 첫번째 클래스를 추출함
		return firstClass;
	} // end of function getSecondClass($this) -----------------------------------------------------------------------------------------------------------------------
	
	
	// 두번째 클래스 구해주는 함수
	function getSecondClass($this) {
		var className = $this.attr("class");
		var index1 = className.indexOf(" ");
		var index2 = className.indexOf(" ", index1+1);
		var secondClass = className.substr(index1+1, index2-index1-1); // 두번째 클래스를 추출함
		return secondClass;
	} // end of function getSecondClass($this) -----------------------------------------------------------------------------------------------------------------------
	
	
	// 세번째 클래스 구해주는 함수
	function getThirdClass($this) {
		var className = $this.attr("class");
		var index1 = className.indexOf(" ");
		var index2 = className.indexOf(" ", index1+1);
		var thirdClass = className.substr(index2);  // 세번째 클래스를 추출함
		return thirdClass;
	} // end of function getThirdClass($this) ------------------------------------------------------------------------------------------------------------------------
	
	
	// 폴더 모달창 띄우기
	function selectFolderInfo(frm) {
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
	} // end of function selectTaskInfo(frm) ------------------------------------------------------------------------------------------------
	

	// 할일 모달창 띄우기
	function selectTaskInfo(frm) {
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
	} // function selectTaskInfo(frm) ------------------------------------------------------------------------------------------------
</script>

<div class="container" style="width:40%; float:left">
	<div><span id="allClose">전체접기</span>  ||  <span id="allOpen">전체펴기</span></div>
	<table style="width:100%">
		<thead>
			<tr>
				<th style="width:50%">제목</th>
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
							<span id="span${dvo.idx}" style="margin-left:${dvo.depth*15}px; cursor:pointer;">
								<c:if test="${dvo.category == 1}"> <!-- 폴더라면 -->
									<span class="modalFolder" id="modalIdx${dvo.idx}">
										<c:if test="${dvo.fk_folder_idx != 0}"> <!-- 최상위 폴더가 아니라면 -->
											└
										</c:if>
										<span class="modalFolder subject" id="modalIdx${dvo.idx}">${dvo.subject}</span>
									</span>
								</c:if>
								<c:if test="${dvo.category == 2}"> <!-- 할일이라면 -->
									<c:if test="${dvo.status == 0}"> <!-- 완료된 할일이라면 -->
										└<input type="checkbox" id="status${dvo.idx}" class="status" checked/>
									</c:if>
									<c:if test="${dvo.status == 1}"> <!-- 미완료된 할일이라면 -->
										└<input type="checkbox" id="status${dvo.idx}" class="status"/>
									</c:if>
									<span class="modalTask subject" id="subject${dvo.idx}">${dvo.subject}</span>
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



<div id="folderRcm" style="padding:0px;">
	<table>
		<tr>
			<th class="rcmSubject"></th>
		</tr>
		<tr>
			<td class="rcm" id="addFolderRcm">상위요소추가</td>
		</tr>
		<tr>
			<td class="rcm" id="addFolderRcm" onclick="addDownElement()">하위요소추가</td>
		</tr>
		<tr>
			<td class="rcm" id="modalFolderRcm">조회/수정</td>
		</tr>
		<tr>
			<td class="rcm" id="deleteRcm">삭제</td>
		</tr>
	</table>
</div>


<div id="taskRcm" style="padding:0px;">
	<table>
		<tr>
			<th class="rcmSubject"></th>
		</tr>
		<tr>
			<td class="rcm" id="statusRcm">완료처리</td>
		</tr>
		<tr>
			<td class="rcm" id="modalTaskRcm">조회/수정</td>
		</tr>
		<tr>
			<td class="rcm" id="deleteRcm">삭제</td>
		</tr>
	</table>
</div>


















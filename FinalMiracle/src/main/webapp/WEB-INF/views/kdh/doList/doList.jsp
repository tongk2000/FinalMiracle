<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
	th, td:not(.pageDateLine){
		border:1px solid black;
		word-wrap:break-word; /* 글자 넘치면 자동 줄바꿈 */
	}
	
	th {
		position: sticky;
	    top: -1px;
	    z-index: 10;
	    background-color:lightgray;
    }
	
	.pointer{
		cursor:pointer;
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
		border:none !important;
		background-color:skyblue !important;
	}
	.incompleteLine {
		border:none !important;
		background-color:pink !important;
	}
	.addLine {
		background-color:blue;
	}
	.delElement {
		background-color:red;
	}
	
	.line-in-middle {
	  background: linear-gradient(to right,
	                              transparent 0%,
	                              transparent calc(50% - 0.81px),
	                              blue calc(50% - 0.8px),
	                              blue calc(50% + 0.8px),
	                              transparent calc(50% + 0.81px),
	                              transparent 100%);
	}
</style>

<script type="text/javascript">
	window.onload = function(){
		// show, hide 값 유지하기 시작 ---------------------------
		$element = $(".element:first");
		<c:forEach var="dvo" items="${map.doList}">
			if("${dvo.visible}" == "false") { // hide 였던 요소라면
				$element.hide(); // 해당 요소를 hide 하고
				var fk_idx = $element.find(".fk_folder_idx").val(); // 해당 요소가 어떤 상위요소를 참조했는지 확인해서
				$("#"+fk_idx).find(".foldingIcon").text("▶"); // 그 상위요소의 아이콘을 바꿔준다.
			}
			$element = $element.next();
		</c:forEach>
		// show, hide 값 유지하기 끝 -----------------------------
		
		document.getElementById("page").value = "${page}"; // 페이징 값 유지하기
		todayLine(); // 오늘 날짜에는 가운데 선 그어주는 함수
	} // end of window.onload = function() ----------------------------------------------------------------------------
	
	$(document).ready(function(){
		var changeFlag = false; // 모달창에서 변경된 값이 있는지 체크하는 변수
		$("#folderRcm").hide();
		$("#taskRcm").hide();
		
		// 폴더 모달창 띄우기(값만 가지고 함수로 이동하게됨)
		$(".modalFolder").click(function(){
			var frm = {"idx":$(this).parents(".element").attr("id")};
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
		$(document).on("click", ".element", function(){
			var $this = $(this);
			var idx = $this.attr("id");
			var depth = parseInt(getThirdClass($this)); // 클릭한 요소의 깊이 구하기
			var groupNo = getSecondClass($this);
			var foldingFlag = 0;
			while(1==1) {
				if($this.next().attr("id") == undefined) { // 다음 요소가 없을때 undefined 오류 막기 위함
					break;
				}
				var $this2 = $this.next();
				var depth2 = parseInt(getThirdClass($this2)); // 다음 요소의 깊이 구하기
				
				if(depth+1 == depth2) { // 클릭한 요소의 깊이보다 다음 요소의 깊이가 1 크다면 (클릭했을때 +1 깊이만 표시되도록 하기 위해서 구분함)
					if($this2.is(":visible")) { // 깊이가 1 크면서 show 중이라면
						$this2.hide();
						foldingFlag = 1;
					} else {  // 깊이가 1 크면서 hide 중이라면
						$this2.show();
						var downCnt = $this2.find(".downCnt").val(); // show 되는 요소가 하위요소를 가지고 있는지 확인
						if(downCnt > 0) { // 하위요소가 있다면
							$this2.find(".foldingIcon").text("▶");
						}
						foldingFlag = 2;
					}
				} else if (depth+1 < depth2) { // 클릭한 요소의 깊이보다 다음 요소의 깊이가 2 이상이라면
					if($this2.is(":visible")) { // 깊이가 2 이상 크면서 show 중이라면(한마디로 2 이상 큰건 다 hide)
						$this2.hide();
						$(this).find(".foldingIcon").text("▶");
					}
				} else { // 클릭한것과 깊이가 같은 요소가 나오면 break
					break;
				}
				$this = $this2; // 다음의 다음 요소를 찾기 위함
			}
			
			if(foldingFlag == 1) { // 하위 요소가 hide 되었다면.
				$(this).find(".foldingIcon").text("▶");
			} else if(foldingFlag == 2) { // 하위 요소가 show 되었다면.
				$(this).find(".foldingIcon").text("▼");
			}
			
		}); // end of $(".element").click(function() -----------------------------------------------------------------------------------------------
		
				
		// 마우스 클릭 이벤트 있으면 일단 우클릭 메뉴 없애주기
		$(document).on("mousedown", function(e){
			if( !($(e.target).hasClass("rcm")) ) { // 클릭 대상이 rcm(우클릭메뉴) 클래스가 아닐 경우
				$("#folderRcm").hide();
				$("#taskRcm").hide();
				$("tr").removeClass("selectedLine");
			}
		}); // end of $(document).mousedown(function() ------------------------------------------------------
		
				
		// 우클릭시 메뉴 보여주기
		$(document).on("contextmenu", ".element", function(event) {
		    event.preventDefault();
		    $(this).addClass("selectedLine");
		    var classname = getFirstClass($(this));
		    
		    var subject = $(this).find(".subject").text();
		    $(".rcmSubject").text("["+subject+"] 메뉴");
		    		    
		    if($(this).find(".modalFolder").hasClass("modalFolder")) { // 폴더 우클릭이라면
		    	$("#folderRcm").css({top:event.pageY+"px", left:event.pageX+"px"}).show();
		    } else if($(this).find(".modalTask").hasClass("modalTask")) { // 할일 우클릭이라면
		    	var bool = $(this).find(".status").is(":checked");
		    	if(bool) {
		    		$("#statusRcm").text("미완료처리");
		    	} else {
		    		$("#statusRcm").text("완료처리");
		    	}
		    	$("#taskRcm").css({top:event.pageY+"px", left:event.pageX+"px"}).show();
		    }
		    return false;
		}); // end of $(".element").bind("contextmenu", function(event) --------------------------------------------------------------------
				
				
		// 폴더 전체 닫기
		$("#allClose").click(function(){
			$(".element").hide();
			$(".0").show();
		}); // end of $("#allClose").click(function() -------------------------------------------------------------------------------------
		
				
		// 폴더 전체 펴기
		$("#allOpen").click(function(){ 
			$(".element").show();
		}); // end of $("#allOpen").click(function() ---------------------------------------------------------------------------------------------
		
				
		// 모달창에서 정보를 선택했을때 수정할 수 있는 input 띄워주기
		$(document).on("click", ".showInfo", function(){
			$(this).parent().addClass("selectedLine");
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
			$(this).parent().removeClass("selectedLine");
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
				
				$("#"+idx).find(".dateColor").css({"background-color":"gray"});
				
				status = "0";
				
				$("#"+idx).find("*").addClass("completeLine"); // 깜빡이는 효과
				setTimeout(function(){
					$("#"+idx).find("*").removeClass("completeLine");
				},500);
			} else {
				$("#modalStatus").css({"color":"red"}).html("<label for='modalStatus"+idx+"'>미완료</label>");
				$("#status"+idx).prop("checked", false);
				
				setDayColor(idx);
				
				status = "1";
				
				$("#"+idx).find("*").addClass("incompleteLine"); // 깜빡이는 효과
				setTimeout(function(){
					$("#"+idx).find("*").removeClass("incompleteLine");
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
				
				setDayColor(idx);
				
				$("#"+idx).find("*").addClass("incompleteLine");
				setTimeout(function(){ // 깜빡이는 효과
					$("#"+idx).find("*").removeClass("incompleteLine");
				},500);
			} else {
				$status.prop("checked", true);
				status = "0";
				
				$("#"+idx).find(".dateColor").css({"background-color":"gray"});
				
				$("#"+idx).find("*").addClass("completeLine");
				setTimeout(function(){ // 깜빡이는 효과
					$("#"+idx).find("*").removeClass("completeLine");
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
		
		
		// 테이블 라인 선택시 백그라운드칼라로 옅은 회색 주기 (새로 추가한 요소도 잡기 위해 어쩔 수 없이 document 로 처리함..)
		$(document).on("mouseover", "tr:has(td)", function(){ // $("tr:has(td)") : tr 태그 중에서 td 태그인것만 선택함. th는 제외함
			$(this).addClass("selectLine");
		}); // end of $(document).on("mouseover", "tr:has(td)", function() ------------------------------------------------------------------
		$(document).on("mouseout", "tr:has(td)", function(){
			$(this).removeClass("selectLine");
		}); // end of $(document).on("mouseout", "tr:has(td)", function() ------------------------------------------------------------------
		
		
		// 우클릭 메뉴에서 삭제 누르면 사용자한테 물어본 후 해당 행 삭제하는 함수 호출하기
		$(document).on("click", "#deleteRcm", function(){
			var idx = $(".selectedLine").attr("id");
			var fk_folder_idx = $("#newFk_idx"+idx).val();
			if(fk_folder_idx == undefined) {
				fk_folder_idx = $(".selectedLine").find(".fk_folder_idx").val(); 
			}
			var bool = confirm("해당 요소를 정말로 삭제하시겠습니까?\n(포함된 하위 요소 또한 모두 삭제됩니다.)");
			if(bool) {
				delElement(idx, fk_folder_idx);
			}
		}); // $(document).on("click", "#deleteRcm", function() ------------------------------------------------------------------------------------------
		
	}); // end of $(document).ready(function() ---------------------------------------------------------------------------------------------------------
			
	
	// 선택한 요소를 삭제해주는 함수
	function delElement(idx, fk_folder_idx) {
		var frm = {"idx":idx, "fk_folder_idx":fk_folder_idx};
		$.ajax({
			url:"do_delElement.mr",
			data:frm,
			dataType:"json",
			success:function(data){
				if(parseInt(data.result) > 0) { // DB에서 삭제update에 성공했다면 페이지상에서도 지워준다.
					var $this = $("#"+idx);
					var depth = parseInt(getThirdClass($this)); // 클릭한 요소의 깊이 구하기
					var groupNo = getSecondClass($this);
					
					$("#"+idx).addClass("delElement");
					while(1==1) { // 선택한 요소와 그 하위요소를 모두 삭제하기 위해 반복문 돌림
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
					
					$("#"+fk_folder_idx).find(".fk_folder_idx").val(data.downCnt); // 상위요소의 하위요소숫자를 갱신하고
					if(data.downCnt == 0) { // 하위요소가 0개라면
						$("#"+fk_folder_idx).find(".foldingIcon").text("▷"); // 아이콘을 변경해줌
					}
				} else {
					alert("알 수 없는 오류로 삭제할 수 없습니다.\n관리자에게 문의하세요.");
				}
			}, error:function(){
				alert("알 수 없는 오류로 삭제할 수 없습니다.\n관리자에게 문의하세요.");
			}
		});
	} // end of function delElement(idx) ---------------------------------------------------------------------------------------------------------------------------------
	
	
	// 상위 요소 추가(일단 보류;;)
	function addUpFolder() {
		$("#span1").css({"margin-left":"${3*15}px"});
	} // end of function addUpFolder() ---------------------------------------------------------------------------------------------------------------------------------
	
	
	// 하위 요소 추가
	function addDownElement() {
		var upIdx = $(".selectedLine").attr("id");
		var term = $("#term").val();
		var page = $("#page").val();
		
		window.open("do_addDownElement.mr?upIdx="+upIdx+"&term="+term+"&page="+page, "subwinpop", "left=100px, top=100px, width=400px, height=350px");
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
				$("#modalElementInfo").html(data);
				$("#modalElementInfo").modal();
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
				$("#modalElementInfo").html(data);
				$("#modalElementInfo").modal();
			}, error:function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	} // function selectTaskInfo(frm) ------------------------------------------------------------------------------------------------
	
	// 하루전으로 페이징 처리하기 위해 페이지 값을 가져오기
	function beforeDate() {
		var val = document.getElementById("page").value;
		document.getElementById("page").value = parseInt(val) - 1;
		changePageDate();
	} // end of function beforeDate() --------------------------------------------------------------------------------------------------
	
	// 이전 기간으로 페이징 처리하기 위해 페이지 값을 가져오기
	function beforeTerm() {
		var val = document.getElementById("page").value;
		var term = document.getElementById("term").value;
		document.getElementById("page").value = parseInt(val) - parseInt(term);
		changePageDate();
	} // end of function beforeDate() --------------------------------------------------------------------------------------------------
	
	// 하루뒤로 페이징 처리하기 위해 페이지 값을 가져오기
	function afterDate() {
		var val = document.getElementById("page").value;
		document.getElementById("page").value = parseInt(val) + 1;
		changePageDate();
	} // end of function afterDate() --------------------------------------------------------------------------------------------------
	
	// 이후 기간으로 페이징 처리하기 위해 페이지 값을 가져오기
	function afterTerm() {
		var val = document.getElementById("page").value;
		var term = document.getElementById("term").value;
		document.getElementById("page").value = parseInt(val) + parseInt(term);
		changePageDate();
	} // end of function afterDate() --------------------------------------------------------------------------------------------------
	
	// 오늘 날짜로 돌아가는 함수
	function callToday() {
		document.getElementById("page").value = 0;
		changePageDate();
	} // end of function callToday() -----------------------------------------------------------------------------------------------------
	
	// 수정된 페이지 값을 이용해서 새롭게 페이징 처리하기
	function changePageDate() {
		var visibleArr = [];
		var cnt = 0;
		$(".element").each(function(){
			var bool = $(this).is(":visible");
			visibleArr[cnt] = bool;
		    cnt++;
		});
		document.getElementById("visibleArr").value = visibleArr;
		document.pageDateFrm.submit();
	} // end of function changePageDate() -------------------------------------------------------------------------------------------------
	
	
	// 오늘 날짜에는 가운데 선 그어주기
	function todayLine() {
		<jsp:useBean id="today" class="java.util.Date"/>
		<fmt:formatDate value="${today}" var="now" pattern="yyyyMMdd"/> // 오늘 날짜를 구해서
		var now = ${now};
		$("."+now).addClass("line-in-middle"); // 클래스가 오늘 날짜인건 전부 가운데 줄 그어주는 css 추가
	} // end of function todayLine() --------------------------------------------------------------------------------------------------------------
	
	
	// 완료/미완료 처리시 기간에 대한 색상을 바꿔주는 함수 
	function setDayColor(idx) {
		var $dateColor = $("#"+idx).find(".dateColor");
		var dayCnt = getThirdClass($dateColor);
		if(dayCnt == -1) {
			$dateColor.css({"background-color":"red"});
		} else if (dayCnt == 0) {
			$dateColor.css({"background-color":"lightgreen"});
		} else if (dayCnt == 1) {
			$dateColor.css({"background-color":"green"});
		}
	} // end of function setDayColor(idx) ---------------------------------------------------------------------------------------------------------------
	
	
	// 요소에 댓글 추가하고 새로운 댓글 리스트 받아오기(xml)
	function addComment() {
		var frm = $("form[name=addCommentFrm]").serialize();
		$.ajax({
			url:"do_addComment.mr",
			type:"post",
			data:frm,
			dataType:"xml",
			success:function(data){
				alert("댓글 입력에 성공했습니다.");
				/* var commentArr = $(data).find(":root").find("comment");
				var html = "";
				commentArr.each(function(){
					html += "<tr>";
					html += "	<td>"+$(this).find("userid").text()+"<td>";
					html += "	<td>"+$(this).find("content").text()+"<td>";
					html += "	<td>"+$(this).find("writeDay").text()+"<td>";
					html += "	<td>x<td>";
					html += "</tr>";
				});
				modalCommentList.html(html); */
			}, error:function(request, status, error){
				/* alert(request.status + " 에러!!\n관리자에게 문의하세요."); */
				alert("code: " + request.status + "\n"+"message: " + request.responseText + "\n" + "error: " + error);
			}
		});		
	} // end of function addComment() ----------------------------------------------------------------------------------------------------------------------
</script>

<div class="container" style="width:100%; float:left">
	<table style="width:100%; border:1px solid black;">
		<thead>
			<tr>
				<th colspan="4">
					<span id="allClose" style="margin-left:20px;">전체접기</span>  ||  <span id="allOpen">전체펴기</span>
				</th>
				<th></th>
				<th></th>
				<th colspan="${map.pageDateList.size()}" style="text-align:center;">2017</th>
			</tr>
			<tr>
				<th colspan="4">
					<div style="margin-left:20px; border-left:10px solid lightgreen; height:10px; display:inline;"></div>진행전
					<div style="margin-left:10px; border-left:10px solid green; height:10px; display:inline;"></div>진행중
					<div style="margin-left:10px; border-left:10px solid red; height:10px; display:inline;"></div>기한경과
					<div style="margin-left:10px; border-left:10px solid gray; height:10px; display:inline;"></div>완료
				</th>
				<th></th>
				<th></th>
				<th colspan="${map.pageDateList.size()}" style="text-align:center;">
					<form name="pageDateFrm" method="get" action="do_changePageDate.mr">
						<span class="pointer" onclick="beforeTerm()">◀</span>
						<span class="pointer" onclick="beforeDate()">◁</span>
						<select id="term" name="term" onchange="changePageDate()">
							<option value="7">주간</option>
							<option value="30" 
								<c:if test="${term == 30}">selected</c:if>
							>월간</option>
						</select>
						<span class="pointer" onclick="afterDate()">▷</span>
						<span class="pointer" onclick="afterTerm()">▶</span>
						<input type="hidden" id="page" name="page" value="0"/>
						<input type="hidden" id="visibleArr" name="visibleArr">
					</form>
				</th>
			</tr>
			<tr>
				<th style="width:50%">제목</th>
				<th>시작일</th>
				<th>마감일</th>
				<th>중요도</th>
				<th></th>
				<th></th>
				<c:forEach var="pageDate" items="${map.pageDateList}">
					<th class="pointer" ondblClick="callToday()" style="
						<c:if test="${pageDate.dotw == '토' || pageDate.dotw == '일'}">
							background-color:#ffcccc;
						</c:if>
						<c:if test="${fn:substring(pageDate.day, 6, 8) == '01'}">
							border-left:2px solid #ff66ff;
						</c:if>
					">${pageDate.dayDP}</th> 
				</c:forEach>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty map.doList}"> <!-- 프로젝트 리스트가 비었다면 -->
				<td colspan="4">등록된 프로젝트가 없습니다.</td>
			</c:if>
			<c:if test="${not empty map.doList}"> <!-- 프로젝트 리스트가 있다면 -->
				<c:forEach var="dvo" items="${map.doList}">
					<tr id="${dvo.idx}" class="element ${dvo.groupNo} ${dvo.depth}">
						<td>
							<input type="hidden" class="fk_folder_idx" value="${dvo.fk_folder_idx}" />
							<input type="hidden" class="downCnt" value="${dvo.downCnt}" />
							<span id="span${dvo.idx}" style="margin-left:${dvo.depth*20}px;">
								<c:if test="${dvo.category == 1}"> <!-- 폴더라면 -->
									<span class="foldingIcon" style="cursor:default;">
										<c:if test="${dvo.downCnt > 0}"> <!-- 하위요소가 있다면 -->
											▼
										</c:if>
										<c:if test="${dvo.downCnt == 0}"> <!-- 하위요소가 없다면 -->
											▷
										</c:if>
									</span>
									<span class="modalFolder subject pointer">${dvo.subject}</span>
								</c:if>
								<c:if test="${dvo.category == 2}"> <!-- 할일이라면 -->
									<c:if test="${dvo.status == 0}"> <!-- 완료된 할일이라면 -->
										└<input type="checkbox" id="status${dvo.idx}" class="status" checked/>
									</c:if>
									<c:if test="${dvo.status == 1}"> <!-- 미완료된 할일이라면 -->
										└<input type="checkbox" id="status${dvo.idx}" class="status"/>
									</c:if>
									<span class="modalTask subject pointer" id="subject${dvo.idx}">${dvo.subject}</span>
								</c:if>
							</span>
						</td>
						
						<c:if test="${dvo.status == 1}"> <!-- 미완료된 할일이라면 -->
							<c:if test="${dvo.dayCnt == 0}"> <!-- 시작일 전이라면 -->
								<td class="dateColor ${dvo.dayCnt}" style="background-color:lightgreen;">${dvo.startDate}</td>
								<td class="dateColor ${dvo.dayCnt}" style="background-color:lightgreen;">${dvo.lastDate}</td>
							</c:if>
							<c:if test="${dvo.dayCnt == 1}"> <!-- 진행중이라면 -->
								<td class="dateColor ${dvo.dayCnt}" style="background-color:green;">${dvo.startDate}</td>
								<td class="dateColor ${dvo.dayCnt}" style="background-color:green;">${dvo.lastDate}</td>
							</c:if>
							<c:if test="${dvo.dayCnt == -1}"> <!-- 기한이 지났다면 -->
								<td class="dateColor ${dvo.dayCnt}" style="background-color:red;">${dvo.startDate}</td>
								<td class="dateColor ${dvo.dayCnt}" style="background-color:red;">${dvo.lastDate}</td>
							</c:if>
						</c:if>
						<c:if test="${dvo.status == 0}"> <!-- 완료된 할일이라면 -->
							<td class="dateColor ${dvo.dayCnt}" style="background-color:gray;">${dvo.startDate}</td>
							<td class="dateColor ${dvo.dayCnt}" style="background-color:gray;">${dvo.lastDate}</td>
						</c:if>
						<td>${dvo.importance}</td>
						
						<td></td>
						<td></td>
						
						<c:forEach var="pageDate" items="${map.pageDateList}">
							<fmt:parseNumber var="startDate" value="${dvo.startDate.replace('-','')}" integerOnly="true"/>
							<fmt:parseNumber var="lastDate" value="${dvo.lastDate.replace('-','')}" integerOnly="true"/>
							<fmt:parseNumber var="day" value="${pageDate.day}" integerOnly="true"/> <!-- 희안하게 위에껀 못쓰고 여기서 다시 해줘야함; -->
							
							<td class="pageDateLine ${day}" style="border-right:0.5px solid lightgray;
								<c:if test="${pageDate.dotw == '토' || pageDate.dotw == '일'}">
									background-color:#ffcccc;
								</c:if>
								<c:if test="${fn:substring(pageDate.day, 6, 8) == '01'}">
									border-left:2px solid #ff66ff;
								</c:if>
							" align="center">
								
								<c:if test="${startDate <= day and day <= lastDate}"> <!-- 시작일 이후, 마감일 이전 이라면 -->
									<c:if test="${dvo.status == 1}"> <!-- 미완료된 할일이라면 -->
										<c:if test="${dvo.dayCnt == 0}"> <!-- 시작일 전이라면 -->
											<div class="dateColor ${day} ${dvo.dayCnt}" style="height:19px; width:100%; background-color:lightgreen;"></div>
										</c:if>
										<c:if test="${dvo.dayCnt == 1}"> <!-- 진행중이라면 -->
											<div class="dateColor ${day} ${dvo.dayCnt}" style="height:19px; width:100%; background-color:green;"></div>
										</c:if>
										<c:if test="${dvo.dayCnt == -1}"> <!-- 기한이 지났다면 -->
											<div class="dateColor ${day} ${dvo.dayCnt}" style="height:19px; width:100%; background-color:red;"></div>
										</c:if>
									</c:if>
									<c:if test="${dvo.status == 0}"> <!-- 완료된 할일이라면 -->
										<div class="dateColor ${day} ${dvo.dayCnt}" style="height:19px; width:100%; background-color:gray;"></div>
									</c:if>
								</c:if>
							</td>
						</c:forEach>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>

<div class="modal fade" id="modalElementInfo" role="dialog"></div>

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














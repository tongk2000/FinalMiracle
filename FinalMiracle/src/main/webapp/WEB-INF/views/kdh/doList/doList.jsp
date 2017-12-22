<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
	th, td:not(.pageDateLine){
		border:1px solid #cce6ff;
		word-wrap:break-word; /* 글자 넘치면 자동 줄바꿈 */
	}
	th {
		font-weight:normal;
		position: sticky;
	    top: -1px;
	    z-index: 10;
	    background-color:#4882ab;
    }
    
    .rcm {
    	color:white;
    }
    .rcmSubject {
    	background-color:#1f5c87;
    	color:white;
    }
	
	.pointer{
		cursor:pointer;
	}
	.pointerOver{
		color:#3366cc;
	}
	
	td.infoClass {
		border-top:ridge;
		border-bottom:ridge;
		border-right:ridge;
		color:black;
		font-weight:bold;
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
		background-color:#E8E8E8 !important;
	}
	.selectedLine {
		background-color:#E8E8E8 !important;
	}
	.moveLine {
		background-color:#E8E8E8;
	}
	.moveToLine {
		background-color:#ffffcc;
		cursor:pointer;
	}
	.copyToLine {
		background-color:lightblue;
		cursor:pointer;
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
		background-color:blue !important;
	}
	.delElement {
		background-color:red !important;
	}
	
	.line-in-middle {
	  background: linear-gradient(to right,
	                              transparent 0%,
	                              transparent calc(50% - 0.81px),
	                              #4882ab calc(50% - 0.8px),
	                              #4882ab calc(50% + 0.8px),
	                              transparent calc(50% + 0.81px),
	                              transparent 100%);
	}
	
	.myElement {
		background-color:#ffffcc;
	}
	.teamwonElement {
		background-color:#ffccff;
	}
	.searchElement {
		background-color:hsl(180, 100%, 90%);
	}
	
	.myAndTeamwonElement {
		background: linear-gradient(45deg,
								    hsl(60, 100%, 95%) 25%
								  , hsl(300, 100%, 95%) 0, hsl(300, 100%, 95%) 50%
								  ,	hsl(60, 100%, 95%) 0, hsl(60, 100%, 95%) 75%
								  , hsl(300, 100%, 95%) 0);
	    -webkit-background-size:30px 30px;
	    background-size:30px 30px;
	}
	.myAndSearchElement {
		background: linear-gradient(45deg,
								    hsl(60, 100%, 95%) 25%
								  , hsl(180, 100%, 95%) 0, hsl(180, 100%, 95%) 50%
								  , hsl(60, 100%, 95%) 0, hsl(60, 100%, 95%) 75%
								  , hsl(180, 100%, 95%) 0);
	    -webkit-background-size:30px 30px;
	    background-size:30px 30px;
	}
	.teamwonAndSearchElement {
		background: linear-gradient(45deg,
								    hsl(300, 100%, 95%) 25%
								  , hsl(180, 100%, 95%) 0, hsl(180, 100%, 95%) 50%
								  , hsl(300, 100%, 95%) 0, hsl(300, 100%, 95%) 75%
								  , hsl(180, 100%, 95%) 0);
	    -webkit-background-size:30px 30px;
	    background-size:30px 30px;
	}
	.myAndTeamwonAndSearchElement {
		background: linear-gradient(90deg,
								    hsl(60, 100%, 95%) 33%
								  , hsl(300, 100%, 98%) 0, hsl(300, 100%, 98%) 66%
								  , hsl(180, 100%, 95%) 0);
	    -webkit-background-size:50px 50px;
	    background-size:50px 50px;
	}
	
	.seperatorLine {
		border-right:3px solid #cce6ff;
	}
	
	#teamwonList{
		float:left;
		z-index:1000;
		position: absolute;
		background-color:white;
		border:1px solid black;
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
		changeFlag = false; // 모달창에서 변경된 값이 있는지 체크하는 전역 변수
		
		$("#folderRcm").hide();
		$("#taskRcm").hide();
				
		// 폴더 모달창 띄우기(값만 가지고 함수로 이동하게됨)
		$(document).on("click", ".modalFolder", function(){
			var idx = $(this).parents(".element").attr("id").replace("subject","");
		 	selectFolderInfo(idx);
		 	return false; // 폴더 접고펴기가 실행되지 않도록 설정해둠
		}); // end of $(".modalFolder").click(function() ------------------------------------------------------------------------
		
		// 할일 모달창 띄우기(값만 가지고 함수로 이동하게됨)
		$(document).on("click", ".modalTask", function(){
		 	var idx = $(this).parents(".element").attr("id").replace("subject","");
		 	selectTaskInfo(idx);
		 	return false;
		}); // end of $(".modalFolder").click(function() ------------------------------------------------------------------------
		
		// 폴더 모달창 띄우기(우클릭 메뉴)
		$(document).on("click", "#modalFolderRcm", function(){
			var idx = $(".selectedLine").attr("id").replace("subject","");
			selectFolderInfo(idx);
		});
		
		// 할일 모달창 띄우기(우클릭 메뉴)
		$(document).on("click", "#modalTaskRcm", function(){
			var idx = $(".selectedLine").attr("id").replace("subject","");
			selectTaskInfo(idx);
		});
		
		// 요소를 선택했을때 접고 펴기(혹은 이동중일때는 이동 함수로 값 보내주기)
		$(document).on("click", ".element", function(){
			var $this = $(this);
			var depth = parseInt(getThirdClass($this)); // 클릭한 요소의 깊이 구하기
			var groupNo = getSecondClass($this);
			
			if( $(this).hasClass("moveToLine") ){ // 이동중일때는 이동 함수로 값 보내주고 끝냄
				var fk_folder_idx = $(this).attr("id").replace("subject","");
				var subject = $(this).find(".subject").text();
				elementMoveEnd(fk_folder_idx, depth, groupNo, subject);
				return false;
			}
			
			var foldingFlag = 0;
			while(1==1) {
				if($this.next().attr("id") == undefined) { // 다음 요소가 없을때 undefined 오류 막기 위함
					break;
				}
				var $this2 = $this.next();
				var depth2 = parseInt(getThirdClass($this2)); // 다음 요소의 깊이 구하기
				var foldinged = $this2.hasClass("foldinged"); // 다음 요소의 접고 펴짐 상태 저장
				if(depth+1 == depth2) { // 클릭한 요소의 깊이보다 다음 요소의 깊이가 1 크다면 (펼때 +1 깊이만 펴지도록 하기 위해서 구분함)
					if(!foldinged) { // 깊이가 1 크면서 펴짐 상태라면
						$this2.hide().addClass("foldinged");
						foldingFlag = 1;
					} else {  // 깊이가 1 크면서 접힘 상태라면
						var bool = $this2.hasClass("hided");
						if(!bool) { // 완료된 업무 숨기기로 숨겨진게 아니라면
							$this2.show();
							var downCnt = $this2.find(".downCnt").val(); // show 되는 요소가 하위요소를 가지고 있는지 확인
							if(downCnt > 0) { // 하위요소가 있다면
								$this2.find(".foldingIcon").text("▶");
							}
							foldingFlag = 2;
						}
						$this2.removeClass("foldinged"); // 보여주든 말든 일단 펴진 상태로 만듬
					}
				} else if (depth+1 < depth2) { // 클릭한 요소의 깊이보다 다음 요소의 깊이가 2 이상이라면
					if(!foldinged) { // 깊이가 2 이상 크면서 펴짐 상태라면(한마디로 2 이상 큰건 다 접음)
						$this2.hide().addClass("foldinged");
						$(this).find(".foldingIcon").text("▶");
					}
				} else { // 클릭한것과 깊이가 같은 요소가 나오면 break
					break;
				}
				$this = $this2; // 순차적으로 다음 요소를 찾기 위함
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
		// 스크롤 이벤트 있으면 일단 우클릭 메뉴 없애주기
		$("#projectDiv").scroll(function(){
			$("#folderRcm").hide();
			$("#taskRcm").hide();
			$("tr").removeClass("selectedLine");
		}); // end of $(document).mousedown(function() ------------------------------------------------------
				
		// 우클릭시 메뉴 보여주기
		$(document).on("contextmenu", ".element", function(event) {
		    event.preventDefault();
		    $(this).addClass("selectedLine");
		    
		    var subject = $(this).find(".subject").text();
		    $(".rcmSubject").html("&nbsp;&nbsp;["+subject+"] 메뉴(닫기:esc)&nbsp;&nbsp;");
		    		    
		    if($(this).find(".modalFolder").hasClass("modalFolder")) { // 폴더 우클릭이라면
		    	$("#downElementFoldingRcm").show();
		    	
		    	var foldingIcon = $(this).find(".foldingIcon").text();
		    	if(foldingIcon.trim() == "▶") {
		    		$("#downElementFoldingRcm").html("&nbsp;&nbsp;하위요소 전체 펴기&nbsp;&nbsp;");
		    	} else if(foldingIcon.trim() == "▼") {
		    		$("#downElementFoldingRcm").html("&nbsp;&nbsp;하위요소 전체 접기&nbsp;&nbsp;");
		    	} else if(foldingIcon.trim() == "▷") {
		    		$("#downElementFoldingRcm").hide();
		    	}
		    	
		    	var folderComplete = $(this).find(".statusValue").val();
		    	if(folderComplete == "0") {
		    		$("#folderStatusRcm").removeClass("folderCompleteRcm").addClass("folderIncompleteRcm").html("&nbsp;&nbsp;폴더 미완료 처리&nbsp;&nbsp;");
		    	} else {
		    		$("#folderStatusRcm").removeClass("folderIncompleteRcm").addClass("folderCompleteRcm").html("&nbsp;&nbsp;폴더 완료 처리&nbsp;&nbsp;");
		    	}
		    	
		    	var winH = window.innerHeight; // 화면에 보이는, 브라우저를 제외한 뷰단의 전체 height
		    	var winW = window.innerWidth; // 화면에 보이는, 브라우저를 제외한 뷰단의 전체 width
		    	var rcmH = $("#folderRcm").height(); // 우클릭메뉴의 height
		    	var rcmW = $("#folderRcm").width(); // 우클릭메뉴의 width
		    	var clickY = event.pageY; // 클릭 지점 Y
		    	var clickX = event.pageX; // 클릭 지점 X
		    	var top = clickY; // css 에 적용할 y 지점
		    	var left = clickX; // css 에 적용할 x 지점
		    	
		    	if( (rcmH+clickY) > winH ) {
		    		top = clickY - rcmH;
		    	}
		    	if( (rcmW+clickX) > winW ) {
		    		left = clickX - rcmW;
		    	}
		    	$("#folderRcm").css({"top":top+"px", "left":left+"px"}).show();
		    } else if($(this).find(".modalTask").hasClass("modalTask")) { // 할일 우클릭이라면
		    	var bool = $(this).find(".status").is(":checked");
		    	if(bool) {
		    		$("#statusRcm").html("&nbsp;&nbsp;할일 미완료 처리&nbsp;&nbsp;");
		    	} else {
		    		$("#statusRcm").html("&nbsp;&nbsp;할일 완료 처리&nbsp;&nbsp;");
		    	}
		    	
		    	var winH = window.innerHeight; // 화면에 보이는, 브라우저를 제외한 뷰단의 전체 height
		    	var winW = window.innerWidth; // 화면에 보이는, 브라우저를 제외한 뷰단의 전체 width
		    	var rcmH = $("#taskRcm").height(); // 우클릭메뉴의 height
		    	var rcmW = $("#taskRcm").width(); // 우클릭메뉴의 width
		    	var clickY = event.pageY; // 클릭 지점 Y
		    	var clickX = event.pageX; // 클릭 지점 X
		    	var top = clickY; // css 에 적용할 y 지점
		    	var left = clickX; // css 에 적용할 x 지점
		    	
		    	if( (rcmH+clickY) > winH ) {
		    		top = clickY - rcmH;
		    	}
		    	if( (rcmW+clickX) > winW ) {
		    		left = clickX - rcmW;
		    	}
		    	$("#taskRcm").css({"top":top+"px", "left":left+"px"}).show();
		    }
		    return false;
		}); // end of $(".element").bind("contextmenu", function(event) --------------------------------------------------------------------
				
				
		// 최상위 요소만 남기고 나머지 전체 닫기
		$("#allClose").click(function(){
			$(".element").each(function(){
				$(this).hide().addClass("foldinged");
			});
			$(".0").each(function(){ // 최상위 요소만 뺑뺑이~
				var bool = $(this).hasClass("hided");
				if(!bool) { // 완료 숨김 상태가 아니라면 보여줌
					$(this).removeClass("foldinged").show()
					if($(this).find(".foldingIcon").text().trim() == "▼") {
						$(this).find(".foldingIcon").text("▶");
					}
				} else { // 완료 숨김 상태라면 보여주진 않고 접힌 상태만 해제해줌
					$(this).removeClass("foldinged");
					if($(this).find(".foldingIcon").text().trim() == "▼") {
						$(this).find(".foldingIcon").text("▶");
					}
				}
			})
		}); // end of $("#allClose").click(function() -------------------------------------------------------------------------------------				
		// 전체 요소 펴기
		$("#allOpen").click(function(){ 
			$(".element").each(function(){
				var downCnt = $(this).find(".downCnt").val();
				if(downCnt > 0) { // 하위요소가 있다면
					$(this).find(".foldingIcon").text("▼");
				}
				var bool = $(this).hasClass("hided");
				if(!bool) { // 완료 숨기기 상태가 아니라면
					$(this).show().removeClass("foldinged");
				} else { // 보여주진 않더라도 펴진 상태로 만들어줌
					$(this).removeClass("foldinged");
				}
			});
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
			$(this).parent().hide();
			$(this).parent().parent().find(".showInfo").show();
		}); // end of $(document).on("blur", ".hiddenEditInput", function() -------------------------------------------------------------------------
		// 모달창에서 정보 수정 seletor 박스를 벗어나면 show 폼으로 변경하기
		$(document).on("blur", ".hiddenEditSelector", function(){
			$(this).parent().removeClass("selectedLine");
			$(this).parent().hide();
			$(this).parent().parent().find(".showInfo").show();
		}); // end of $(document).on("blur", ".hiddenEditInput", function() -------------------------------------------------------------------------
		
		// 모달창에서 정보 수정을 하면 그 값을 바로 show 폼에 적용시키기
		$(document).on("keyup", ".hiddenEditInput", function(event){
			changeFlag = true;
			$(this).parent().parent().find(".showInfo").html($(this).val());
			if(event.keyCode == 13) {
				$(".modalEdit").trigger("click");
			}
		}); // end of $(document).on("keyup", ".hiddenEditInput", function() --------------------------------------------------------------------------	
		// 모달창에서 정보 수정하는 select 태그는 따로 처리함
		$(document).on("change", ".hiddenEditSelector", function(event){
			changeFlag = true;
			$(this).parent().parent().find(".showInfo").html($(this).val());
			$(this).parent().hide();
			$(this).parent().parent().find(".showInfo").show();
		}); // end of $(document).on("change", ".hiddenEditInput", function() --------------------------------------------------------------------------
		
		// 요소 모달창의 정보 수정하고 페이지에 새로운 정보로 갱신해주기
		$(document).on("click", ".modalEdit", function(){
			var $this = $("#modalSubject");
			if ($this.val().trim() == "") {
				alert("제목은 필수 입력사항입니다.");
				$this.parent().parent().find(".showInfo").hide();
				$this.parent().show();
				setTimeout(function() { $this.focus() }, 500); // 텀을 줘야만 focus 가 이동함;;;
				return false;
			}
			
			var bool = confirm("정말 수정하시겠습니까?");
			if(!bool) {
				return false;
			}
			
			// 모달창 정보 새롭게 갱신해주기
			$("#modalInfoFrm").ajaxForm({
				url:"do_goModalEdit.mr",
				dataType:"html",
				success:function(data){
					alert("정보수정이 성공했습니다.");
					$("#modalElementInfo").html(data);
				}, error:function(request, status, error){
	                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                return false;
				}
			});
			$("#modalInfoFrm").submit();
			
			// 리스트 페이지에도 새로운 정보로 입력해주기
			setTimeout(function(){ // DB지연 때문인지 반드시 지연시간 줘야만 새로운 정보를 들고옴...
				var term = $("#term").val();
				var page = $("#page").val();
				var idx = $("#folder_idx").val();			
				var frm = {"term":term, "page":page, "idx":idx};
				$.ajax({
					url:"do_getOneElement.mr",
					data:frm,
					dataType:"html",
					success:function(data) {
						var $this2 = $("#"+idx);
						$this2.after(data);
						$this2.remove();
					}, error:function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						return false;
					}
				});
				setTimeout(function(){ // 이것도 지연 줘야 제대로 돌아감;;;
					todayLine();
					addLine(idx);
					changeFlag = false;
				},300);
			},500);
		}); // end of function goModalEdit() -------------------------------------------------------------------------------------------------------------
		
		
		// 할일 완료나 미완료 체크하면 DB수정하고 css 변경해주기(기본+모달창에서 클릭시)
		$(document).on("change", ".status", function(){
			var checked = $(this).is(":checked");
			var idx = $(this).attr("id").replace("modalStatus","").replace("status","");
			var status = "";
			
			if(checked) { // 미완료 -> 완료
				$("#modalStatus").css({"color":"green"}).html("<label style='cursor:pointer;' for='modalStatus"+idx+"'>완료</label>");
				$("#status"+idx).prop("checked", true);			
				
				$("#"+idx).find(".dateColor").css({"background-color":"#d9d9d9"});
				
				status = "0";
				
				$("#"+idx).find("*").addClass("completeLine");
				
				setTimeout(function(){
					$("#"+idx).find("*").removeClass("completeLine");
					
					var bool = $("#toggleComeleted").hasClass("hided");
					if(bool) { // 만약 완료된 업무 숨기기 가 on 상태라면
						$("#"+idx).hide().addClass("hided"); // 숨기고
						var cnt = parseInt( $("#toggleComeletedCnt").val() ) + 1;
						$("#toggleComeletedCnt").val(cnt);
						$("#toggleComeleted").text("완료된 업무 "+cnt+"개 보기"); // 완료된 업무 숨기기에 +1개
						
						$("#toggleComeleted").addClass("completeLine");
						setTimeout(function(){
							$("#toggleComeleted").removeClass("completeLine");
						},1000);
					}
				},500);
			} else { // 완료 -> 미완료
				// 상위폴더의 완료/미완료 상태 확인 시작(상위폴더가 완료상태라면 미완료 처리 불가함)
				var upIdx = $("#"+idx).find(".fk_folder_idx").val();
				var upStatus = $("#"+upIdx).find(".statusValue").val();
				if(upStatus == 0) {
					alert("먼저 상위요소의 완료를 해제하셔야 합니다.");
					$("#"+upIdx).find("*").addClass("completeLine");
					setTimeout(function(){
						$("#"+upIdx).find("*").removeClass("completeLine");
					},1000);
					$(this).prop("checked", true);
					return false;
				}
				// 상위폴더의 완료/미완료 상태 확인 끝 ----------------------------------------------------------------------------
				
				$("#modalStatus").css({"color":"red"}).html("<label style='cursor:pointer;' for='modalStatus"+idx+"'>미완료</label>");
				$("#status"+idx).prop("checked", false);
				setDayColor(idx);
				status = "1";
				var dayCnt = $("#"+idx).find(".dayCnt").val();
				
				$("#"+idx).find("*").addClass("incompleteLine"); // 깜빡이는 효과
				setTimeout(function(){
					$("#"+idx).find("*").removeClass("incompleteLine");
				},500);
			} // end of 외부 if ~ else -----------------------------------------------------------------------------------------------------------
			
			$("#"+idx).find(".statusValue").val(status);
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
			
			if(checked) {  // 완료 -> 미완료 (이건 체크박스를 직접 입력하는게 아니기 때문에 위하고는 반대로 되어야함)
				// 상위폴더의 완료/미완료 상태 확인 시작(상위폴더가 완료상태라면 미완료 처리 불가함)
				var upIdx = $("#"+idx).find(".fk_folder_idx").val();
				var upStatus = $("#"+upIdx).find(".statusValue").val();
				if(upStatus == 0) {
					alert("먼저 상위요소의 완료를 해제하셔야 합니다.");
					$("#taskRcm").hide();
					$("#"+idx).removeClass("selectedLine");
					$("#"+upIdx).find("*").addClass("completeLine");
					setTimeout(function(){
						$("#"+upIdx).find("*").removeClass("completeLine");
					},1000);
					$(this).prop("checked", true);
					return false;
				}
				// 상위폴더의 완료/미완료 상태 확인 끝 ----------------------------------------------------------------------------
				
				$status.prop("checked", false);
				setDayColor(idx);
				status = "1";
				
				$("#"+idx).find("*").addClass("incompleteLine");
				setTimeout(function(){ // 깜빡이는 효과
					$("#"+idx).find("*").removeClass("incompleteLine");
				},500);
			} else {  // 미완료 -> 완료
				$status.prop("checked", true);
				status = "0";
				
				$("#"+idx).find(".dateColor").css({"background-color":"#d9d9d9"});
				
				$("#"+idx).find("*").addClass("completeLine");
				
				setTimeout(function(){
					$("#"+idx).find("*").removeClass("completeLine");
					
					var bool = $("#toggleComeleted").hasClass("hided");
					if(bool) { // 만약 완료된 업무 숨기기 가 on 상태라면
						$("#"+idx).hide().addClass("hided"); // 숨기고
						var cnt = parseInt( $("#toggleComeletedCnt").val() ) + 1;
						$("#toggleComeletedCnt").val(cnt);
						$("#toggleComeleted").text("완료된 업무 "+cnt+"개 보기"); // 완료된 업무 숨기기에 +1개
						
						$("#toggleComeleted").addClass("completeLine");
						setTimeout(function(){
							$("#toggleComeleted").removeClass("completeLine");
						},1000);
					}
				},500);
			} // end of 외부 if ~ else -----------------------------------------------------------------------------------------------------------
			
			$("#"+idx).find(".statusValue").val(status);
			var frm = {"idx":idx, "status":status};
			$.ajax({
				url:"do_taskComplete.mr",
				data:frm
			});
			
			$("#taskRcm").hide();
		}); // end of $(document).on("click", "#statusRcm", function() ------------------------------------------------------------------------------
		
		// 폴더 완료 체크하고 DB 수정하기(오른쪽클릭 메뉴)
		$(document).on("click", ".folderCompleteRcm", function(){
			// 일단 하위요소 다 펴주고 하위요소 중에 미완료 있는지 체크 시작
			var $this = $(".selectedLine");
			var depth = parseInt(getThirdClass($this)); // 선택한 요소의 깊이 구하기
			while(1==1) {
				if($this.next().attr("id") == undefined) { // 다음 요소가 없을때 undefined 오류 막기 위함
					break;
				}
				var $this2 = $this.next();
				var depth2 = parseInt(getThirdClass($this2)); // 다음 요소의 깊이 구하기
				if(depth < depth2) { // 선택한 요소의 깊이보다 다음 요소의 깊이가 크다면
					$this2.show().removeClass("foldinged"); // 일단 다 펴줌
					if( $this2.find(".foldingIcon").text().trim() == "▶" ) {
						$this2.find(".foldingIcon").text("▼");
					}
					
					if($this2.find(".statusValue").val() == "1") { // 하위요소 중에 완료되지 않은게 있다면
						$this2.addClass("incomplete");
					}
				} else { // 선택한것과 깊이가 같거나 큰 요소가 나오면 break
					break;
				}
				$this = $this2; // 순차적으로 다음 요소를 찾기 위함
			} // 일단 하위요소 다 펴주고 하위요소 중에 미완료 있는지 체크 끝 ----------------------------------------------------------------------------
			
			// 하위요소 중에 완료안된게 있는지 확인해서 깜빡여고 사용자한테 알려주기 시작
			var completeFlag = 0;
			$(".incomplete").each(function(){
				$(this).find("*").addClass("incompleteLine");
				completeFlag++;
			});			
			setTimeout(function(){
				$(".incomplete").each(function(){
					$(this).removeClass("incomplete");
					$(this).find("*").removeClass("incompleteLine"); // 깜빡이는 효과
				});
			},1000);
			if(completeFlag > 0) {
				alert("하위요소 중에 완료되지 않은 요소가 있습니다.");
				$("#folderRcm").hide();
				$("tr").removeClass("selectedLine");
				return false;
			} // 하위요소 중에 완료안된게 있는지 확인해서 깜빡여고 사용자한테 알려주기 끝 -----------------------------------------------
			
			// 하위요소가 전부 완료되면 선택한 요소도 완료해주기 시작
			var $this3 = $(".selectedLine");
			$("#folderRcm").hide();
			$this3.removeClass("selectedLine");
			$this3.find(".statusValue").val("0");
			$this3.find(".dateColor").css({"background-color":"#d9d9d9"});
			$this3.find("*").addClass("completeLine");
			setTimeout(function(){
				$this3.find("*").removeClass("completeLine");
			},1000);
			
			var idx = $this3.attr("id");
			var status = "0";
			var frm = {"idx":idx, "status":status};
			$.ajax({
				url:"do_taskComplete.mr",
				data:frm
			}); // 하위요소가 전부 완료되면 선택한 요소도 완료해주기 끝 ---------------------------------------------------------------------
		}); // end of $(document).on("click", ".folderCompleteRcm", function() ---------------------------------------------------------------
		
		// 폴더 미완료 체크하고 DB 수정하기(오른쪽클릭 메뉴)
		$(document).on("click", ".folderIncompleteRcm", function(){
			// 상위폴더의 완료/미완료 상태 확인 시작(상위폴더가 완료상태라면 미완료 처리 불가함)
			var $this = $(".selectedLine");
			var upIdx = $this.find(".fk_folder_idx").val();
			var upStatus = $("#"+upIdx).find(".statusValue").val();
			if(upStatus == 0) {
				alert("먼저 상위요소의 완료를 해제하셔야 합니다.");
				$("#folderRcm").hide();
				$this.removeClass("selectedLine");
				$("#"+upIdx).find("*").addClass("completeLine");
				setTimeout(function(){
					$("#"+upIdx).find("*").removeClass("completeLine");
				},1000);
				return false;
			}
			// 상위폴더의 완료/미완료 상태 확인 끝 ----------------------------------------------------------------------------
						
			// 상위폴더가 미완료라면 선택한 요소도 미완료해주기 시작
			var $this2 = $(".selectedLine");
			$("#folderRcm").hide();
			$this2.removeClass("selectedLine");
			$this2.find(".statusValue").val("1");
			
			var idx = $this2.attr("id"); 
			setDayColor(idx);
			$this2.find("*").addClass("incompleteLine");
			setTimeout(function(){
				$this2.find("*").removeClass("incompleteLine");
			},1000);
			
			var status = "1";
			var frm = {"idx":idx, "status":status};
			$.ajax({
				url:"do_taskComplete.mr",
				data:frm
			}); // 상위폴더가 미완료라면 선택한 요소도 미완료해주기 끝 ---------------------------------------------------------------------
		}); // end of $(document).on("click", ".folderIncompleteRcm", function() ---------------------------------------------------------------
		
		
		// 페이지 전체에서 esc 키를 누르면 모달창을 닫거나 이동하는 css 없애주기
		$(document).on("keydown", function(){
			var modalFlag = $('.modal').is(':visible');
			var folderRcmFlag = $("#folderRcm").is(':visible');
			var taskRcmFlag = $("#taskRcm").is(':visible');
			
			if(!modalFlag && !folderRcmFlag && !taskRcmFlag) { // 모달창, 우클릭 메뉴창이 열려 있는 상태가 아니라면
				delMoveCss(); // 이동 css 삭제~
			}
			
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
		
		
		// line 클래스 마우스 오버시 백그라운드칼라로 옅은 회색 주기 (새로 추가한 요소도 잡기 위해 어쩔 수 없이 document 로 처리함..)
		$(document).on("mouseover", ".trLine", function(){ // $("tr:has(td)") : tr 태그 중에서 td 태그인것만 선택함. th는 제외함
			$(this).addClass("selectLine");
		}); // end of $(document).on("mouseover", "tr:has(td)", function() ------------------------------------------------------------------
		$(document).on("mouseout", ".trLine", function(){
			$(this).removeClass("selectLine");
		}); // end of $(document).on("mouseout", "tr:has(td)", function() ------------------------------------------------------------------
		
		// pointer 클래스 마우스 오버시 css 바꿔주기
		$(document).on("mouseover", ".pointer", function(){
			$(this).addClass("pointerOver");
		}); // end of $(document).on("mouseover", ".pointer", function() ------------------------------------------------------------------
		$(document).on("mouseout", ".pointer", function(){
			$(this).removeClass("pointerOver");
		}); // end of $(document).on("mouseout", ".pointer", function() ------------------------------------------------------------------
		
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
		

		// 팀원 추가, 삭제 시작 -------------------------------------------------------------------------------------------------------------
		// 희안하게 모달창 jsp 파일에서 함수 넣으면 열고 닫을때마다 이벤트 카운트가 증가함..(팀원추가 한번 누르면 열고 닫은 횟수대로 실행됨....)
		// 담당 추가 버튼을 누르면 팀원 표시창 출력해주기
		$(document).on("click", "#btn_add", function(e){
			if($(e.target).hasClass("selectTeamwon")) { // 만약 클릭한것이 팀원 표시창의 팀원이라면
				$(".selectTeamwon").trigger("click");
			}
			var bool = $("#teamwonList").is(":visible");
			if(!bool) { // 팀원 표시창이 떠 있지 않다면
				var frm = {"team_idx":$("#team_idx").val()};
				$.ajax({
					url:"do_getTeamwonList.mr",
					data:frm,
					type:"post",
					dataType:"JSON",
					success:function(data){
						var html = "<div id='teamwonList'><table>";
						var cnt = 0;
						$.each(data, function(entryIndex, entry){
							var userid = $("#added"+entry.userid).text();
							if(entry.userid != userid) { // 이미 선택했던 팀원이 아니라면 */
								html += "<tr class='trLine'><td class='selectTeamwon pointer' style='border:1px solid black;'>"+entry.userid
								html += "<input type='hidden' id='id"+entry.userid+"' value='"+entry.idx+"'></td></tr>";
								cnt++;
							}
						});
						html += "</table></div>";
						
						if(cnt == 0) { // 읽어온 데이터가 없거나, 이미 모든 팀원을 선택했다면
							html = "<div id='teamwonList'>추가할 수 있는 팀원이 없습니다</div>"
						}
						
						$("#addTeamwon").append(html);
						
						$("#btn_add").text("[추가▼]");
						var left = $("#btn_add").position().left+25;
						var top = $("#btn_add").position().top;
						top = top + ($("#btn_add").height());
						$("#teamwonList").css({"left":left+"px", "top":top+"px"});
						
					}, error:function(){
						alert("알 수 없는 오류입니다.\n관리자에게 문의하세요.");
					}
				});
			} else { // 팀원 표시창이 떠 있다면
				$("#btn_add").text("[추가▷]");
				$("#teamwonList").remove();
			} // end of 외부 if ~ else --------------------------------------------------------------------------------------------------
		}); // end of $("#btn_add").click(function() -----------------------------------------------------------------------------------
				
		// 팀원 표시창에서 특정 아이디 클릭시 담당자 리스트에 추가해주고 팀원 표시창에서는 빼기
		$(document).on("click", ".selectTeamwon", function(){
			changeFlag = true;
			var userid = $(this).text();
			var idx = $("#id"+userid).val();
			var html = '<span id="folderTeamwon'+idx+'" class="pointer folderTeamwon" onclick="deleteFolderTeamwon(this)">'
					 + '	<span id="added'+userid+'">'+userid+'</span>'
					 + '    <input type="hidden" name="folder_teamwonIdxArr" value="'+idx+'">'
					 + '</span>';
			
			$("#selectedTeamwon").append(html);
			
			$(this).remove();
			if( !($("#teamwonList").find("td").hasClass("selectTeamwon")) ) { // 팀원표시창에 남은 팀원이 없다면
				$("#teamwonList").remove();
				$("#btn_add").text("[추가▷]");
			}
		}); // end of $(document).on("click", ".selectTeamwon", function() ----------------------------------------------------------------
		
		// 마우스 클릭 이벤트 있으면 일단 팀원 표시창 없애주기
		$(document).on("mousedown", function(e){
			var bool1 = $(e.target).hasClass("selectTeamwon");
			var bool2 = $(e.target).attr("id") == "btn_add";
			var bool3 = $(e.target).hasClass("teamwonElementOn");
			if(!bool1 && !bool2 && !bool3) { // 클릭 대상이 팀원 선택창이나 추가 버튼이 아니라면
				$("#teamwonList").remove();
				$("#btn_add").text("[추가▷]");
			}
		}); // end of $(document).mousedown(function() ------------------------------------------------------
		
		// esc 누르면 팀원 표시창 없애주기
		$(document).on("keydown", function(e){
			if(e.keyCode == 27) {
				$("#teamwonList").remove();
				$("#btn_add").text("[추가▷]");
			}
		}); // end of $(document).on("keydown", function(e) ----------------------------------------------------------------------
		// 팀원 추가, 삭제 끝 -------------------------------------------------------------------------------------------------------------
		
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
		window.open("do_addDownElement.mr?upIdx="+upIdx+"&term="+term+"&page="+page, "subwinpop", "left=100px, top=100px, width=700px, height=500px");
	} // end of function addDownElement() -----------------------------------------------------------------------------------------------------------------------------
	// 최상위 요소 추가
	function addUpElement() {
		var upIdx = $(".selectedLine").attr("id");
		var term = $("#term").val();
		var page = $("#page").val();
		window.open("do_addDownElement.mr?upIdx="+0+"&term="+term+"&page="+page, "subwinpop", "left=100px, top=100px, width=700px, height=500px");
	} // end of function addDownElement() -----------------------------------------------------------------------------------------------------------------------------
	// 요소 추가되었을때 살짝 깜빡여 주기
	function addLine(id) {
		$("#"+id).find("*").addClass("addLine");
		setTimeout(function(){
			$("#"+id).find("*").removeClass("addLine");
		},1500);
	} // end of function addLine(id) ---------------------------------------------------------------------------------------------------------------------------------
	
	// 선택 요소의 아래 요소들 전부 펴고 닫기
	function downElementFolding() {
		$this = $(".selectedLine");
		var bool = $this.next().hasClass("foldinged"); // 선택 요소의 바로 다음 요소의 접힘, 펴짐 상태를 저장한다.
		var depth = parseInt(getThirdClass($this)); // 선택 요소의 깊이 구하기
		while(1==1) {
			if($this.next().attr("id") == undefined) { // 다음 요소가 없을때 undefined 오류 막기 위함
				break;
			}
			var $this2 = $this.next();
			var depth2 = parseInt(getThirdClass($this2)); // 다음 요소의 깊이 구하기
			
			if(depth < depth2) { // 선택 요소의 하위요소는 전부 show 나 hide 상태로 변경해줄 생각임
				if(!bool) { // 선택 요소의 다음 요소가 펴짐 상태라면
					$this2.hide().addClass("foldinged"); // 하위요소 전부 다 숨김
					$(".selectedLine").find(".foldingIcon").text("▶");
					$("#downElementFoldingRcm").text("하위요소 전체 펴기");
					if( $this2.find(".foldingIcon").text().trim() == "▼" ) {
						$this2.find(".foldingIcon").text("▶");
					}
				} else { // 선택 요소의 다음 요소가 접힘 상태라면
					var bool3 = $this2.hasClass("hided");
					if(!bool3) { // 완료된 업무 숨기기로 숨겨진게 아니라면
						$this2.show(); // 하위요소 전부 다 보여줌
						$(".selectedLine").find(".foldingIcon").text("▼");
						$("#downElementFoldingRcm").text("하위요소 전체 접기");
						if( $this2.find(".foldingIcon").text().trim() == "▶" ) {
							$this2.find(".foldingIcon").text("▼");
						}
					}
					$this2.removeClass("foldinged"); // 보여주든 말든 일단 펴진 상태로 만듬
				}
			} else { // 상위요소와 깊이가 같은 요소가 나오면 break
				break;
			}
			$this = $this2; // 순차적으로 다음 요소를 찾기 위함
		} // end if while -------------------------------------------------------------------------------------------------
	}
	
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
	function selectFolderInfo(idx) {
		var frm = {"idx":idx};
		$.ajax({
			url:"do_getSelectFolderInfo.mr",
			data:frm,
			dataType:"html",
			success:function(data){
				$("#modalElementInfo").html(data);
				$("#modalElementInfo").modal({backdrop:'static'});
			}, error:function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	} // end of function selectTaskInfo(frm) ------------------------------------------------------------------------------------------------
	

	// 할일 모달창 띄우기
	function selectTaskInfo(idx) {
		var frm = {"idx":idx};
		$.ajax({
			url:"do_getSelectTaskInfo.mr",
			data:frm,
			dataType:"html",
			success:function(data){
				$("#modalElementInfo").html(data);
				$("#modalElementInfo").modal({backdrop:'static'});
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
		<fmt:formatDate value="${today}" var="now" pattern="yyMMdd"/> // 오늘 날짜를 구해서
		var now = ${now};
		$("."+now).each(function(){ // 클래스가 오늘 날짜인건 전부 가운데 줄 그어주는 css 추가
			$(this).addClass("line-in-middle");
		});
	} // end of function todayLine() --------------------------------------------------------------------------------------------------------------
	
	
	// 완료/미완료 처리시 기간에 대한 색상을 바꿔주는 함수 
	function setDayColor(idx) {
		var $dateColor = $("#"+idx).find(".dateColor");
		var dayCnt = $("#"+idx).find(".dayCnt").val();
		if(dayCnt == 0) { // 진행전이라면
			$dateColor.css({"background-color":"#cce6ff"});
		} else if (dayCnt == 1) { // 진행중이라면
			$dateColor.css({"background-color":"#d6f5d6"});
		} else if (dayCnt == -1) { // 기한경과라면
			$dateColor.css({"background-color":"#ffcccc"});
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
				var commentArr = $(data).find(":root").find("comment");
				var html = "";
				commentArr.each(function(){
					html += "<tr>";
					html += "	<td>"+$(this).find("userid").text()+"</td>";
					html += "	<td>"+$(this).find("content").text()+"</td>";
					html += "	<td>"+$(this).find("writeDate").text()+"</td>";
					html += "	<td>x<td>";
					html += "</tr>";
				});
				$("#modalCommentList").html(html);
				
				var pageBar = $(data).find(":root").find("pageBar").html();
				$("#pageBar").html(pageBar);
				
			}, error: function (xhr, ajaxOptions, thrownError) {
		        console.log(xhr.status);
		        console.log(thrownError);
		    }
		});		
	} // end of function addComment() ----------------------------------------------------------------------------------------------------------------------
	
	
	// 내가 속한 요소에 css 입히기
	function myElementOn() {
		$.ajax({
			url:"do_getMyElement.mr",
			dataType:"xml",
			success:function(data){
				var $root = $(data).find(":root")
				var idxArr = $root.find("idx");
				idxArr.each(function(){
					$this = $("#"+$(this).text());
					if ($this.hasClass("teamwonElement")) {
						$this.removeClass("teamwonElement");
						$this.addClass("myAndTeamwonElement");
					} else if ($this.hasClass("searchElement")) {
						$this.removeClass("searchElement");
						$this.addClass("myAndSearchElement");
					} else if ($this.hasClass("teamwonAndSearchElement")) {
						$this.removeClass("teamwonAndSearchElement");
						$this.addClass("myAndTeamwonAndSearchElement");
					} else {
						$this.addClass("myElement");
					}
				});				
				
				var before = $root.find("before").text();
				var doing = $root.find("doing").text();
				var lapse = $root.find("lapse").text();
				var complete = $root.find("complete").text();
				
				$("#myBefore").text("("+before+"건)");
				$("#myDoing").text("("+doing+"건)");
				$("#myLapse").text("("+lapse+"건)");
				$("#myComplete").text("("+complete+"건)");
				
			}, error: function (xhr, ajaxOptions, thrownError) {
		        console.log(xhr.status);
		        console.log(thrownError);
		    }
		});
	} // end of function myElementOn() -------------------------------------------------------------------------------------------------------------------------
	// 내가 속한 요소에 css 해제
	function myElementOff() {
		$(".element").each(function() {
			if ($(this).hasClass("myAndTeamwonElement")) {
				$(this).removeClass("myAndTeamwonElement");
				$(this).addClass("teamwonElement");
			} else if ($(this).hasClass("myAndSearchElement")) {
				$(this).removeClass("myAndSearchElement");
				$(this).addClass("searchElement");
			} else if ($(this).hasClass("myAndTeamwonAndSearchElement")) {
				$(this).removeClass("myAndTeamwonAndSearchElement");
				$(this).addClass("teamwonAndSearchElement");
			} else if ($(this).hasClass("myElement")) {
				$(this).removeClass("myElement");
			}
		});
		$("#myBefore").text("");
		$("#myDoing").text("");
		$("#myLapse").text("");
		$("#myComplete").text("");
	} // end of function myElementOff() ---------------------------------------------------------------------------------------------------------------------------
	
	// 팀원요소 볼때 팀원리스트 띄워주기
	function teamwonListView() {
		var bool = $("#teamwonList").is(":visible");
		if(!bool) { // 팀원 표시창이 떠 있지 않다면
			var frm = {"team_idx":$("#team_idx").val()};
			$.ajax({
				url:"do_getTeamwonList.mr",
				data:frm,
				type:"post",
				dataType:"JSON",
				success:function(data){
					var html = "<div id='teamwonList' style='border:1px solid #cce6ff; background-color:#4882ab; width:100px;'><table style='width:100%;'>";
					$.each(data, function(entryIndex, entry){
						var userid = "${sessionScope.loginUser.userid}";
						if(entry.userid != userid) { // 현재 로그인한 팀원(한마디로 본인)이 아니라면
							html += "<tr class='trLine'><td class='pointer teamwonElementOn' onclick='teamwonElementOn(this)' style='border:1px solid #cce6ff;'>"+entry.userid
							html += "<input type='hidden' id='"+entry.userid+"' value='"+entry.idx+"'></td></tr>";
						}
					});
					html += "</table></div>";
					
					$("#firstHeaderLine").append(html);
					
					var left = $("#teamwonListView").offset().left;
					var top = $("#teamwonListView").offset().top;
					top = top + ($("#teamwonListView").height());
					$("#teamwonList").css({"left":left, "top":top}); // 팀원 표시창의 절대 위치를 넣어줌
					
				}, error:function(){
					alert("알 수 없는 오류입니다.\n관리자에게 문의하세요.");
				}
			});
		}
	} // end of function teamwonListView() -----------------------------------------------------------------------------------
	// 팀원이 속한 요소에 css 입히기
	function teamwonElementOn(element) {
		teamwonElementOff();
		var userid = $(element).text();
		var idx = $("#"+userid).val();
		var frm = {"fk_teamwon_idx":idx};
		$("#teamwonList").remove();
		$.ajax({
			url:"do_getTeamwonElement.mr",
			data:frm,
			dataType:"xml",
			success:function(data){
				var $root = $(data).find(":root")
				var idxArr = $root.find("idx");
				idxArr.each(function(){
					$this = $("#"+$(this).text());
					if ($this.hasClass("myElement")) {
						$this.removeClass("myElement");
						$this.addClass("myAndTeamwonElement");
					} else if ($this.hasClass("searchElement")) {
						$this.removeClass("searchElement");
						$this.addClass("teamwonAndSearchElement");
					} else if ($this.hasClass("myAndSearchElement")) {
						$this.removeClass("myAndSearchElement");
						$this.addClass("myAndTeamwonAndSearchElement");
					} else {
						$this.addClass("teamwonElement");
					}
				});				
				
				var before = $root.find("before").text();
				var doing = $root.find("doing").text();
				var lapse = $root.find("lapse").text();
				var complete = $root.find("complete").text();
				
				$("#teamwonBefore").text("("+before+"건)");
				$("#teamwonDoing").text("("+doing+"건)");
				$("#teamwonLapse").text("("+lapse+"건)");
				$("#teamwonComplete").text("("+complete+"건)");
				
			}, error: function (xhr, ajaxOptions, thrownError) {
		        console.log(xhr.status);
		        console.log(thrownError);
		    }
		});
	} // end of function myElementOn() -------------------------------------------------------------------------------------------------------------------------
	// 팀원이 속한 요소에 css 해제
	function teamwonElementOff() {
		$(".element").each(function() {
			if ($(this).hasClass("myAndTeamwonElement")) {
				$(this).removeClass("myAndTeamwonElement");
				$(this).addClass("myElement");
			} else if ($(this).hasClass("teamwonAndSearchElement")) {
				$(this).removeClass("teamwonAndSearchElement");
				$(this).addClass("searchElement");
			} else if ($(this).hasClass("myAndTeamwonAndSearchElement")) {
				$(this).removeClass("myAndTeamwonAndSearchElement");
				$(this).addClass("myAndSearchElement");
			} else {
				$(this).removeClass("teamwonElement");
			}
		});
		$("#teamwonBefore").text("");
		$("#teamwonDoing").text("");
		$("#teamwonLapse").text("");
		$("#teamwonComplete").text("");
	} // end of function myElementOff() ---------------------------------------------------------------------------------------------------------------------------
	
	// 검색한 요소에 css 입히기
	function serchElementOn(searchWord) {
		// 일단 다 지우고
		$(".element").each(function() {
			if ($(this).hasClass("myAndSearchElement")) {
				$(this).removeClass("myAndSearchElement");
				$(this).addClass("myElement");
			} else if ($(this).hasClass("teamwonAndSearchElement")) {
				$(this).removeClass("teamwonAndSearchElement");
				$(this).addClass("teamwonElement");
			} else if ($(this).hasClass("myAndTeamwonAndSearchElement")) {
				$(this).removeClass("myAndTeamwonAndSearchElement");
				$(this).addClass("myAndTeamwonElement");
			} else if ($(this).hasClass("searchElement")) {
				$(this).removeClass("searchElement");
			} 
		});
		$("#searchBefore").text("");
		$("#searchDoing").text("");
		$("#searchLapse").text("");
		$("#searchComplete").text("");
		
		if(searchWord == "") { // 검색어가 비었다면 멈춤
			return false;
		}
		var frm = {"searchWord":searchWord};
		$.ajax({
			url:"do_getSearchElement.mr",
			data:frm,
			dataType:"xml",
			success:function(data){
				var $root = $(data).find(":root")
				var idxArr = $root.find("idx");
				idxArr.each(function(){
					$this = $("#"+$(this).text());
					if ($this.hasClass("myElement")) {
						$this.removeClass("myElement");
						$this.addClass("myAndSearchElement");
					} else if ($this.hasClass("teamwonElement")) {
						$this.removeClass("teamwonElement");
						$this.addClass("teamwonAndSearchElement");
					} else if ($this.hasClass("myAndTeamwonElement")){
						$this.removeClass("myAndTeamwonElement");
						$this.addClass("myAndTeamwonAndSearchElement");
					} else {
						$this.addClass("searchElement");
					}
				});
				
				var before = $root.find("before").text();
				var doing = $root.find("doing").text();
				var lapse = $root.find("lapse").text();
				var complete = $root.find("complete").text();
				
				$("#searchBefore").text("("+before+"건)");
				$("#searchDoing").text("("+doing+"건)");
				$("#searchLapse").text("("+lapse+"건)");
				$("#searchComplete").text("("+complete+"건)");
				
			}, error: function (xhr, ajaxOptions, thrownError) {
		        console.log(xhr.status);
		        console.log(thrownError);
		    }
		});
	} // end of function elementSerch() ---------------------------------------------------------------------------------------------------------------

	// 완료된 요소 숨기거나 보여주기 토글
	function toggleComeleted(element) {
		var bool1 = $(element).hasClass("hided");
		var cnt = 0;
		
		if(bool1) { // 만약 숨기기 on 이라면 다시 보여줌
			$(".element").each(function() {
				var bool2 = $(this).find(".statusValue").val();
				var bool3 = $(this).hasClass("foldinged");
				
				if( bool2 == "0" && !bool3 ) { // 완료되었으면서 접힌 상태가 아니라면
					$(this).show().removeClass("hided");
				} else if (bool2 == "0") { // 접힌 상태라면 보여주진 않아도 완료 숨김 클래스는 지워줄것
					$(this).removeClass("hided");
				}
			});
			$("#toggleComeleted").text("완료된 업무 숨기기").removeClass("hided");
		} else { // 만약 숨기기 off 이라면 숨김
			$(".statusValue").each(function(){
				if( $(this).val() == "0" ) {
					$(this).parents(".element").hide().addClass("hided");
					cnt++;
				}
			});
			$("#toggleComeleted").text("완료된 업무 "+cnt+"개 보기").addClass("hided");
			$("#toggleComeletedCnt").val(cnt);
		}
	} // end of function toggleComeleted() ------------------------------------------------------------------------------------------------------------------------
	
	// 상위요소를 변경하기 전이나 esc 눌렀을때 기존에 입힌 css 지워주기
	function delMoveCss() {
		$("#moveHeader").remove();
		$(".element").each(function(){
			$(this).removeClass("moveLine");
			$(this).removeClass("moveToLine");
		});
	} // end of function delMoveCss() ------------------------------------------------------------------------------------------------------------------------------
	// 상위요소 변경하는(요소 이동) css 띄우기
	function elementMove() {
		delMoveCss();
		$this = $(".selectedLine");
		$this.addClass("moveLine");
		var depth = parseInt(getThirdClass($this)); // 클릭한 요소의 깊이 구하기
		while(1==1) {
			if($this.next().attr("id") == undefined) { // 다음 요소가 없을때 undefined 오류 막기 위함
				break;
			}
			var $this2 = $this.next();
			var depth2 = parseInt(getThirdClass($this2)); // 다음 요소의 깊이 구하기
			
			if(depth < depth2) { // 클릭한 요소의 깊이보다 다음 요소의 깊이가 1 크다면 (클릭했을때 +1 깊이만 표시되도록 하기 위해서 구분함)
				$this2.addClass("moveLine");
			} else { // 클릭한것과 깊이가 같은 요소가 나오면 break
				break;
			}
			$this = $this2; // 순차적으로 다음 요소를 찾기 위함
		}
		$("#folderRcm").hide(); // 메뉴 숨겨주고
		$("#taskRcm").hide();
		
		$("#headerLine").after("<tr id='moveHeader'><th colspan='100' style='text-align:center; color:black !important; background-color:#ffffcc ;'>이동될 요소를 선택하세요(취소:esc)</th></tr>");
		// 제목줄 밑에 선택하라고 띄워주고
		
		$(".element").each(function(){
			if( !($(this).hasClass("moveLine")) && $(this).find(".category").val() == 1) { // 폴더 요소라면
				$(this).addClass("moveToLine"); // 이동할 수 있도록 노란줄 표시
			}
		});
		$("#allOpen").trigger("click"); // 그리고 전체 요소를 펴준다.
	} // end of function elementMove() --------------------------------------------------------------------------------------------------------------------------------
	// 상위요소 변경하기(요소 이동)
	function elementMoveEnd(fk_folder_idx, movoToDepth, groupNo, subject) {
		var bool = confirm("정말 ["+subject+"] 폴더로 이동하시겠습니까?");
		if(!bool) {
			return false;
		}
		
		$this = $(".moveLine").first();
		var idx = $this.attr("id");
		var term = $("#term").val();
		var page = $("#page").val();
		var moveDepth = parseInt(getThirdClass($this));
		var depth = parseInt(movoToDepth) - moveDepth + 1; // 원래 요소와 변경되는 요소의 깊이 차이를 구함
		
		var frm = document.createElement("form");
		frm.setAttribute("action","do_elementMove.mr");
		frm.setAttribute("mothod","post");
		
		var idx_frm = document.createElement("input");
		idx_frm.setAttribute("name","idx");
		idx_frm.setAttribute("value",idx);
		
		var fk_idx_frm = document.createElement("input");
		fk_idx_frm.setAttribute("name","fk_folder_idx");
		fk_idx_frm.setAttribute("value",fk_folder_idx);
		
		var groupNo_frm = document.createElement("input");
		groupNo_frm.setAttribute("name","groupNo");
		groupNo_frm.setAttribute("value",groupNo);
		
		var depth_frm = document.createElement("input");
		depth_frm.setAttribute("name","depth");
		depth_frm.setAttribute("value",depth);
		
		var term_frm = document.createElement("input");
		term_frm.setAttribute("name","term");
		term_frm.setAttribute("value",term);
		
		var page_frm = document.createElement("input");
		page_frm.setAttribute("name","page");
		page_frm.setAttribute("value",page);
		
		frm.appendChild(idx_frm);
		frm.appendChild(fk_idx_frm);
		frm.appendChild(groupNo_frm);
		frm.appendChild(depth_frm);
		frm.appendChild(term_frm);
		frm.appendChild(page_frm);
		
		document.body.appendChild(frm);
		frm.submit();
	} // end of function elementMoveEnd(fk_folder_idx, movoToDepth, groupNo, subject) ------------------------------------------------------------------------------
</script>

<div id="projectDiv" style="width:100%; float:left; height:100%; overflow:auto; font-family:proxima-nova-regular; font-size:10pt; background-color:hsl(220, 60%, 97%);">
	<table style="width:100%; border:1px solid black;">
		<thead style="color:white;">
			<tr id="firstHeaderLine">
				<th colspan="${map.pageDateList.size() + 7}">
					<span id="allClose" class="pointer" style="margin-left:20px;">[ 전체접기</span>  ||  <span id="allOpen" class="pointer">전체펴기</span> ]
					&nbsp;&nbsp;&nbsp;
					[ <span class="pointer" onclick="addUpElement()">최상위 폴더 만들기</span> ]
					&nbsp;&nbsp;&nbsp;
					[ <span class="pointer" onclick="myElementOn()">내할일표시</span>  ||  <span class="pointer" onclick="myElementOff()">해제</span> ]
					&nbsp;&nbsp;&nbsp;
					[ <span class="pointer" id="teamwonListView" onclick="teamwonListView()">팀원표시</span>  ||  <span class="pointer" onclick="teamwonElementOff()">해제</span> ]
					&nbsp;&nbsp;&nbsp;
					[ <span class="pointer" id="toggleComeleted" onclick="toggleComeleted(this)">완료된 업무 숨기기</span>]
					<input type="hidden" value="0" id="toggleComeletedCnt" />
					<span style="float:right; color:white;">
						<input type="text" placeholder="&nbsp;&nbsp;프로젝트 검색" style="height:20px; color:white; background-color:#154465; border:none;" onkeyup="serchElementOn(this.value)"/>
					</span>
			</tr>
			
			<tr>
				<th colspan="7" class="seperatorLine" style="border-bottom:none;">
					<span style="margin-left:20px; border:1px solid #cce6ff; width:20px; height:10px; background-color:#cce6ff;">&nbsp;&nbsp;&nbsp;</span>
					진행전(${map.periodCntMap.before}건
						<span id="myBefore" style="color:hsl(60, 100%, 40%); font-weight:bold;"></span>
						<span id="teamwonBefore" style="color:hsl(300, 100%, 30%); font-weight:bold;"></span>
						<span id="searchBefore" style="color:hsl(180, 60%, 50%); font-weight:bold;"></span>
					)
					<span style="margin-left:15px; border:1px solid #cce6ff; width:20px; height:10px; background-color:#d6f5d6;">&nbsp;&nbsp;&nbsp;</span>
					진행중(${map.periodCntMap.doing}건
						<span id="myDoing" style="color:hsl(60, 100%, 40%); font-weight:bold;"></span>
						<span id="teamwonDoing" style="color:hsl(300, 100%, 30%); font-weight:bold;"></span>
						<span id="searchDoing" style="color:hsl(180, 60%, 50%); font-weight:bold;"></span>
					)					
				</th>
				<th colspan="${map.pageDateList.size()}" style="border-bottom:none; text-align:center; width:200px;">
					<form name="pageDateFrm" method="get" action="do_changePageDate.mr">
						<span class="pointer" onclick="beforeTerm()">◀</span>
						<span class="pointer" onclick="beforeDate()">◁</span>
						<select id="term" name="term" style="background-color:#4882ab; border:none;" onchange="changePageDate()">
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
				<th colspan="7" class="seperatorLine" style="border-top:none;">
					<span style="margin-left:20px; border:1px solid #cce6ff; width:20px; height:10px; background-color:#ffcccc;">&nbsp;&nbsp;&nbsp;</span>
					기한경과(${map.periodCntMap.lapse}건
						<span id="myLapse" style="color:hsl(60, 100%, 40%); font-weight:bold;"></span>
						<span id="teamwonLapse" style="color:hsl(300, 100%, 30%); font-weight:bold;"></span>
						<span id="searchLapse" style="color:hsl(180, 60%, 50%); font-weight:bold;"></span>
					)
					<span style="margin-left:15px; border:1px solid #cce6ff; width:20px; height:10px; background-color:#d9d9d9;">&nbsp;&nbsp;&nbsp;</span>
					완료(${map.periodCntMap.complete}건
						<span id="myComplete" style="color:hsl(60, 100%, 40%); font-weight:bold;"></span>
						<span id="teamwonComplete" style="color:hsl(300, 100%, 30%); font-weight:bold;"></span>
						<span id="searchComplete" style="color:hsl(180, 60%, 50%); font-weight:bold;"></span>
					)
				</th>
				<th colspan="${map.pageDateList.size()}" style="border-top:none; text-align:center;">
					
				</th>
			</tr>
			
			<tr id="headerLine">
				<th style="text-align:center;">제목</th>
				<th style="text-align:center; width:35px;">담당</th>
				<th style="text-align:center; width:35px;">파일</th>
				<th style="text-align:center; width:35px;">댓글</th>
				<th style="text-align:center; width:70px;">시작일</th>
				<th style="text-align:center; width:70px;">마감일</th>
				<th style="text-align:center; width:55px;" class="seperatorLine">중요도</th>
				<c:forEach var="pageDate" items="${map.pageDateList}">
					<th class="pointer" ondblClick="callToday()" style="text-align:center; font-weight:normal !important;
						<c:if test="${map.pageDateList.size() == 7}">
							width:75px;
						</c:if>
						<c:if test="${map.pageDateList.size() == 31}">
							width:17px;
							font-size:8pt !important;
						</c:if>
						<%-- <c:if test="${pageDate.dotw == '토' || pageDate.dotw == '일'}">
							background-color:#fff3e6;
						</c:if> --%>
						<c:if test="${fn:substring(pageDate.day, 4, 6) == '01'}">
							border-left:2px solid #ff66ff;
						</c:if>
					">${pageDate.dayDP}</th>
				</c:forEach>
			</tr>
		</thead>
		<tbody style="color:navy;">
			<c:if test="${empty map.doList}"> <!-- 프로젝트 리스트가 비었다면 -->
				<td colspan="9">등록된 프로젝트가 없습니다.</td>
			</c:if>
			<jsp:include page="doListLine.jsp"/> <!-- 여러번 활용하기 위해 할일 리스트는 다른 페이지로 뺏음 -->
		</tbody>
	</table>
	<div style="width:100%; height:100px; background-color:hsl(220, 60%, 97%);"></div>
</div>

<div class="modal fade" id="modalElementInfo" role="dialog"></div>

<div id="folderRcm" style="padding:0px; display:none; border:1px solid #cce6ff; background-color:#4882ab;">
	<table>
		<tr>
			<th class="rcmSubject"></th>
		</tr>
		<tr class="trLine">
			<td class="rcm pointer" id="folderStatusRcm" class="folderCompleteRcm">&nbsp;&nbsp;폴더 완료 처리&nbsp;&nbsp;</td>
		</tr>
		<tr class="trLine">
			<td class="rcm pointer" id="downElementFoldingRcm" onclick="downElementFolding()">&nbsp;&nbsp;하위요소 전체 펴기&nbsp;&nbsp;</td>
		</tr>
		<tr class="trLine">
			<td class="rcm pointer" id="addFolderRcm" onclick="addDownElement()">&nbsp;&nbsp;하위요소추가&nbsp;&nbsp;</td>
		</tr>
		<tr class="trLine">
			<td class="rcm pointer" id="modalFolderRcm">&nbsp;&nbsp;조회/수정&nbsp;&nbsp;</td>
		</tr>
		<tr class="trLine">
			<td class="rcm pointer" id="moveRcm" onclick="elementMove()">&nbsp;&nbsp;이동&nbsp;&nbsp;</td>
		</tr>
		<tr class="trLine">
			<td class="rcm pointer" id="copyRcm" onclick="elementCopy()">&nbsp;&nbsp;복사(미구현)&nbsp;&nbsp;</td>
		</tr>
		<tr class="trLine">
			<td class="rcm pointer" id="deleteRcm">&nbsp;&nbsp;삭제&nbsp;&nbsp;</td>
		</tr>
	</table>
</div>


<div id="taskRcm" style="padding:0px; display:none; border:1px solid #cce6ff; background-color:#4882ab;">
	<table>
		<tr>
			<th class="rcmSubject"></th>
		</tr>
		<tr class="trLine">
			<td class="rcm pointer" id="statusRcm">&nbsp;&nbsp;할일 완료 처리&nbsp;&nbsp;</td>
		</tr>
		<tr class="trLine">
			<td class="rcm pointer" id="modalTaskRcm">&nbsp;&nbsp;조회/수정&nbsp;&nbsp;</td>
		</tr>
		<tr class="trLine">
			<td class="rcm pointer" id="moveRcm" onclick="elementMove()">&nbsp;&nbsp;이동&nbsp;&nbsp;</td>
		</tr>
		<tr class="trLine">
			<td class="rcm pointer" id="copyRcm" onclick="elementCopy()">&nbsp;&nbsp;복사(미구현)&nbsp;&nbsp;</td>
		</tr>
		<tr class="trLine">
			<td class="rcm pointer" id="deleteRcm">&nbsp;&nbsp;삭제&nbsp;&nbsp;</td>
		</tr>
	</table>
</div>














<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style type="text/css">
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
	.pointerOver{
		color:blue;
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
	
	.myElement {
		background-color:#ffff99;
	}
	
	.seperatorLine {
		border-right:3px solid black;
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
		$(document).on("click", ".modalFolder", function(){
			var frm = {"idx":$(this).parents(".element").attr("id")};
		 	selectFolderInfo(frm);
		 	return false; // 폴더 접고펴기가 실행되지 않도록 설정해둠
		}); // end of $(".modalFolder").click(function() ------------------------------------------------------------------------
		
		// 할일 모달창 띄우기(값만 가지고 함수로 이동하게됨)
		$(document).on("click", ".modalTask", function(){
		 	var frm = {"idx":$(this).attr("id").replace("subject","")};
		 	selectTaskInfo(frm);
		 	return false;
		}); // end of $(".modalFolder").click(function() ------------------------------------------------------------------------
		
		// 폴더 모달창 띄우기(우클릭 메뉴)
		$(document).on("click", "#modalFolderRcm", function(){
			var frm = {"idx":$(".selectedLine").attr("id").replace("subject","")};
			selectFolderInfo(frm);
		});
		
		// 할일 모달창 띄우기(우클릭 메뉴)
		$(document).on("click", "#modalTaskRcm", function(){
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
			$(".0").show().find(".foldingIcon").text("▶");
		}); // end of $("#allClose").click(function() -------------------------------------------------------------------------------------
		
				
		// 폴더 전체 펴기
		$("#allOpen").click(function(){ 
			$(".element").each(function(){
				var downCnt = $(this).find(".downCnt").val();
				if(downCnt > 0) { // 하위요소가 있다면
					$(this).find(".foldingIcon").text("▼");
				}
			});
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
		$(document).on("keyup", ".hiddenEditInput", function(event){
			changeFlag = true;
			$(this).parent().parent().find(".showInfo").html($(this).val());
			if(event.keyCode == 13) {
				$(".modalEdit").trigger("click");
			}
		}); // end of $(document).on("keyup", ".hiddenEditInput", function() --------------------------------------------------------------------------
		
		// 요소 모달창의 정보를 수정하기
		$(document).on("click", ".modalEdit", function(){
			$("#modalInfoFrm").ajaxForm({
				url:"do_goModalEdit.mr",
				dataType:"json",
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
			
			$("#modalInfoFrm").submit();
		}); // end of function goModalEdit() -------------------------------------------------------------------------------------------------------------
		
		
		// 할일 완료나 미완료 체크하면 DB수정하고 css 변경해주기(기본+모달창에서 클릭시)
		$(document).on("change", ".status", function(){
			var checked = $(this).is(":checked");
			var idx = $(this).attr("id").replace("modalStatus","").replace("status","");
			var status = "";
			
			if(checked) {
				$("#modalStatus").css({"color":"green"}).html("<label style='cursor:pointer;' for='modalStatus"+idx+"'>완료</label>");
				$("#status"+idx).prop("checked", true);			
				
				$("#"+idx).find(".dateColor").css({"background-color":"gray"});
				
				status = "0";
				
				$("#"+idx).find("*").addClass("completeLine"); // 깜빡이는 효과
				setTimeout(function(){
					$("#"+idx).find("*").removeClass("completeLine");
				},500);
			} else {
				$("#modalStatus").css({"color":"red"}).html("<label style='cursor:pointer;' for='modalStatus"+idx+"'>미완료</label>");
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
								html += "<tr><td class='selectTeamwon pointer' style='border:1px solid black;'>"+entry.userid
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
			var userid = $(this).text();
			var idx = $("#id"+userid).val();			
			var html = '<span id="folderTeamwon'+idx+'" class="pointer" onclick="deleteFolderTeamwon('+idx+')">'
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
			if(!bool1 && !bool2) { // 클릭 대상이 팀원 선택창이나 추가 버튼이 아니라면
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
					var idx = $(this).text();
					$("#"+idx).addClass("myElement");
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
	}	
	// 내가 속한 요소에 css 입히기 해제
	function myElementOff() {
		$("tr").removeClass("myElement");
		$("#myBefore").text("");
		$("#myDoing").text("");
		$("#myLapse").text("");
		$("#myComplete").text("");
	}
</script>

<div class="container" style="width:100%; float:left">
	<table style="width:100%; border:1px solid black;">
		<thead>
			<tr>
				<th colspan="7" class="seperatorLine" style="width:65%;">
					<span id="allClose" class="pointer" style="margin-left:20px;">[ 전체접기</span>  ||  <span id="allOpen" class="pointer">전체펴기</span> ]
					&nbsp;&nbsp;&nbsp;&nbsp;
					[ <span class="pointer" onclick="myElementOn()">내할일표시</span>  ||  <span class="pointer" onclick="myElementOff()">해제</span> ]
				</th>
				<th colspan="${map.pageDateList.size()}" style="text-align:center; width:35%;"></th>
			</tr>
			
			<tr>
				<th colspan="7" class="seperatorLine">
					<div style="margin-left:20px; border-left:10px solid lightgreen; height:10px; display:inline;"></div>
					진행전(${map.periodCntMap.before}건<span id="myBefore" style="color:#ffff99;"></span>)
					<div style="margin-left:10px; border-left:10px solid green; height:10px; display:inline;"></div>
					진행중(${map.periodCntMap.doing}건<span id="myDoing" style="color:#ffff99;"></span>)
					<div style="margin-left:10px; border-left:10px solid red; height:10px; display:inline;"></div>
					기한경과(${map.periodCntMap.lapse}건<span id="myLapse" style="color:#ffff99;"></span>)
					<div style="margin-left:10px; border-left:10px solid gray; height:10px; display:inline;"></div>
					완료(${map.periodCntMap.complete}건<span id="myComplete" style="color:#ffff99;"></span>)
				</th>
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
				<th>제목</th>
				<th>담당</th>
				<th>파일</th>
				<th>댓글</th>
				<th>시작일</th>
				<th>마감일</th>
				<th class="seperatorLine">중요도</th>
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
				<td colspan="9">등록된 프로젝트가 없습니다.</td>
			</c:if>
			<jsp:include page="doListLine.jsp"/> <!-- 여러번 활용하기 위해 할일 리스트는 다른 페이지로 뺏음 -->
		</tbody>
	</table>
</div>

<div class="modal fade" id="modalElementInfo" role="dialog"></div>

<div id="folderRcm" style="padding:0px;">
	<table>
		<tr>
			<th class="rcmSubject"></th>
		</tr>
		<tr class="trLine">
			<td class="rcm" id="addFolderRcm" onclick="addDownElement()">하위요소추가</td>
		</tr>
		<tr class="trLine">
			<td class="rcm" id="modalFolderRcm">조회/수정</td>
		</tr>
		<tr class="trLine">
			<td class="rcm" id="deleteRcm">삭제</td>
		</tr>
	</table>
</div>


<div id="taskRcm" style="padding:0px;">
	<table>
		<tr>
			<th class="rcmSubject"></th>
		</tr>
		<tr class="trLine">
			<td class="rcm" id="statusRcm">완료처리</td>
		</tr>
		<tr class="trLine">
			<td class="rcm" id="modalTaskRcm">조회/수정</td>
		</tr>
		<tr class="trLine">
			<td class="rcm" id="deleteRcm">삭제</td>
		</tr>
	</table>
</div>














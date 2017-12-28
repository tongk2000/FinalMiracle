<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>요소 추가</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<%-- <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" /> --%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">

<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/jqueryuijs/jquery-ui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery.form.min.js"></script> <!-- 파일까지 업로드 가능한 jquery form 플러그인 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>

<style type="text/css">
	#teamwonList{
		float:left;
		z-index:1000;
		position:absolute;
		border:1.5px solid #cce6ff;
	}
	
	.pointer{
		cursor:pointer !important;
	}
	.pointerOver{
		color:navy;
	}
	.selectLine, .selectTeamwon {
		color:#4882ab !important;
		background-color:white !important;
	}
	th, td {
		border:2px solid #cce6ff;
		height:27px;
		padding-left:5px;
		padding-right:5px;
	}
	td:not(.selectTeamwon), input, select, button {
		color:white;
		background-color:#4882ab;
	}
	input:not(.addFileInput) {
		width:100%;
		border:none;
	}
	select {
		border:none;
	}
	
</style>

<script type="text/javascript">
 	$(document).ready(function(){
 		// datePicker 설정
 		var $opener = $(".selectedLine", opener.document);
 		
		var startDate = $opener.find(".fullStartDate").val();
		var lastDate = $opener.find(".fullLastDate").val();
		$("#startDate").val(startDate); // 상위요소의 시작일자를 미리 대입해줌
		$("#lastDate").val(lastDate); // 상위요소의 마감일자를 미리 대입해줌
		
		// 데이트피커 옵션 설정
		$("#startDate, #lastDate").datepicker({
			dateFormat: 'yy-mm-dd',
			minDate:new Date(startDate),
			maxDate:new Date(lastDate),
			dayNames:['월','화','수','목','금','토','일'],
			dayNamesMin:['월','화','수','목','금','토','일'],
			monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNamesShort:['1','2','3','4','5','6','7','8','9','10','11','12']
		}); // end of $("#startDate, #lastDate").datepicker({ ---------------------------------------------------------
			
		// 시작일이 마감일보다 크지 않도록 하기
		$("#startDate").change(function(){
			var startDate = $("#startDate").val();
			var lastDate = $("#lastDate").val();
			if(startDate > lastDate) {
				$("#lastDate").val(startDate);
			}
		}); // end of $("#startDate").change(function() ------------------------------------------------------------------------
		$("#lastDate").change(function(){
			var startDate = $("#startDate").val();
			var lastDate = $("#lastDate").val();
			if(startDate > lastDate) {
				$("#startDate").val(lastDate);
			}
		}); // end of $("#lastDate").change(function() -----------------------------------------------------------------------
 		
		// line 클래스 마우스 오버시 백그라운드칼라로 옅은 회색 주기
		$("tr").mouseover(function(){
			$(this).find("*:not(.selectTeamwon)").addClass("selectLine");
		}); // end of $(document).on("mouseover", "tr:has(td)", function() ------------------------------------------------------------------
		$("tr").mouseout(function(){
			$(this).find("*:not(.selectTeamwon)").removeClass("selectLine");
		}); // end of $(document).on("mouseout", "tr:has(td)", function() ------------------------------------------------------------------
		
		// pointer 클래스 마우스 오버시 css 바꿔주기
		$(document).on("mouseover", ".pointer", function(){
			$(this).addClass("pointerOver");
		}); // end of $(document).on("mouseover", ".pointer", function() ------------------------------------------------------------------
		$(document).on("mouseout", ".pointer", function(){
			$(this).removeClass("pointerOver");
		}); // end of $(document).on("mouseout", ".pointer", function() ------------------------------------------------------------------
	
		// 담당 추가 버튼을 누르면 팀원 표시창 출력해주기
		$("#btn_add").click(function(e){
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
							var idx = $("#"+entry.idx).val();
							if(entry.idx != idx) { // 이미 선택했던 팀원이 아니라면
								html += "<tr><td class='selectTeamwon pointer' style='border:1px solid #cce6ff;'>"+entry.userid
								html += "<input type='hidden' id='id"+entry.userid+"' value='"+entry.idx+"'></td></tr>";
								cnt++;
							}
						});
						html += "</table></div>";
						
						if(cnt == 0) { // 읽어온 데이터가 없거나, 이미 모든 팀원을 선택했다면
							html = "<div id='teamwonList' style='color:white; background-color:#4882ab;'>추가할 수 있는 팀원이 없습니다</div>"
						}
						
						$("#addTeamwon").append(html);
						
						$("#btn_add").text("추가▼");
						var left = $("#btn_add").offset().left;
						var top = $("#btn_add").offset().top;
						top = top + ($("#btn_add").height());
						$("#teamwonList").css({"left":left, "top":top}); // 팀원 표시창의 절대 위치를 넣어줌
						
					}, error:function(){
						alert("알 수 없는 오류입니다.\n관리자에게 문의하세요.");
					}
				});
			} else { // 팀원 표시창이 떠 있다면
				$("#btn_add").text("추가▷");
				$("#teamwonList").remove();
			} // end of 외부 if ~ else --------------------------------------------------------------------------------------------------
		}); // end of $("#btn_add").click(function() -----------------------------------------------------------------------------------
		
		// 팀원 표시창에서 특정 아이디 클릭시 담당자 리스트에 추가해주고 팀원 표시창에서는 빼기
		$(document).on("click", ".selectTeamwon", function(){
			var userid = $(this).text();
			var idx = $("#id"+userid).val();
			var html = "<div style='display:inline-block;' class='mola pointer'>"+userid+"&nbsp;"
					 + "<input type='hidden' name='teamwonIdx' id='"+idx+"' value='"+idx+"'/>"			
					 + "</div>";
			$("#selectedTeamwon").append(html);
			
			$(this).remove();
			if( !($("#teamwonList").find("td").hasClass("selectTeamwon")) ) { // 팀원표시창에 남은 팀원이 없다면
				$("#teamwonList").remove();
				$("#btn_add").text("추가▷");
			}
		}); // end of $(document).on("click", ".selectTeamwon", function() ----------------------------------------------------------------
		
		// 마우스 클릭 이벤트 있으면 일단 팀원 표시창 없애주기
		$(document).on("mousedown", function(e){
			var bool1 = $(e.target).hasClass("selectTeamwon");
			var bool2 = $(e.target).attr("id") == "btn_add";
			if(!bool1 && !bool2) { // 클릭 대상이 팀원 선택창이나 추가 버튼이 아니라면
				$("#teamwonList").remove();
				$("#btn_add").text("추가▷");
			}
		}); // end of $(document).mousedown(function() ------------------------------------------------------
		
		// esc 누르면 팀원 표시창 없애주기
		$(document).on("keydown", function(e){
			if(e.keyCode == 27) {
				$("#teamwonList").remove();
				$("#btn_add").text("추가▷");
			}
		}); // end of $(document).on("keydown", function(e) ----------------------------------------------------------------------
		
		// 이미 선택했던 팀원을 다시 클릭하면 삭제하기(단 한명은 무조건 있어야함)
		$(document).on("click", ".mola", function(){
			var userid = $(this).text().trim();
			var cnt = 0;
			$(".mola").each(function(){
				cnt++;
			});
			if(cnt > 1) { // 담당자가 둘 이상이라면
				$(this).remove();
			} else { // 담당자가 하나라면
				alert("담당자는 최소 1명 이상이여야 하므로\n"+userid+"님을 제외하실 수 없습니다.");
			}
		}); // end of $(document).on("click", ".mola", function() -------------------------------------------------------------------------
		
		// 엔터키 누르면 정보 수정하도록 하기
		$(document).on("keydown", function(e){
			if(e.keyCode == "13") {
				addDownElement();
			}
		}); // end of $(document).on("keydown", function(e) ----------------------------------------------------------------------------------
	}); // end of $(document).ready(function() -----------------------------------------------------------------------------------------------
	
	function addDownElement() {
		if( $("#popupSubject").val().trim() == "") {
			alert("제목은 필수 입력사항입니다.");
			$("#popupSubject").focus();
			return false();
		}
		
		var frm = document.addDownElementFrm;
		frm.action = "do_addDownElementEnd.mr";
		frm.submit();
	} // end of function addDownElement() ---------------------------------------------------------------------------------------------------
	
	function cancel() {
		var bool = confirm("정말로 창을 닫으시겠습니까?");
		if(bool) {
			window.close();
		} 
	} // end of function cancel() ------------------------------------------------------------------------------------------------------------
</script>
<body style="background-color:#4882ab;">
	<div style="width:100%; height:100%; padding:10px;">
		<form name="addDownElementFrm" id="modalInfoFrm" enctype="multipart/form-data" method="post">
			<table style="width:100%;">
				<tr style="width:100%;">
					<c:if test="${upIdx == 0}">
						<td class="firstTd" colspan="2">최상위요소 작성</td>
					</c:if>
					<c:if test="${upIdx != 0}">
						<td class="firstTd" style="width:70px;">상위요소</td> <td>${map.subject}</td>
					</c:if>
				</tr>
				<tr>
					<td class="firstTd">요소</td>
					<td>
						<select name="category" class="pointer">
							<option value="1" selected>폴더</option>
							<option value="2">할일</option>
						</select>
					</td>
				</tr>
				<tr>
					<td class="firstTd">만든사람</td> <td>${sessionScope.loginUser.userid}</td>
				</tr>
				<tr>
					<td class="firstTd">요소제목</td> <td><input type="text" name="subject" id="popupSubject" class="pointer"/></td>
				</tr>
				<tr>
					<td class="firstTd">요소개요</td> <td><input type="text" name="content" class="pointer"/></td>
				</tr>
				<tr>
					<td class="firstTd">담당추가</td>
					<td id="addTeamwon">
						<div style="float:left; width:50px;" id="btn_add" class="pointer">추가▷</div>
						<div style="float:left; width:250px;" id="selectedTeamwon">
							<div style='display:inline-block;' class='mola pointer'>${sessionScope.loginUser.userid}&nbsp; <!-- 일단 만든사람을 담당자 리스트에 올림 -->
								<input type='hidden' name='teamwonIdx' id='${sessionScope.teamInfo.teamwon_idx}' value='${sessionScope.teamInfo.teamwon_idx}'/>			
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="firstTd">시작일</td> 
					<td>
						<input type="text" readonly id="startDate" name="startDate" class="pointer"/>
					</td>
				</tr>
				<tr>
					<td class="firstTd">마감일</td>
					<td>
						<input type="text" readonly id="lastDate" name="lastDate" class="pointer"/>
					</td>
				</tr>
				<tr>
					<td class="firstTd">중요도</td> 
					<td>
						<select id="example" name="importance" class="pointer">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
						</select>
					</td>
				</tr>
				<jsp:include page="../modal/includePage/modalFileAddList.jsp"/> <!-- 파일 추가도 공통이라 따로 뺌 -->
			</table>
			
			<p id="hiddenInfo">
				<input type="hidden" name="fk_folder_idx" value="${upIdx}"/>
				<input type="hidden" name="term" value="${term}"/>
				<input type="hidden" name="page" value="${page}"/>
				<c:if test="${upIdx == 0}">
					<input type="hidden" name="groupNo" value="${map.groupNo}"/>
					<input type="hidden" name="depth" value="0"/>
				</c:if>
				<c:if test="${upIdx != 0}">
					<input type="hidden" name="groupNo" value="${map.groupNo}"/>
					<input type="hidden" name="depth" value="${map.depth+1}"/>
				</c:if>
			</p>
		</form>
		<div align="right">
			<button onclick="addDownElement();">추가</button> <!-- form 안에 버튼이 들어가 있으면 오류 남발함. -->
			<button onclick="cancel();">취소</button>
		</div>
	</div>
</body>
</html>
















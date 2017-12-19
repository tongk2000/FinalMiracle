<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>요소 추가</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />

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
		position: absolute;
		background-color:white;
		border:1px solid black;
	}
	
	.pointer{
		cursor:pointer;
	}
	.pointerOver{
		color:blue;
	}
	.selectLine {
		background-color:lightgray;
	}
	
</style>

<script type="text/javascript">
 	$(document).ready(function(){
 		// datePicker 설정
 		var $opener = $(".selectedLine", opener.document);
 		
		var startDate = $opener.find(".startDateTd").text();
		var lastDate = $opener.find(".lastDateTd").text();
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
		
		// 이미 선택했던 팀원을 다시 클릭하면 삭제하기
		$(document).on("click", ".mola", function(){
			var userid = $(this).text();
			var bool = confirm("선택하신 "+userid+"님을 정말 제외하시겠습니까?");
			if(bool) {
				$(this).remove();
			}
		}); // end of $(document).on("click", ".mola", function() -------------------------------------------------------------------------
		
	}); // end of $(document).ready(function() -----------------------------------------------------------------------------------------------
	
	function addDownElement() {
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
<body>
	<form name="addDownElementFrm" id="modalInfoFrm" enctype="multipart/form-data" method="post">
		<table style="width:700px;">
			<tr style="width:700px;">
				<c:if test="${upIdx == 0}">
					<td colspan="2" style="width:700px;">최상위요소 작성</td>
				</c:if>
				<c:if test="${upIdx != 0}">
					<td style="width:150px;">상위요소</td> <td style="width:550px;">${map.subject}</td>
				</c:if>
			</tr>
			<tr>
				<td>요소</td>
				<td>
					<select name="category">
						<option value="1" selected>폴더</option>
						<option value="2">할일</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>만든사람</td> <td>${sessionScope.loginUser.userid}</td>
			</tr>
			<tr>
				<td>요소제목</td> <td><input type="text" name="subject"/></td>
			</tr>
			<tr>
				<td>요소개요</td> <td><input type="text" name="content"/></td>
			</tr>
			<tr>
				<td>담당추가</td>
				<td id="addTeamwon">
					<div style="float:left; width:50px;" id="btn_add" class="pointer">추가▷</div>
					<div style="float:left; width:250px;" id="selectedTeamwon"></div>
				</td>
			</tr>
			<tr>
				<td>시작일</td> 
				<td>
					<input type="text" readonly id="startDate" name="startDate"/>
				</td>
			</tr>
			<tr>
				<td>마감일</td>
				<td>
					<input type="text" readonly id="lastDate" name="lastDate"/>
				</td>
			</tr>
			<tr>
				<td>중요도</td> 
				<td>
					<select id="example" name="importance">
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
	
	<button onclick="addDownElement();">추가</button> <!-- form 안에 버튼이 들어가 있으면 오류 남발함. -->
	<button onclick="cancel();">취소</button>
</body>
</html>
















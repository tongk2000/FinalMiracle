<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>하위 폴더 추가</title>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />

<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/jqueryuijs/jquery-ui.js"></script>

<style type="text/css">
	#teamwonList{
		float:left;
		z-index:1000;
		position: absolute;
		background-color:white;
		border:1px solid black;
	}
</style>

<script type="text/javascript">
 	$(document).ready(function(){
		
		// 담당 추가 버튼을 누르면 팀원 표시창 출력해주기
		$("#btn_add").click(function(e){
			if($(e.target).hasClass("selectTeamwon")) { // 만약 클릭한것이 팀원 표시창의 팀원이라면
				$(".selectTeamwon").trigger("click");
			}
			var bool = $("#teamwonList").is(":visible");
			if(!bool) { // 팀원 표시창이 떠 있지 않다면
				var frm = {"fk_team_idx":$("#fk_team_idx").val()};
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
								html += "<tr><td class='selectTeamwon' style='border:1px solid black;'>"+entry.userid
								html += "<input type='hidden' id='id"+entry.userid+"' value='"+entry.idx+"'></td></tr>";
								cnt++;
							}
						});
						html += "</table></div>";
						
						if(cnt == 0) { // 읽어온 데이터가 없거나, 이미 모든 팀원을 선택했다면
							html = "<div id='teamwonList'>추가할 수 있는 팀원이 없습니다</div>"
						}
						
						$("#addTeamwon").append(html);
						
						$("#btn_add").text("추가▶");
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
			var html = "<div style='display:inline-block;' class='mola'>"+userid+"&nbsp;"
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
	
	function addDownFolder() {
		var frm = document.addDownFolderFrm;
		frm.method = "post";
		frm.action = "do_addDownFolderEnd.mr";
		frm.submit();
	} // end of function addDownFolder() ---------------------------------------------------------------------------------------------------
	
	function cancel() {
		var bool = confirm("정말로 창을 닫으시겠습니까?");
		if(bool) {
			window.close();
		} 
	} // end of function cancel() ------------------------------------------------------------------------------------------------------------
</script>

<form name="addDownFolderFrm">
	<table style="width:400px;">
		<tr style="width:400px;">
			<td style="width:100px;">상위폴더</td> <td style="width:300px;">${map.subject}</td>
		</tr>
		<tr>
			<td>만든사람</td> <td>${sessionScope.loginUser.userid}</td>
		</tr>
		<tr>
			<td>폴더제목</td> <td><input type="text" name="subject"/></td>
		</tr>
		<tr>
			<td>폴더개요</td> <td><input type="text" name="content"/></td>
		</tr>
		<tr>
			<td>담당추가</td>
			<td id="addTeamwon">
				<div style="float:left; width:50px;" id="btn_add">추가▷</div>
				<div style="float:left; width:250px;" id="selectedTeamwon"></div>
			</td>
		</tr>
		<tr>
			<td>시작일</td> <td><input type="text" name="startdate"/></td>
		</tr>
		<tr>
			<td>마감일</td> <td><input type="text" name="lastdate"/></td>
		</tr>
		<tr>
			<td>중요도</td> <td><input type="text" name="importance"/></td>
		</tr>
	</table>
	
	<p id="hiddenInfo">
		<input type="hidden" name="fk_folder_idx" value="${map.upIdx}"/>
		<input type="hidden" name="groupNo" value="${map.groupNo}"/>
		<input type="hidden" name="depth" value="${map.depth+1}"/>
		<input type="hidden" name="fk_team_idx" id="fk_team_idx" value="${map.fk_team_idx}"/>
	</p>
</form>

<button onclick="addDownFolder();">추가</button> <!-- form 안에 버튼이 들어가 있으면 오류 남발함. -->
<button onclick="cancel();">취소</button>



















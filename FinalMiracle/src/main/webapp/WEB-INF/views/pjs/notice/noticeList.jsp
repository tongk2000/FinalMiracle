<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<style type="text/css">

    #displayList {
    	position:absolute;
    	background-color:white; 
    	width:187px; 
    	margin-left: 28px; 
    	border-top: 0px; 
    	border: solid gray 3px;
    }
    #adjust {
    	position:absolute;
    }
    
   #custom-search-input {
	padding: 3px;
	border: solid 1px #E4E4E4;
	border-radius: 6px;
	background-color: #fff;
}

#custom-search-input input {
	border: 0;
	box-shadow: none;
}

#custom-search-input button {
	margin: 2px 0 0 0;
	background: none;
	box-shadow: none;
	border: 0;
	color: #666666;
	padding: 0 8px 0 10px;
	border-left: solid 1px #ccc;
}

#custom-search-input button:hover {
	border: 0;
	box-shadow: none;
	border-left: solid 1px #ccc;
}

#custom-search-input .glyphicon-search {
	font-size: 23px;
}
.modal.modal-center {
  text-align: center;
}
@media screen and (min-width: 400px) { 
  .modal.modal-center:before {
    display: inline-block;
    vertical-align: middle;
    content: " ";
    height: 100%;
  }
}
.modal-dialog.modal-center {
  display: inline-block;
  text-align: left;
  vertical-align: middle; 
}	
</style>
<title>Notice 게시판 입니다!</title>
</head>
<body>
	<c:set var="team" value="${userTeam}"></c:set>
	<%-- <div align="center" >
		<h2>공지사항 게시판</h2>
			
			<table style="width:90%;" class="table">
				<thead>
					<tr>
						<th>번호</th>		<!-- 번호 -->
						<th>아이디</th>	<!-- 아이디 -->
						<th>제목</th>		<!-- 제목 -->
						<th>첨부파일</th>
						<th>글쓴 시간</th>	<!-- 글쓴 시간 -->
						<th>조회수</th>	<!-- 조회수-->
						<c:if test="${team.status == 2}" >
							<th></th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:if test="${empty list}">
						<tr>
							<td colspan="6">데이터가 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${not empty list}">
						<c:forEach var="nt" items="${list}" varStatus="status">
							<tr class="line">
								<td width="5%" style="text-align:center;"><input type="hidden" value="${nt.n_idx}"/><input type="checkbox"></td><!-- 번호 -->
								<td width="15%" style="padding-left:10px;">
									<a onClick="goUserInfo('${nt.fk_userid}');"> <!-- 유저아이디 -->
										<img src="<%= request.getContextPath()%>/resources/images/${nt.img}" class="imgs" /> 
										<span class="userid">${nt.fk_userid}</span>
									</a>
								</td>	
							<c:if test="${nt.depth == 0}">
									<td width="35%" onClick="goView('${nt.n_idx}','${nt.fk_userid}', '${nt.t_idx}')"><span style="color:red; margin-left:10px;">${nt.subject} <span style="color:blue">&nbsp;&nbsp;&nbsp;[댓글 수 : ${nt.count}]</span></span></td><!-- 제목 -->
							</c:if>
							<c:if test="${nt.depth > 0}">
									<td width="35%" onClick="goView('${nt.n_idx}','${nt.fk_userid}','${nt.t_idx}')" style="margin-left:10px; padding-left:${nt.depth*10}px; color:black; font-weight:bold; ">└ [답글] ${nt.subject} <span style="color:blue">&nbsp;&nbsp;&nbsp;[댓글 수 : ${nt.count}]</span></td><!-- 제목 -->
							</c:if>
							<c:if test="${nt.file > 0}">
								    <td width="5%" style="text-align:center;"><img src="<%=request.getContextPath() %>/resources/images/disk.gif" ></td>
							</c:if>	
							<c:if test="${nt.file == 0}">
								    <td width="5%" style="text-align:center;">X</td>
							</c:if>	
								<td width="25%" style="text-align:center;">${nt.regday}</td><!-- 날짜 -->
								<td width="7%" style="text-align:center;">${nt.readcount}</td><!-- 조회수 -->
							<c:if test="${team.status == 2}" >
								<td width="8%" style="text-align:center;"><button type="button" onClick="goEdit('${nt.n_idx}','${nt.t_idx}');">글수정</button></td>
							</c:if>	
							</tr>
							<input type="hidden" id="nidx"name="aidx" value="${nt.n_idx}"/>		
						</c:forEach>
					</c:if>
				</tbody>
			</table>
		<div style="float:right; border:1px dotted red">
			<br/>
			<c:if test="${team.status == 2}" >
				<button type="button" onClick="goWrite();">글쓰기</button>
				<button type="button" id="del" >삭제</button>
			</c:if>
		</div>
		<br/><br/>
		<div style="margin: 0 auto;">
			${pagebar}
		</div>
		<br/><br/>
		<form name="frm">
			<select id="searchType" name="searchType" style="font-size:12pt; ">
				<option value="fk_userid">아이디</option>
				<option value="subject">제목</option>
			</select>
			<input type="text" id="searchString" name="searchString" />
			<button type="button" id="btnClick" onClick="goSearch();">검색</button><br/>
		</form>
		
	    <div style="z-index:2000;">
				<div id="displayList" style="background-color:white; width:176px; margin-left: 28px; border-top: 0px; border: solid gray 3px;"></div>
		</div> 
	 --%>
	 	<div align="center" >
			<div style="display:block; width:90%; padding-top:30px;" align="center"> 
				<div class="panel panel-primary">
					<div class="panel-heading"></div>
					<div style=" border:3px solid #337ab7; "> <!-- width:500px; -->
					 <span style="color:red"> 공지사항 글 </span><br/>
					 <span style="color:skyblue; padding-left:130px;">팀 프로젝트 중요사항 입니다.</span><div style="float:right; padding-right:30px;">총 게시물  :  ${totalNum}</div>
					</div>
					<table class="table table-hover" id="dev-table">
						<thead>
							<tr>
								<th style="text-align:center; font-family:verdana;">번호</th>		<!-- 번호 -->
								<th style="text-align:center; font-family:verdana;">아이디</th>	<!-- 아이디 -->
								<th style="text-align:center; font-family:verdana;">제목</th>		<!-- 제목 -->
								<th style="text-align:center; font-family:verdana;">첨부파일</th>
								<th style="text-align:center; font-family:verdana;">글쓴 시간</th>	<!-- 글쓴 시간 -->
								<th style="text-align:center; font-family:verdana;">조회수</th>	<!-- 조회수-->
								<c:if test="${team.status == 2}">
									<th></th>
								</c:if>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty list}">
								<tr>
									<td colspan="6">데이터가 없습니다.</td>
								</tr>
							</c:if>
							<c:if test="${not empty list}">
								<c:forEach var="nt" items="${list}" varStatus="status">
									<tr class="line">
										<td width="5%" style="text-align:center; font-family:verdana;"><input type="hidden" value="${nt.n_idx}"/><input type="checkbox"></td><!-- 번호 -->
										<td width="15%" style="text-align:center; font-family:verdana;">
											<a onClick="goUserInfo('${nt.fk_userid}');"> <!-- 유저아이디 -->
												<img src="<%= request.getContextPath()%>/resources/images/${nt.img}" class="imgs"  style="width:25px; height:30px;	"/> 
												<span class="userid">${nt.fk_userid}</span>
											</a>
										</td>
									<c:if test="${nt.depth == 0}">
											<td width="35%" onClick="goView('${nt.n_idx}','${nt.fk_userid}', '${nt.t_idx}')" style=" font-family:verdana;"><span style="color:black; margin-left:10px;">${nt.subject} <span style="color:blue">&nbsp;&nbsp;&nbsp;[댓글 수 : ${nt.count}]</span></span></td><!-- 제목 -->
									</c:if>
									<c:if test="${nt.depth > 0}">
											<td width="35%" onClick="goView('${nt.n_idx}','${nt.fk_userid}','${nt.t_idx}')" style="margin-left:10px; padding-left:${nt.depth*10}px; color:black; font-weight:bold;  font-family:verdana;">└ [답글] ${nt.subject} <span style="color:blue">&nbsp;&nbsp;&nbsp;[댓글 수 : ${nt.count}]</span></td><!-- 제목 -->
									</c:if>
									<c:if test="${nt.file > 0}">
										    <td width="5%" style="text-align:center; font-family:verdana;"><a class="btn btn-default"><span class="glyphicon glyphicon-floppy-disk" ></span></a></td>
									</c:if>	
									<c:if test="${nt.file == 0}">
										    <td width="8%" style="text-align:center; font-family:verdana;"></td>
									</c:if>	
										<td width="22%" style="text-align:center; font-family:verdana;">${nt.regday}</td><!-- 날짜 -->
										<td width="7%" style="text-align:center; font-family:verdana; color:blue;">${nt.readcount}</td><!-- 조회수 -->
									<c:if test="${team.status == 2}" >
										<td width="8%" style="text-align:center; font-family:verdana;"><button type="button" class="btn btn-default" onClick="goEdit('${nt.n_idx}','${nt.t_idx}');" style="height:30px;">수정	</button></td>
									</c:if>	
									</tr>
									<input type="hidden" id="nidx"name="aidx" value="${nt.n_idx}"/>		  
								</c:forEach>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>	
			<div id="adjust" style="border:0px dotted red;">
				<c:if test="${team.status == 2}" >
					<button type="button" onClick="goWrite();" class="btn btn-default">글쓰기</button>
					<button type="button" id="del" class="btn btn-default">삭제</button>
				</c:if>
			</div>
			<div style="margin: 0 auto;">
				${pagebar}
			</div>
			<br/>
			<!-- <form name="frm">
					<select id="searchType" name="searchType" style="font-size:12pt; ">
						<option value="fk_userid">아이디</option>
						<option value="subject">제목</option>
					</select>
					
					<input type="text" id="searchString" name="searchString" style="width:187px"/>
					<button class="btn btn-default" type="button" id="btnClick" onClick="goSearch();">검색</button><br/>
			</form> -->
			
	<form name="frm" align="center" style="border: 0px solid purple;">
		<div align="center" style="border: 0px solid lightgray;">
			<!-- 선택바 -->
			<div class="col-xs-2 nav-container"
				style="border: 0px solid lightgray; margin-left: 300px; margin-top:37px; padding-top: 5px;">
				<div class="form-group" style="float: right;">
					<select class="form-control nav" id="searchType" name="searchType">
						<option value="fk_userid">아이디</option>
						<option value="subject">제목</option>
					</select>
				</div>
			</div>
			<!-- <select id="searchType" name="searchType" style="font-size:12pt;">
				<option value="fk_userid">아이디</option>
				<option value="subject">제목</option>
			</select> -->
			<!-- <input type="text" id="searchString" name="searchString" style="width:187px;"/>
			<button type="button" id="btnClick" onClick="goSearch();">검색</button> -->
			<div style="display: block; margin-top: -40px; border:0px solid red;" align="center">
				<div id="displayList"></div>
			</div>
			<!-- 검색바 -->
			<div class="container">
				<div class="row"
					style="border: 0px solid red; height: 30px; padding-right: 420px; display:inline;">
					<div class="col-sm-4" style="border: 0px solid green;">
						<div id="custom-search-input"
							style="border: 1px solid lightgray; margin-left: -15px;">
							<div class="input-group col-sm-12" style="border: 1px solid lightgray;">
								<input type="text" class="form-control input-xs" id="searchString1" name="searchString" /> <span
									class="input-group-btn">
									<button class="btn btn-info btn-xs" type="button" id="btnClick"
										onClick="goSearch();">
										<i class="glyphicon glyphicon-search"></i>
									</button>
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
			
		    <!-- <div >
				<div id="displayList" ></div>
			</div> -->
        </div>    
	<form name="view">
		<input type="hidden" name="idx" />
		<input type="hidden" name="userid" />
		<input type="hidden" name="teamidx" />
	</form>
	<form name="editView">
		<input type="hidden" name="idx" />
		<input type="hidden" name="teamidx" />
	</form>
	<form name="edit"><!-- 수정글쓰기 -->
		<input type="hidden" name="idx" />
		<input type="hidden" name="userid" />
		<input type="hidden" name="teamidx" />
	</form>
	<form name="write">
		<input type="hidden" name="idx" />
		<input type="hidden" name="userid" />
		<input type="hidden" name="teamNum" />
	</form>

	<script type="text/javascript">
		$(document).ready(function(){
			keep();
			$("#displayList").hide();
			var left_table = $("#dev-table").position().left-50;  // 테이블 기준 , 글쓰기/삭제버튼 위치조정
			var top_table = $("#dev-table").position().top;
			$("#adjust").css({"right":left_table+"px", "bottom":top_table+"px"}); 
			 
			/* var left_dev = $("#dev-table").position().left+350;   // 테이블기준  검색조건 select 태그
			var bottom_dev = $("#dev-table").position().bottom;
			$("#searchType").css({"left":left_dev+"px", "bottom":bottom_dev+"px"});
			
			var right_st = $("#searchType").position().right+10;   // 
			var top_st = $("#searchType").position().top;
			$("#searchbar").css({"left":right_st+"px", "top":top_st+"px"});
			 */

			$("#userid").click(function(){
				var frm = document.frm;
				frm.searchType.value = "fk_userid";
				//alert("유저 아이디 오냐?");
			});
			$("#subject").click(function(){
				var frm = document.frm;
				frm.searchType.value = "subject";
				//alert("주제 오냐?");	
			});
			
			$("#dev-table tr:has(td)").click(function(e){ // tr중에서 td를 가지고 있는 tr
				var bool = $(e.target).parent().hasClass("selectLine"); 
				if(bool) {
					$(e.target).parent().removeClass("selectLine");
				}
				else {
					$(e.target).parent().addClass("selectLine");
				}
			});
			$("#del").click(function(){
				var cnt=0;
				var idx = new Array();
				$(".selectLine").each(function(){
					idx[cnt] = $(this).find("input").val();
					cnt++;
				});
				location.href="<%=request.getContextPath()%>/noticeDel.mr?idx="+idx;
			});
			
			$("#searchString").keyup(function(){
				if($("#searchType").val()==null||$("#searchType").val()=="") {
					$("#searchType").val("fk_userid");
				}
				var data_form = {"searchString":$("#searchString").val(), "searchType":$("#searchType").val(), "t_idx":${team.teamNum}};
				$.ajax({
					url:"noticeListJSON.mr",
					type:"get",
					data:data_form,
					dataType:"JSON",
					success: function(data) {
						var resultHTML ="";
						if(data.length > 0) { // 검색된 데이터가 있는 경우라면
							$.each(data, function(entryIndex, entry){
								var wordstr = entry.search;
								var index = wordstr.toLowerCase().indexOf( $("#searchString").val().toLowerCase() );
								var len = $("#searchString").val().length;
								var result = "";
								result = "<span class='first' style='color:blue;'>" +wordstr.substr(0, index)+ "</span>" + "<span class='second' style='color:red; font-weight:bold;'>" +wordstr.substr(index, len)+ "</span>" + "<span class='third' style='color:blue;'>" +wordstr.substr(index+len, wordstr.length - (index+len) )+ "</span>";  
								resultHTML += "<span style='cursor:pointer;'>"+ result +"</span><br/>"; 
							});
						
							var left = $("#searchString1").position().left; // 검색창 기준
							var top = $("#searchString1").position().top;
							top = top + ($("#searchString1").height());
							$("#displayList").css({"left":left+"px", "top":top+"px"});
							$("#displayList").show();
							$("#displayList").html(resultHTML);
							
						}
						else {
							// 검색된 데이터가 존재하지 않는 경우라면
							$("#displayList").hide();
						} // end of if ~ else ----------------
					}, // end of success: function()----------
					error: function(){
					}
				}); // end of $.ajax()------------------------
			}); // end of keyup(function(){})-----------------
			// 페이지 전체에서 esc 키를 누르면 모달창을 닫기
			$(document).on("keydown", function(){
			   var modalFlag = $('#userinfo').is(':visible');
			   if (event.keyCode == 27 && modalFlag) {
			      $('#userinfo').modal('hide');
			   }
			}); // end of $(document).on("keydown", function()
			// 모달창에서 x 나 취소를 누르면 모달창을 닫기
			$(document).on("click", ".modalClose", function(){         
			 $('#userinfo').modal('hide');
			}); // end of $(".modalClose").click(function() ------------------------------------------------------------------------------------------------------
			$(".line").hover(function(){ 
				$(this).addClass("grayColor");
			},function(){
				$(this).removeClass("grayColor");
			}); // end of $(".line").hover
			$("#displayList").click(function(event){
				var word = "";
				var $target = $(event.target);
				if($target.is(".first")) {
					word = $target.text() + $target.next().text() + $target.next().next().text();
				}
				else if($target.is(".second")) {
					word = $target.prev().text() + $target.text() + $target.next().text();
				}
				else if($target.is(".third")) {
					word = $target.prev().prev().text() + $target.prev().text() + $target.text();
				}
				$("#searchString").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
				$("#displayList").hide();
			});
			
		}); // $(document).ready
		function keep() {
			<c:if test='${searchType!=null&&searchType!=""}'>
				$("#searchType").val("${searchType}");
			</c:if>
			<c:if test='${searchString!=null&&searchString!=""}'>
				$("#searchString").val("${searchString}");
			</c:if>
		}
		function goSearch() {
			var frm = document.frm;
			frm.action="<%=request.getContextPath()%>/noticeList.mr";
			frm.method="get";
			frm.submit();
		}
		/* function goUserInfo(id) {
			var userid = {"userid":id};
			$.ajax({
				url:"noticeUserInfo.mr",
				type:"get",
				data:userid,
				dataType:"html",
				success: function(data) {
					if(data.length>0) {
						$("#userinfo").html(data);
						$("#userinfo").modal(); // 이게 뭐였지????
					}
					else {
						//alert("ajax결과"+data);
					}
				},error : function() {
					//alert("실패!");
				}
			});
		} */
		function goUserInfo(id) {
			var form_data = { "userInfo" : id };
			$.ajax({
				url: "freeUserInfo.mr",
				type: "GET",
				data: form_data,  // url 요청페이지로 보내는 ajax 요청 데이터
				dataType: "JSON", // ajax 요청에 의해 url 요청페이지로 부터 리턴받는 데이터타입. xml, json, html, text 가 있음.
				success: function(data) {				
					var html = "";
					
					var imgPath = data.infoImg;
					html += "<div style='font-family: verdana; font-size: 10pt; border: 2px dotted #E8E8E8; border-radius: 20px; background-color: #F0F0F0; padding: 5px;'><div style='float: right;'><img src='<%= request.getContextPath() %>/resources/files/" + imgPath + "' style='width: 80px; height: 80px; border-radius: 50px;' /></div>" + "<br/>"
						 +  "<span style='font-weight: bold;'>ID : </span>"+ data.infoUserid + "<br/>"
						 +  "<span style='font-weight: bold;'>성명 : </span>"+ data.infoName + "<br/><br/>"
						 +  "<span style='font-weight: bold;'>핸드폰 : </span>" +data.infoHp1 + "-" +data.infoHp2+"-"+data.infoHp3 +"<br/>"
						 +  "<span style='font-weight: bold;'>생년월일 : </span>" +data.infoBirth1 + " / " + data.infoBirth2 + " / " + data.infoBirth3 + "<br/><br/>"
						 +  "<span style='font-weight: bold;'>주소 : </span>" + data.infoAddr1 + " " + data.infoAddr2 + "</span><br/>"
						 +  "<span style='font-weight: bold;'>이메일 : </span>" + data.infoEmail + "<br/><br/>"
						 +  "<span style='font-weight: bold;'>소개 : </span>" + data.infoProfile +"</div>" ;
					
					$(".modal-body").html(html);
					$("#userinfo").modal();
				}, // end of success: function()----------
				error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			}); // end of $.ajax()------------------------
		}
		function goView(n_idx, n_userid, n_t_idx) {
			var frm = document.view;
			alert(n_idx);
			frm.idx.value = n_idx;
			frm.userid.value = n_userid; 
			frm.teamidx.value = n_t_idx;
			frm.action="<%=request.getContextPath()%>/noticeView.mr";
			frm.method="get";
			frm.submit();
		}
		function goEdit(idx, t_idx) { /* 글 수정하기 */
			var frm = document.editView;
			//alert(idx, t_idx);
			frm.idx.value = idx;
			frm.teamidx.value = t_idx;
			frm.action="<%=request.getContextPath()%>/noticeViewEdit.mr";
			frm.method="get";
			frm.submit();
		}
		function goWrite() {
			<c:if test="${team.teamNum != null&&team.teamNum!=''}" >
				var t_teamNum = "${team.teamNum}";
			//	alert(t_teamNum);
			</c:if>
			<c:if test="${team.userid != null&&team.userid!=''}">
				var m_userid = "${team.userid}";
			</c:if>
			var frm = document.write;
			frm.teamNum.value= t_teamNum;
			frm.idx.value = $("#nidx").val();
			frm.userid.value=m_userid;
			frm.action="<%=request.getContextPath()%>/noticeWrite.mr";
			frm.method="post";
			frm.submit();
		}
	</script>
	
	<!-- <div class="modal fade" id="userinfo" role="dialog"></div> -->
	<div class="modal fade modal-center" id="userinfo" role="dialog">
	<div class="modal-dialog modal-sm modal-center">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">회원 상세 정보</h4>
			</div>
			<div class="modal-body">
			<p></p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
	
</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	table, th, td{
		border: solid gray 1px;
		text-align: center;
	}
	a{color: black;}	

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
			
		if(${not empty month && month != null && month != ""}){
			$("#month").val("${month}");
		}
		
		
	});
	
	
	function welcome() { //출근
		
		location.href="<%= request.getContextPath() %>/commutestart.mr";
		
	}
	
	function goodbye() { // 퇴근
		
		location.href="<%= request.getContextPath() %>/commuteend.mr";
		
	}
	
	function search() { // 월별보기
		var frm = document.monthFrm;
		frm.method = "get";
		frm.action = "<%= request.getContextPath() %>/commute.mr";
		frm.submit();
		
	}
	
	
	
</script>

<div style="width: 30%; height: 100%; float: left; display: inline; border: 1px solid black;">
	<div align="center" style="border: 1px solid black; width: 100%;">
		${sessionScope.loginUser.name}님의 출퇴근 내역
	</div>
	
	<div align="center" style="border: 1px solid blue; width: 100%;">	
		<c:forEach var="detail" items="${userTeamDetail}" varStatus="status">
			<c:if test="${detail.twstatus == 2}">
				<a id="teamMember${status.count}" href="commuteteam.mr?tidx=${detail.tidx}&teamname=${detail.teamname}">팀 ${detail.teamname}의 팀원 출퇴근 내역보기</a>
			</c:if>
		</c:forEach>
	</div>	
	
	<div align="center" style="border: 1px solid green; width: 100%; ">
	
		<form name="monthFrm" >
		월별보기
			<select id="month" name="month">
				<option value="">전체</option>
				<c:forEach begin="1" end="12" varStatus="status">
					<option value="${status.count}">${status.count}월</option>
				</c:forEach>
			</select>
			<button type="button" onclick="search()">검색</button>
		</form>
		<button id="start" name="start" onclick="welcome()">출근</button>
		<button id="end" name="end" onclick="goodbye()">톼근</button>
	</div>
	<div align="center" style="border: 1px solid teal; width: 100%; ">
		<table>
			<thead>
				<tr>
					<th>일자</th>
					<th>출근시간</th>
					<th>퇴근시간</th>
					<th>근무시간</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="map" items="${commuteList}">
					<tr>
						<td>${map.wt_date}</td>
						<td>${map.stime}</td>
						<td>${map.etime}</td>
						<td>${map.whour} ${map.wminute}</td>
						<c:if test="${map.wstatus == 0}">
							<td> </td>
						</c:if>
						<c:if test="${map.wstatus == 1}">
							<td>지각</td>
						</c:if>
						<c:if test="${map.wstatus == 2}">
							<td>조퇴</td>
						</c:if>
						<c:if test="${map.wstatus == 3}">
							<td>결근</td>
						</c:if>
						<c:if test="${map.wstatus == 4}">
							<td>지각,조퇴</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<div align="center" style="border: 1px solid aqua; width: 100%;">
		${pageBar}
	</div>

</div>

<%-- <div style="float: left; display: inline;">
	<table>
		<thead>
			<tr>
				<th>비고</th>
				<th>수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${statisticsList}">
				<tr>
					<c:if test="${list.wstatus == 0}">
						<td>정상</td>
					</c:if>
					<c:if test="${list.wstatus == 1}">
						<td>지각</td>
					</c:if>
					<c:if test="${list.wstatus == 2}">
						<td>조퇴</td>
					</c:if>
					<c:if test="${list.wstatus == 3}">
						<td>결근</td>
					</c:if>
					<c:if test="${list.wstatus == 4}">
						<td>지각,조퇴</td>
					</c:if>
					<c:if test="${list.wstatus == -1}">
						<td>현월 근무 일수</td>
					</c:if>
					
					<td>${list.cnt} 일</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div> --%>




<%-- <%@ page import="java.util.Calendar" %>
 

       <%
        String yyear = "2012"; //원하는 년도 세팅
        String mmonth = "5"; //원하는 월 세팅
        int year = 0, month = 0;
        year = Integer.parseInt(yyear); //int로 형변환
        month = Integer.parseInt(mmonth); //int로 형변환
       %>             
       
      <table border ='1'>
      <%
        Calendar cal = Calendar.getInstance(); //Calendar 객체 호출
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, month-1); //0월 ~11월 컴퓨터는 한달 빠르므로 -1을 해야 원하는 달을 얻을 수 있다.
        cal.set(Calendar.DATE, 1);
        int statOfDay = cal.get(Calendar.DAY_OF_WEEK); //1일이 어떤 요일

        int endOfDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH); //해당 월의 마지막 날짜
           out.print("<tr><td colspan='7' align= center>"+ year+"년 "+month+"월 </td></tr>");
           out.print("<tr><td>Sun</td><td>Mon</td><td>Tus</td><td>Wed</td><td>Thu</td><td>Fri</td><td>Sat</td></tr>");
           out.print("<tr>");
           for(int i=1;i< statOfDay;i++) { //해당 월의 1일의 요일값 만큼 공백 세팅
            out.print("<td>&nbsp;</td>");
           }
           
           for(int i=1;i<=endOfDay;i++) {
               if((statOfDay-2+i) %7 ==0) { //토요일 세팅
              out.print("<td><font color='red'>"+i+"</font></td>");
               } else if((statOfDay-1+i) %7 ==0){ //일요일 세팅
                   out.print("<td><font color='blue'>"+i+"</font></td>");
               } else {
                   out.print("<td>"+i+"</td>");  //그외 평일
               }
            if((statOfDay-1+i) %7 ==0) {
             out.print("</tr><tr>");   //1주일이 끝날때 마다 tr 태그 닫고 새로 시작
             }
            }
            out.print("</tr>");
      %>

      </table> --%>

<%-- <%@ page import="java.util.*" %>
<%
    Calendar cal = Calendar.getInstance();
    int year = request.getParameter("y") == null ? cal.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("y"));
    int month = request.getParameter("m") == null ? cal.get(Calendar.MONTH) : (Integer.parseInt(request.getParameter("m")) - 1);

    // 시작요일 확인
    // - Calendar MONTH는 0-11까지임
    cal.set(year, month, 1);
    int bgnWeek = cal.get(Calendar.DAY_OF_WEEK);

    // 다음/이전월 계산
    // - MONTH 계산시 표기월로 계산하기 때문에 +1을 한 상태에서 계산함
    int prevYear = year;
    int prevMonth = (month + 1) - 1;
    int nextYear = year;
    int nextMonth = (month  + 1) + 1;

    // 1월인 경우 이전년 12월로 지정
    if (prevMonth < 1) {
        prevYear--;
        prevMonth = 12;
    }

    // 12월인 경우 다음년 1월로 지정
    if (nextMonth > 12) {
        nextYear++;
        nextMonth = 1;
    }
%>
<table border="0" cellpadding="0" cellspacing="0">
<tr>
    <td align="center"><a href="./calendar.jsp?y=<%=prevYear%>&m=<%=prevMonth%>">◁</a> <%=year%>년 <%=month+1%>월 <a href="./calendar.jsp?y=<%=nextYear%>&m=<%=nextMonth%>">▷</a></td>
</tr>
<tr>
    <td>

        <table border="1">
        <tr>
            <td>일</td>
            <td>월</td>
            <td>화</td>
            <td>수</td>
            <td>목</td>
            <td>금</td>
            <td>토</td>
        </tr>
        <tr>
<%
    // 시작요일까지 이동
    for (int i=1; i<bgnWeek; i++) out.println("<td>&nbsp;</td>");

    // 첫날~마지막날까지 처리
    // - 날짜를 하루씩 이동하여 월이 바뀔때까지 그린다
    while (cal.get(Calendar.MONTH) == month) {
        out.println("<td>" + cal.get(Calendar.DATE) + "</td>");

        // 토요일인 경우 다음줄로 생성
        if (cal.get(Calendar.DAY_OF_WEEK) == Calendar.SATURDAY) out.println("</tr><tr>");

        // 날짜 증가시키지
        cal.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE)+1);
    }

    // 끝날부터 토요일까지 빈칸으로 처리
    for (int i=cal.get(Calendar.DAY_OF_WEEK); i<=7; i++) out.println("<td>&nbsp;</td>");
%>
        </tr>
        </table>

    </td>
</tr>
</table> --%>








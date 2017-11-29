<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">
	table, th, td, input, textarea {border: solid gray 1px;}
	
	#table, #table2 {border-collapse: collapse;
	 		         width: 600px;
	 		        }
	#table th, #table td{padding: 5px;}
	#table th{width: 120px; background-color: #DDDDDD;}
	#table td{width: 480px;}
	.long {width: 470px;}
	.short {width: 120px;} 	
	
	a{text-decoration: none;}	

</style>

<script type="text/javascript">
	
	function begin() {
		
		var one = document.getElementById("one").value;
		
	}
	
</script>



<h1>출퇴근 체크</h1>

홍길동님의 출퇴근 내역 입사일자 2017-10-10
<br/>

<button>출근</button>
<button>톼근</button>

<br/>

<select id="one" onchange="begin()">
	<c:forEach begin="1" end="12" varStatus="status">
		<option value="${status.count}">${status.count}월</option>
	</c:forEach>
</select>
~
<select id="two">
	<c:forEach begin="1" end="12" varStatus="status">
		<option value="${status.count}">${status.count}월</option>
	</c:forEach>
</select>

<table>
	<thead>
		<tr>
			<th>일자</th>
			<th>출근시간</th>
			<th>퇴근시간</th>
			<th>근무시간</th>
			<th>상태</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>2017-11-29</td>
			<td>11:06</td>
			<td>17:45</td>
			<td>6:00</td>
			<td>지각</td>
		</tr>
	</tbody>
</table>


pagebar


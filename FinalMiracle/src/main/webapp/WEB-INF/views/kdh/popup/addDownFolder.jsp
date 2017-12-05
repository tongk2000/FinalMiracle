<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<title>하위 폴더 추가</title>
<table>
	<tr>
		<td>상위폴더</td> <td>${map.subject}</td>
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
		<td>시작일</td> <td><input type="text" name="startdate"/></td>
	</tr>
	<tr>
		<td>마감일</td> <td><input type="text" name="lastdate"/></td>
	</tr>
	<tr>
		<td>중요도</td> <td><input type="text" name="importance"/></td>
	</tr>
</table>
<input type="text" value=""/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<tr>
	<td class="infoClass">첨부파일</td>
	<td>
		<table style="width:100%;">
			<c:if test="${empty map.folder_fileList}">
				<tr>
					<td style="border:none;">등록된 첨부파일이 없습니다.</td>
				</tr>
			</c:if>
			<c:if test="${not empty map.folder_fileList}">
				<c:forEach var="ffvo" items="${map.folder_fileList}" varStatus="status">
					<tr class="trLine">
						<td style="border:none;">
							<span>
								<input type="button" value="del">
								<a style="text-decoration:none;" class="pointer" 
								   href="<%=request.getContextPath()%>/do_fileDownload.mr?orgFilename=${ffvo.orgFilename}&serFilename=${ffvo.serFilename}">
									${ffvo.orgFilename}(${ffvo.filesize})
								</a>:${ffvo.userid}
							</span>
						</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>
	</td>
<tr>
<tr>
	<td class="infoClass">파일추가</td>
	<td id="fileCnt">
		<table style="width:100%;">
			<tr class="trLine">
				<td style="border:none;">
					<input type="button" value="+"/>
					<input type="file" name="attach" id="attach" style="display:inline-block;"/>
					<input type="button" value="-" style="display:inline-block;" onclick="minusFileInput()"/>
				</td>
			</tr>
		</table>
	</td>
</tr>
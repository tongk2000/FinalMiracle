<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	td.infoClass {
		border-top:ridge;
		border-bottom:ridge;
		border-right:ridge;
		color:black;
		font-weight:bold;
		width:100px;
	}
	
	td.infoData {
		border-top:ridge;
		border-bottom:ridge;
	}
	
	td.showInfo {
		color:green;
		cursor:pointer;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		var changeFlag = false;
		
		$(".hiddenEdit").hide();
		$(".showInfo").click(function(){
			$(this).hide();
			var $hiddenEdit = $(this).parent().find(".hiddenEdit");
			$hiddenEdit.show();
			
			var $hiddenEditInput = $hiddenEdit.find(".hiddenEditInput");
			$hiddenEditInput.focus();
			
			var endFocus = $hiddenEditInput.val();  // 이렇게
			$hiddenEditInput.val("").val(endFocus); // 짝지어주면 글 커서가 제일 마지막으로 감!!
		});
		
		$(".hiddenEditInput").blur(function(){
			$(this).parent(".hiddenEdit").hide();
			$(this).parent().parent().find(".showInfo").show();
		});
		
		$(".hiddenEditInput").change(function(){
			changeFlag = true;
			$(this).parent().parent().find(".showInfo").html($(this).val());
		});
		
		$("#body").keydown(function(){
			var modalFlag = $('#folderInfo').is(':visible');
			if(event.keyCode == 27 && modalFlag && changeFlag) { // 입력한 키가 esc 이고, 모달창이 보여지고 있는 상태이면서 바꾼 내용이 있을때				
				var ynFlag = confirm("창을 종료하시겠습니까?\r\n(종료시 수정하신 정보는 모두 초기화됩니다)");
				if(ynFlag) {
					changeFlag = false;
					$('#folderInfo').modal('hide');
				} else {
					return false;
				}
			} else if (event.keyCode == 27 && modalFlag) { // 위 조건에 바꾼 내용은 없을때
				$('#folderInfo').modal('hide');
			}
		}); // end of $("#body").keyup(function() ------------------------------------------------------------------------------------------------------
		
		/* $(document).on("click", ".modalClose", function(){			
			$("#body").triggerHandler("keyup");
		}); // end of $(".modalClose").click(function() ------------------------------------------------------------------------------------------------------ */
	});
</script>

<form name="folderInfoEdit">
	<div class="modal-dialog">
		<div class="modal-content" align="center">
			<div class="modal-header">
				<button type="button" class="close modalClose" data-dismiss="modal">&times;</button>
				<!-- &times; : x버튼으로 표시됨 -->
				<h4 class="modal-title" align="center">
					::: <span style="color: blue; font-weight: bold;">${fvo.subject}</span> 폴더 상세정보 :::<br/>
					<span style="font-size: 9pt; margin-left: -25px;">
						(<span style="color: green;">녹색글자</span>는 수정가능한 항목입니다.)
					</span>
				</h4>
			</div>
			<div class="modal-body" style="width: 100%; height: 400px;">
				<table>
					<tbody>
						<tr>
							<td class="infoClass">폴더이름</td>
							<td class="infoData showInfo">${fvo.subject}
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="subject" value="${fvo.subject}" />
							</td>
						</tr>
						
						<tr>
							<td class="infoClass">폴더개요</td>
							<td class="infoData showInfo">${fvo.content}
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="content" value="${fvo.content}" />
							</td>
						</tr>

						<tr>
							<td class="infoClass">시작일</td>
							<td class="infoData showInfo">${fvo.startDate}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="startDate" value="${fvo.startDate}" />
							</td>
						</tr>

						<tr>
							<td class="infoClass">마감일</td>
							<td class="infoData showInfo">${fvo.lastDate}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="lastDate" value="${fvo.lastDate}" />
							</td>

						</tr>

						<tr>
							<td class="infoClass">담당</td>
							<td class="infoData">
								<c:forEach var="ftvo" items="${folder_teamwonList}" varStatus="status">
									${ftvo.userid}(${ftvo.proceedingTaskCnt}:${ftvo.completeTaskCnt})<c:if test="${status.count != folder_teamwonList.size()}">,</c:if>
								</c:forEach>
							</td>
						</tr>

						<tr>
							<td class="infoClass">폴더 중요도</td>
							<td class="infoData showInfo">${fvo.importance}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="importance" value="${fvo.importance}" />
							</td>
						</tr>
						
						<tr>
							<td class="infoClass">하위 요소 중요도</td>
							<td class="infoData showInfo">${fvo.importanceAvg}</td>
							<td class="infoData hiddenEdit">
								<input style="height: 20px; width: 100%;" type="text" class="hiddenEditInput" name="fvo.importanceAvg" value="${fvo.importanceAvg}" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div>
				<table>
					<thead>
						<tr>
							<th>작성자</th>
							<th>댓글내용</th>
							<th>작성일자</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${empty folder_commentList}">
							<td colspan="3">등록된 댓글이 없습니다.</td>
						</c:if>
						<c:if test="${not empty folder_commentList}">
							<c:forEach var="fcvo" items="${folder_commentList}" varStatus="status">
								<tr>
									<td>${fcvo.userid}</td>
									<td>${fcvo.content}</td>
									<td>${fcvo.writeDate}</td>
								</tr>
							</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" onClick="goEdit();">정보수정</button>
				<button type="button" class="btn btn-default modalClose">취소</button>
			</div>
		</div>
	</div>
</form>














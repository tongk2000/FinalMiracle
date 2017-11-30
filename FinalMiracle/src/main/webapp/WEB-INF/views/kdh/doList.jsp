<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	th, td{
		border:1px solid black;
	}
</style>

<script type="text/javascript">
	$(document).ready(function(){
		
		$(".modalBnt").click(function(){
			return false;
		});
		
		$(".folder").click(function(){			
			var $this = $(this);
						
			var idx = $this.attr("id");
			
			var depth = getDepth($this); // 깊이 구하기			
			
			while(1==1) {
				$this2 = $this.next(); // 다음 요소의 깊이 구하기
				var depth2 = getDepth($this2);
				
				if(depth+1 == depth2) {
					if($this2.is(":visible")) {
						$this2.hide();
					} else {
						$this2.show();
					}
				} else if (depth+1 < depth2) {
					if($this2.is(":visible")) {
						$this2.hide();
					}
				} else { // 클릭한것과 깊이가 같은 요소가 나오면 break
					break;
				}
				$this = $this2; // 다음의 다음 요소를 찾기 위함
			}
		});
		
		$("#allClose").click(function(){
			$(".folder").hide();
			$(".0").show();
		});
		
		$("#allOpen").click(function(){
			$(".folder").show();
		});
	});
	
	// 그룹번호 구해주는 함수
	function getGroupNo($this) {
		var className = $this.attr("class");
		var index1 = className.indexOf(" ");
		var index2 = className.indexOf(" ", index1+1);
		var groupNo = className.substr(index1+1, index2-index1-1);
		return parseInt(groupNo);
	}
	
	// 깊이 구해주는 함수
	function getDepth($this) {
		var className = $this.attr("class");
		var index1 = className.indexOf(" ");
		var index2 = className.indexOf(" ", index1+1);
		var depth = className.substr(index2);
		return parseInt(depth);
	}
	
	
</script>

<div class="container" style="width:40%; float:left">
	<div><span id="allClose">전체접기</span>  ||  <span id="allOpen">전체펴기</span></div>
	<table style="width:100%">
		<thead>
			<tr>
				<th style="width:30%">제목</th>
				<th>시작일</th>
				<th>마감일</th>
				<th>중요도</th>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty doList}"> <!-- 프로젝트 리스트가 비었다면 -->
				<td colspan="4">등록된 프로젝트가 없습니다.</td>
			</c:if>
			<c:if test="${not empty doList}"> <!-- 프로젝트 리스트가 있다면 -->
				<c:forEach var="dvo" items="${doList}">
					<tr id="${dvo.idx}" class="folder ${dvo.groupNo} ${dvo.depth}">
						<td>
							<span style="margin-left:${dvo.depth*15}px;">
								<c:if test="${dvo.category == 1}"> <!-- 폴더라면 -->
									<a data-toggle="modal" data-target="#MyInfo" data-dismiss="modal" data-backdrop="static" class="modalBnt">
										<c:if test="${dvo.fk_folder_idx == 0}"> <!-- 최상위 폴더라면 -->
											${dvo.subject}
										</c:if>
										<c:if test="${dvo.fk_folder_idx != 0}"> <!-- 최상위 폴더가 아니라면 -->
											└${dvo.subject}
										</c:if>
									</a>
								</c:if>
								<c:if test="${dvo.category == 2}"> <!-- 할일이라면 -->
									└<input type="checkbox"/>${dvo.subject}
								</c:if>
							</span>
						</td>
						<c:if test="${dvo.dayCnt == 0}"> <!-- 시작일 전이라면 -->
							<td style="background-color:lightgreen;">${dvo.startDate}</td>
							<td style="background-color:lightgreen;">${dvo.lastDate}</td>
						</c:if>
						<c:if test="${dvo.dayCnt == 1}"> <!-- 진행중이라면 -->
							<td style="background-color:green;">${dvo.startDate}</td>
							<td style="background-color:green;">${dvo.lastDate}</td>
						</c:if>
						<c:if test="${dvo.dayCnt == -1}"> <!-- 기한이 지났다면 -->
							<td style="background-color:red;">${dvo.startDate}</td>
							<td style="background-color:red;">${dvo.lastDate}</td>
						</c:if>
						<td>${dvo.importance}</td>
					</tr>
				</c:forEach>
			</c:if>
		</tbody>
	</table>
</div>

<div class="container" style="width:60%; float:right">
</div>





<%-- 폴더 보기 Modal --%>
<div class="modal fade" id="MyInfo" role="dialog">
      <form name="MyInfoEdit" method="post" action="MyInfoEdit.do">
      <div class="modal-dialog">
            <%-- Modal content --%>
        <div class="modal-content" align="center">
              <div class="modal-header">
                  <button type="button" class="close modalClose" data-dismiss="modal">&times;</button> <!-- &times; : x버튼으로 표시됨 -->
                  <h4 class="modal-title" align="center">
                        ::: <span style="color:blue; font-weight:bold;">${loginUser.name}</span> 회원님의 정보 ::: <br/>
                        <span style="font-size:9pt; margin-left:-25px;">(<span style="color:green;">녹색글자</span>는 수정가능한 항목입니다.)</span>
                  </h4>
              </div>
              <div class="modal-body" style="width:100%; height:400px;">
                  <table>
                        <tbody>
                              <tr>
                                    <td class="infoClass">회원번호</td>
                                    <td class="infoData">
                                          ${loginUser.idx}
                                          <input type="hidden" name="idx" value="${loginUser.idx}"/>
                                    </td>
                              </tr>
                              
                              <tr>
                                    <td class="infoClass">성명</td>
                                    <td class="infoData showInfo">${loginUser.name}</td>
                                    <td class="infoData hiddenEdit">
                                          <input style="height:20px; width:100%;" type="text" id="name" name="name" value="${loginUser.name}"/>
                                    </td>
                              </tr>
                              
                              <tr>
                                    <td class="infoClass">아이디</td>
                                    <td class="infoData">
                                          ${loginUser.userid}
                                          <input type="hidden" name="userid" value="${loginUser.userid}"/>
                                    </td>
                                    
                              </tr>
                              
                              <tr>
                                    <td class="infoClass">비밀번호</td>
                                    <td class="infoData showInfo">********</td>
                                    <td class="infoData hiddenEdit">
                                          <input style="height:20px; width:100%;" type="password" id="pwd" name="pwd" value="${loginUser.pwd}"/>
                                    </td>
                              </tr>
                              
                              <tr>
                                    <td class="infoClass" style="width:120px;">비밀번호 확인</td>
                                    <td class="infoData showInfo">********</td>
                                    <td class="infoData hiddenEdit">
                                          <input style="height:20px; width:100%;" type="password" value="${loginUser.pwd}"/>
                                    </td>
                              </tr>
                              
                              <tr>
                                    <td class="infoClass">이메일</td>
                                    <td class="infoData showInfo">${loginUser.email}</td>
                                    <td class="infoData hiddenEdit">
                                          <input style="height:20px; width:100%;" type="text" id="email" name="email" value="${loginUser.email}"/>
                                    </td>
                              </tr>
                              
                              <tr>
                                    <td class="infoClass">연락처</td>
                                    <td class="infoData showInfo">${loginUser.allHp}</td>
                                    <td class="infoData hiddenEdit">
                                          <select id="hp1" name="hp1" style="height:20px; vertical-align:top;">
                                                 <option value="${loginUser.hp1}"selected></option>
                                           <option value="010">010</option>
                                           <option value="011">011</option>
                                           <option value="016">016</option>
                                           <option value="017">017</option>
                                           <option value="018">018</option>
                                           <option value="019">019</option>        
                                      </select>&nbsp;-
                                      <input style="height:20px;" type="text" id="hp2" name="hp2" size="4" maxlength="4" value="${loginUser.hp2}"/>&nbsp;-
                                      <input style="height:20px;" type="text" id="hp3" name="hp3" size="4" maxlength="4" value="${loginUser.hp3}"/>
                                    </td>
                              </tr>
                              
                              <tr>
                                    <td class="infoClass">우편번호</td>
                                    <td class="infoData showInfo">${loginUser.allPost}</td>
                                    <td class="infoData hiddenEdit">
                                          <input style="height:20px;" type="text" id="post1" size="3" maxlength="3" name="post1" value="${loginUser.post1}"/>&nbsp;-
                                          <input style="height:20px;" type="text" id="post2" size="3" maxlength="3" name="post2" value="${loginUser.post2}"/>
                                    </td>
                              </tr>
                              
                              <tr>
                                    <td class="infoClass">주소</td>
                                    <td class="infoData showInfo">${loginUser.allAddr}</td>
                                    <td class="infoData hiddenEdit">
                                          <input style="height:20px; width:100%;" type="text" id="addr1" name="addr1" value="${loginUser.addr1}"/>
                                          <input style="height:20px; width:100%;" type="text" id="addr2" name="addr2" value="${loginUser.addr2}"/>
                                    </td>
                              </tr>
                              
                              <tr>
                                    <td class="infoClass">가입일자</td>
                                    <td class="infoData">${loginUser.joindate}</td>
                              </tr>
                              
                              <tr>
                                    <td class="infoClass">충전금액</td>
                                    <td class="infoData showInfo">${loginUser.coin}</td>
                                    <td class="infoData hiddenEdit">
                                          <input style="height:20px; width:100%;" type="text" id="coin" name="coin" value="${loginUser.coin}"/>
                                    </td>
                              </tr>
                              
                              <tr>
                                    <td class="infoClass">적립금</td>
                                    <td class="infoData showInfo">${loginUser.point}</td>
                                    <td class="infoData hiddenEdit">
                                          <input style="height:20px; width:100%;" type="text" id="point" name="point" value="${loginUser.point}"/>
                                    </td>
                              </tr>
                        </tbody>
                  </table>
              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-default" onClick="goEditInsert();">정보수정</button>
                  <button type="button" class="btn btn-default modalClose">취소</button>
              </div>
        </div>
      </div>
      </form>
</div>
<%-- end of 폴더 보기 Modal --%>
























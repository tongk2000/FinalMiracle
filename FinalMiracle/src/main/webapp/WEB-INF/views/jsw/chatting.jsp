<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<script type="text/javascript" src="/board/resources/js/json2.js"></script>

<style type="text/css">
	
	#circle {
		width: 100px;
		height: 100px;
		background: red;
		-moz-border-radius: 50px;
		-webkit-border-radius: 50px;
		border-radius: 50px;
	}
	
</style>

<script type="text/javascript" >

    $(document).ready(function(){
    
        var url = window.location.host;          // 웹브라우저의 주소창의 포트까지 가져옴
    	//  alert("url : " + url);
    	    // 결과값  url: 192.168.10.36:9090
    	    
    	var pathname = window.location.pathname; // '/'부터 오른쪽에 있는 모든 경로
    	// 	alert("pathname : " + pathname);
    	    // 결과값  pathname : /board/chatting/multichat.action
    	    // /miracle/chatting.mr
    	 	
    	var appCtx = pathname.substring(0, pathname.indexOf("/",1));  // "전체 문자열".indexOf("검사할 문자", 시작순서인덱스번호);   
    	// 	alert("appCtx : " + appCtx);
    	    // 결과값  appCtx : /board/chatting
    	 	
    	var root = url+appCtx;
    	// 	alert("root : " + root);
    	 	// 결과값   root : 192.168.10.36:9090/board/chatting
    	 	
    	
    	var wsUrl = "ws://"+root+"/chattingstart.mr";
    	 // var websocket = new WebSocket("ws://192.168.10.72:9090/board/chatting/multichatstart.action");
    	var websocket = new WebSocket(wsUrl);
    	// ws://192.168.10.72:9090/miracle/chatting.mr
    	// alert(wsUrl);
    	
    	// >>>> Javascript WebSocket 이벤트 정리 <<<< 
	    //      onopen    ==>  WebSocket 연결
	    //      onmessage ==>  메시지 수신
	    //      onerror   ==>  전송 에러 발생
	    //      onclose   ==>  WebSocket 연결 해제
    	
    	var messageObj = {};
    	
	    // === 웹소켓에 최초로 연결이 되었을 경우에 실행되어지는 콜백함수
    	websocket.onopen = function() {
    		// alert("웹소켓 연결됨!!");
    		$("#chatStatus").text("Info: connection opened.");
    	
    	/*	
            messageObj = {};  // 초기화
            messageObj.message = "반갑습니다.";
            messageObj.type = "all";
            messageObj.to = "all";
        */    
            // 또는
            messageObj = { message : "반갑습니다."
        		     	 , type : "all"
        		     	 , to : "all" };  // 초기화
            
            websocket.send(JSON.stringify(messageObj));
        		     	 
        };
    	
    	// === 메시지 수신 콜백함수
        websocket.onmessage = function(evt) {
            $("#chatMessage").append(evt.data);
            $("#chatMessage").append("<br />");
            $("#chatMessage").scrollTop(99999999);
        };
        
        // === 웹소캣 연결 해제 콜백함수
        websocket.onclose = function() {
            // websocket.send("채팅을 종료합니다.");
        }
         
        
        $("#message").keydown(function (key) {
             if (key.keyCode == 13) {
                $("#sendMessage").click();
             }
          });
         
        $("#sendMessage").click(function() {
            if( $("#message").val() != "") {
                 
                messageObj = {};
                messageObj.message = $("#message").val();
                messageObj.type = "all";
                messageObj.to = "all";
                 
                var to = $("#to").val();
                if ( to != "" ) {
                    messageObj.type = "one";
                    messageObj.to = to;
                }
                 
                websocket.send(JSON.stringify(messageObj));
                
                $("#chatMessage").append("<span style='color:navy; font-weight:bold;'>[나] ▷ " + $("#message").val() + "</span><br/>");
                $("#chatMessage").scrollTop(99999999);
                 
                $("#message").val("");
            }
        });
    });
</script>
</head>
<body>
	<div style="float: left; width: 200px; height: 500px; border: 1px solid red;">

	채팅방 목록
		<div style="border: 1px solid yellow;">
			<c:forEach var="room" items="${roomList}">
				<div>${room.roomname} <span style="color: gray;">[${room.personnum}]</span>
					<c:if test="${room.notreadmessage != 0}">
						<span style="background-color: red;">${room.notreadmessage}</span>
					</c:if>
				</div>
			</c:forEach>
			
			<div>채팅방 이름 <span style="color: gray;">[5]</span></div>
		</div>
	</div>
	<div style="float: left;">
	<div id="chatMessage" style="overFlow: auto; height: 500px; border: 1px solid blue; width: 600px;"></div>
    <div id="chatStatus"></div>
    <input type="text" id="message" placeholder="메시지 내용"/>
    <input type="button" id="sendMessage" value="전송" />
    <input type="hidden" id="to" placeholder="귓속말대상"/>
    </div>
</body>
</html>
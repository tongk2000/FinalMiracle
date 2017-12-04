<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!-- <script type="text/javascript" src="/board/resources/js/json2.js"></script>
 -->
<script type="text/javascript" >

    $(document).ready(function(){
    
		var url = window.location.host;          // 웹브라우저의 주소창의 포트까지 가져옴
		//  alert("url : " + url);
		    // 결과값  url: 192.168.10.36:9090
		    
		var pathname = window.location.pathname; // '/'부터 오른쪽에 있는 모든 경로
		// 	alert("pathname : " + pathname);
		    // 결과값  pathname : /board/chatting/multichat.action
		 	
		var appCtx = pathname.substring(0, pathname.indexOf("/",7));  // "전체 문자열".indexOf("검사할 문자", 시작순서인덱스번호);   
		// substring(시작인덱스,  (인덱스가 7부터 "/"가 나오는 인덱스까지 찾음, 즉 /전까지 짜른다.) )
		    // alert("appCtx : " + appCtx); : 결과값  appCtx : /board/chatting
		 	
		var root = url+appCtx;
		// 	alert("root : " + root);
		 	// 결과값   root : 192.168.10.36:9090/board/chatting
		 	
		var wsUrl = "ws://"+root+"/multichatstart.action"; // wd:// 는 웹소켓을 나타냄 
		 // var websocket = new WebSocket("ws://192.168.10.36:9090/board/chatting/multichatstart.action");
		var websocket = new WebSocket(wsUrl); // ws://192.168.10.36:9090/board/chatting/multichatstart.action 웹소켓을  만들라는 뜻이다. 
		// alert(wsUrl);
		
		// >>>> Javascript WebSocket 이벤트 정리 <<<< 
		//      onopen    ==>  WebSocket 연결   == 웹소켓에 최초로 연결되어질 때 window.onload와 같다.
		//      onmessage ==>  메시지 수신
		//      onerror   ==>  전송 에러 발생
		//      onclose   ==>  WebSocket 연결 해제
		
		var messageObj = {}; // 현재는 널값
		
		// === 웹소켓에 최초로 연결이 되었을 경우에 실행되어지는 콜백함수
		websocket.onopen = function() {								// 소켓이 연결되면
		//	alert("웹소켓 연결됨!!");
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
		       
		       websocket.send(JSON.stringify(messageObj));			// 문자를 보내는 메소드 -> 이것때문에 Gson을 쓴다.
		   };
		
		// === 메시지 수신 콜백함수
		   websocket.onmessage = function(evt) {					// 메세지를 받을 때  evt=event
		       $("#chatMessage").append(evt.data);
		       $("#chatMessage").append("<br />");
		       $("#chatMessage").scrollTop(99999999);				// 스크롤 생성
		   };
		   
		   // === 웹소캣 연결 해제 콜백함수
		   websocket.onclose = function() {							// 웹소켓 연결해제
		       // websocket.send("채팅을 종료합니다.");
		   }
		         
        
        $("#message").keydown(function (key) {
             if (key.keyCode == 13) {								// 엔터를 치면
                $("#sendMessage").click();							// $("#sendMessage").click() 함수 실행!
             }
          });
         
        $("#sendMessage").click(function() {
            if( $("#message").val() != "") {
                 
                messageObj = {};									
                messageObj.message = $("#message").val();
                messageObj.type = "all";							// 모든 사람한테 메시지 보낼 때
                messageObj.to = "all";								// 자기자신을 뺀 나머지 모든 사람한테 보낸다.
                 
                var to = $("#to").val();							// #to = 귓속말 대상
                if ( to != "" ) {	
                    messageObj.type = "one";						// 특정한 한명한테만 메세지 보낼 때 
                    messageObj.to = to;								// 그 사람에게만 메세지 보낸다.
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
	<div id="chatStatus"></div>
	<input type="button" id="sendMessage" value="엔터" />
    <input type="text" id="message" placeholder="메시지 내용"/>
    <input type="text" id="to" placeholder="귓속말대상"/>
    <div id="chatMessage" style="overFlow: auto; max-height: 500px;"></div>
</body>
</html>
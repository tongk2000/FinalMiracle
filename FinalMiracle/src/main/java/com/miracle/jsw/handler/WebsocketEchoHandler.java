package com.miracle.jsw.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.miracle.jsw.model.MessageVO;
import com.miracle.psw.model.MemberVO;


// === #170. (웹채팅관련3) === 

public class WebsocketEchoHandler extends TextWebSocketHandler {

	    private Logger logger = LoggerFactory.getLogger(WebsocketEchoHandler.class);
	 
	    // === 서버에 연결한 사용자들을 저장하는 리스트 ===
	    private List<WebSocketSession> connectedUsers = new ArrayList<WebSocketSession>();
	 
	    public WebsocketEchoHandler() {
	        // connectedUsers = new ArrayList<WebSocketSession>();
	    }
	 
	    
	    /*
	       afterConnectionEstablished(WebSocketSession session) 메소드는 클라이언트 연결 이후에 실행되는 메소드로서
	       WebSocket 연결이 열리고 사용이 준비될 때 호출되어지는(실행되어지는) 메소드이다.
	     */
	   	 // >>> 파라미터 WebSocketSession 은  접속한 사용자임.
	    @Override
	    public void afterConnectionEstablished(WebSocketSession session) 
	    	throws Exception {
	        connectedUsers.add(session);
	 
	        logger.info(session.getId() + "님이 접속했습니다.");
	        logger.info("연결 IP : " + session.getRemoteAddress().getHostName());
	     
	    }
	 
	    
	    /*
          handleTextMessage(WebSocketSession session,  TextMessage message) 메소드는 
                 클라이언트가 웹소켓서버로 메시지를 전송했을 때 호출되는(실행되는) 메소드이다.
        */
	    // === 이벤트를 처리 ===
	     // >>> Send : 클라이언트가 서버로 메시지를 보냄
	     
	     // >>> 파라미터  WebSocketSession 은  메시지를 보낸 클라이언트임.
	     // >>> 파라미터  TextMessage 은  메시지의 내용임.
	    @Override
	    protected void handleTextMessage(WebSocketSession session, TextMessage message) 
	    	throws Exception {
	    	// ==== 웹소켓(session)을 사용하여 HttpSession에 저장된 객체 사용하기 ====
	    	/*
	    	       먼저 /webapp/WEB-INF/spring/config/websocketContext.xml 파일에서
		    	websocket:handlers 태그에 websocket:mapping 아래 websocket:handshake-interceptors에
	            HttpSessionHandshakeInterceptor를 추가하면 WebSocketHandler에 접근하기 전에 HttpSession에 접근하여 저장된 값을
	                       읽어 들여 WebSocketHandler에서 사용할 수 있도록 처리함 
            */
	    	Map<String,Object> map = session.getAttributes();
	    	MemberVO loginUser = (MemberVO)map.get("loginUser");
	    	System.out.println(">>>>>> 확인용 사용자ID : " + loginUser.getUserid());
	    	// >>>>>> 사용자ID : seoyh
	    	
	        MessageVO messageVO = MessageVO.convertMessage(message.getPayload());
	        // message.getPayload() 는  Return the message payload, never be null.
	        // payload(페이로드) ==> 데이터를 나르는 패킷, 메시지 또는 코드의 부분이라는 뜻.
	        // message.getPayload() 은  사용자가 보낸 메시지이다.
	        String hostName = "";
	 
	        for (WebSocketSession webSocketSession : connectedUsers) {
	            if (messageVO.getType().equals("all")) { // 채팅할 대상이 "전체" 일 경우 
	                if (!session.getId().equals(webSocketSession.getId())) {  // 메시지를 자기자신을 뺀 나머지 모든 사용자들에게 메시지를 보냄.
	                    webSocketSession.sendMessage(
	                            new TextMessage(session.getRemoteAddress().getHostName() +" [" +loginUser.getName()+ "]" + " ▶ " + messageVO.getMessage()));  
	                }
	            } else { // 채팅할 대상이 "전체"가 아닌 특정대상 일 경우 
	                hostName = webSocketSession.getRemoteAddress().getHostName();
	                if (messageVO.getTo().equals(hostName)) {
	                    webSocketSession.sendMessage(
	                            new TextMessage(
	                                    "<span style='color:red; font-weight: bold;' >"
	                                    + session.getRemoteAddress().getHostName() +" [" +loginUser.getName()+ "]" + "▶ " + messageVO.getMessage()
	                                    + "</span>") );
	                    break;
	                }
	            }
	        }
	 
	        // Payload : 사용자가 보낸 메시지
	        logger.info(session.getId() + "님의 메시지 : " + message.getPayload());
	    }
	 
	    
	    /*
          afterConnectionClosed(WebSocketSession session, CloseStatus status) 메소드는 
                 클라이언트가 연결을 끊었을 때 즉, WebSocket 연결이 닫혔을 때 호출되어지는(실행되어지는) 메소드이다.
        */
	     // 파라미터 WebSocketSession 은 연결을 끊은 클라이언트.
	     // 파라미터 CloseStatus 은 연결 상태.
	    @Override
	    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) 
	    	throws Exception {
	    	
	    	Map<String,Object> map = session.getAttributes();
	    	MemberVO loginUser = (MemberVO)map.get("loginUser");
	    	
	    	connectedUsers.remove(session);
	   	 
	        for (WebSocketSession webSocketSession : connectedUsers) {
	            if (!session.getId().equals(webSocketSession.getId())) { // 메시지를 자기자신을 뺀 나머지 모든 사용자들에게 메시지를 보냄.
	                webSocketSession.sendMessage(new TextMessage(session.getRemoteAddress().getHostName() +" [" +loginUser.getName()+ "]" + "님이 퇴장했습니다."));
	            }
	        }
	 
	        logger.info(session.getId() + "님이 퇴장했습니다.");
	    }
	    
	    
	    ///////////////////////////////////////////////////////////////////////
	    
	    public void sendMessage (String message){
	           for (WebSocketSession webSocketSession : this.connectedUsers){
	                  if (webSocketSession.isOpen()){
	                         try{
	                        	 webSocketSession.sendMessage(new TextMessage(message));
	                         }catch (Exception e){
	                               logger.error(">>>> 메시지 보내기 실패!!", e);
	                         }
	                  }
	           }
	     }  
	    
		// init-method(@PostConstruct)
		// 클라이언트에게 3초마다 한번씩 웹소켓으로 접속한 세션정보를 리턴시켜줌. 
		public void init() throws Exception {
			
			/*Thread thread = new Thread() {
				@Override
				public void run() {
					while (true) {
						try {
							Gson gson = new Gson();
							String sfsf = gson.toJson(connectedUsers);
							
							
							ArrayList<JSONObject> list = new ArrayList<JSONObject>();
							
							for(WebSocketSession wsession : connectedUsers) {
								String hostname = wsession.getRemoteAddress().getHostName();
								String name = "홍길동";
								
								JSONObject jsonobj = new JSONObject();
								jsonobj.put("hostname", hostname);
								jsonobj.put("name", name);
								
								list.add(jsonobj);
							}
							
							Gson gson = new Gson();
							String strJson = gson.toJson(list);
							//System.out.println(strJson);
							
							for(WebSocketSession wsession : connectedUsers) {
								try{
									wsession.sendMessage(new TextMessage(strJson));
		                         }catch (Exception e){
		                               logger.error(">>>> 메시지 보내기 실패!!", e);
		                         }
							}
							
							Thread.sleep(3000);
						} catch (InterruptedException e) {
							e.printStackTrace();
							break;
						}
					}
				}
			};
			
			thread.start();
*/		}	    
	    

	
}

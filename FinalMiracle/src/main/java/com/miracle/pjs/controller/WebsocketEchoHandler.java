package com.miracle.pjs.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;
import com.miracle.pjs.model.PjsinterDAO;
import com.miracle.psw.model.MemberVO;
//=== #170. (웹채팅관련3) === 


public class WebsocketEchoHandler extends TextWebSocketHandler {
		private Logger logger = LoggerFactory.getLogger(WebsocketEchoHandler.class);
	    
		@Autowired
		private SqlSessionTemplate sqlsession;
		
	   // === 서버에 연결한 사용자들을 저장하는 리스트 === //
	    private List<WebSocketSession> connectedUsers = null;
	    public WebsocketEchoHandler() { // 1등으로 실행됨
	        connectedUsers = new ArrayList<WebSocketSession>();
	    	System.out.println("WebsocketEchoHandler 실행");
	    }
	      // afterConnectionEstablished(WebSocketSession session) 메소드는 클라이언트 연결 이후에 실행되는 메소드로서
	      // WebSocket 연결이 열리고 사용이 준비될 때 호출되어지는(실행되어지는) 메소드이다.
	     
		@Override
		public void afterConnectionEstablished(WebSocketSession session) // >>> 파라미터 WebSocketSession 은  접속한 사용자임  // 웹소켓에 접속하면 그 후에 할 것을 정의
			throws Exception {
			System.out.println("afterConnectionEstablished 실행"); 
		    connectedUsers.add(session); // 연결된 유저를 리스트에 계속 쌓아둔다.
		    logger.info(session.getId() + "님이 접속했습니다.");							// 콘솔에 찍는 확인용
		    logger.info("연결 IP : " + session.getRemoteAddress().getHostName());		// 콘솔에 찍는 확인용
		}
	    
     // handleTextMessage(WebSocketSession session,  TextMessage message) 메소드는 
     //  클라이언트가 웹소켓서버로 메시지를 전송했을 때 호출되는(실행되는) 메소드이다.
     
	    // === 이벤트를 처리 ===
	    // >>> Send : 클라이언트가 서버로 메시지를 보냄
	     
	    // >>> 파라미터  WebSocketSession 은  메시지를 보낸 클라이언트임.
	    // >>> 파라미터  TextMessage 은  메시지의 내용임.
	    @Override
	    protected void handleTextMessage(WebSocketSession session, TextMessage message) // 클라이언트가 메시지를 보냇을 때 호출되어지는 메소드
	    	throws Exception {
	    	System.out.println("handleTextMessage 실행");
	    	// ==== 웹소켓(session)을 사용하여 HttpSession에 저장된 객체 사용하기 ====
	    	
	    	    //  먼저 /webapp/WEB-INF/spring/config/websocketContext.xml 파일에서
		    	//  websocket:handlers 태그에 websocket:mapping 아래 websocket:handshake-interceptors(<websocket:handshake-interceptors>)에
	            //  HttpSessionHandshakeInterceptor를 추가하면 WebSocketHandler에 접근하기 전에 HttpSession에 접근하여 저장된 값을
	            //  읽어 들여 WebSocketHandler에서 사용할 수 있도록 처리함 
         
	    	/*Map<String,Object> map = session.getAttributes();
	    	MemberVO loginuser = (MemberVO)map.get("loginuser");
	    	System.out.println(">>>>>> handleTextMessage 확인용 사용자ID : " + loginuser.getUserid());
	    	// >>>>>> 사용자ID : seoyh
	    	
	    	AlarmVO messageVO = AlarmVO.convertMessage(message.getPayload());  		
	        // message.getPayload() 는  Return the message payload, never be null.
	        // payload(페이로드) ==> 데이터를 나르는 패킷, 메시지 또는 코드의 부분이라는 뜻.
	        // message.getPayload() 은  사용자가 보낸 메시지이다.
	        String hostName = "";
	 
	        for (WebSocketSession webSocketSession : connectedUsers) {
	        					 // 웹소켓 세션			 array에 담아둔 유저정보
	            if (messageVO.getType().equals("all")) { // 채팅할 대상이 "전체" 일 경우 
	                if (!session.getId().equals(webSocketSession.getId())) {  // 메시지를 자기자신을 뺀 나머지 모든 사용자들에게 메시지를 보냄.
	                    webSocketSession.sendMessage(
	                            new TextMessage(session.getRemoteAddress().getHostName() +" [" +loginuser.getName()+ "]" + " ▶ " + messageVO.getMessage()));  
	                }
	            } else { // 채팅할 대상이 "전체"가 아닌 특정대상 일 경우 
	                hostName = webSocketSession.getRemoteAddress().getHostName();
	                if (messageVO.getTo().equals(hostName)) {
	                    webSocketSession.sendMessage(
	                            new TextMessage(
	                                    "<span style='color:red; font-weight: bold;' >"
	                                    + session.getRemoteAddress().getHostName() +" [" +loginuser.getName()+ "]" + "▶ " + messageVO.getMessage()
	                                    + "</span>") );
	                    break;
	                }
	            }
	        }
	        // Payload : 사용자가 보낸 메시지
	        logger.info(session.getId() + "님의 메시지 : " + message.getPayload());*/
	    	
	    	PjsinterDAO dao = sqlsession.getMapper(PjsinterDAO.class);
	    	this.logger.info(message.getPayload());
	    	//session.sendMessage(new TextMessage(dao.getMessage(message.getPayload()))); // 사용자가 보낸 메세지
	    }
	    
       //       afterConnectionClosed(WebSocketSession session, CloseStatus status) 메소드는 
       //       클라이언트가 연결을 끊었을 때 즉, WebSocket 연결이 닫혔을 때 호출되어지는(실행되어지는) 메소드이다.
     
	     // 파라미터 WebSocketSession 은 연결을 끊은 클라이언트.
	     // 파라미터 CloseStatus 은 연결 상태.
	    @Override
	    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) 
	    	throws Exception {
	    	System.out.println("afterConnectionClosed 실행");
	    	Map<String,Object> map = session.getAttributes();
	    	MemberVO loginuser = (MemberVO)map.get("loginuser");
	    	
	    	connectedUsers.remove(session);
	   	 
	        for (WebSocketSession webSocketSession : connectedUsers) {
	            if (!session.getId().equals(webSocketSession.getId())) { // 메시지를 자기자신을 뺀 나머지 모든 사용자들에게 메시지를 보냄.!!!!!
	                webSocketSession.sendMessage(new TextMessage(session.getRemoteAddress().getHostName() +" [" +loginuser.getName()+ "]" + "님이 퇴장했습니다."));
	            }
	        }
	 
	        logger.info(session.getId() + "님이 퇴장했습니다.");
	    }
	    
	    
	    ///////////////////////////////////////////////////////////////////////
	    
		public void sendMessage (String message){	// 실제로 메세지 보내는 메소드
			System.out.println("sendMessage 실행");
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
			System.out.println("웹소켓 init 메소드 실행 !!");
			Thread thread = new Thread() {
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
							
							Gson gson1 = new Gson();
							String strJson = gson1.toJson(list);
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
		}	   
	
		
		/*private List<WebSocketSession> connectedUsers = new ArrayList<WebSocketSession>();
		public WebsocketEchoHandler() {
			// 생성자에서 connectUsers 만들어도 된다.
			System.out.println("WebsocketEchoHandler 실행");
		}
		@PostConstruct
		public void init() throws Exception {
			System.out.println("웹소켓 init 메소드 실행 !!");
			Thread thread = new Thread() {
				int stop = 0;
				@Override
				public void run() {
					while(true) {
						stop++;
						try {
							Gson gson = new Gson();
							String sfsf = gson.toJson(connectedUsers);
							System.out.println("----- connectedUsers -----"+connectedUsers);
							ArrayList<JSONObject> list = new ArrayList<JSONObject>();
							for(WebSocketSession session : connectedUsers) {
								String hostname = session.getRemoteAddress().getHostName();
								System.out.println("----- hostname -----"+hostname);
								String name = "홍길동";
								JSONObject jsonobj = new JSONObject();
								jsonobj.put("hostname", hostname);
								jsonobj.put("name", name);
								list.add(jsonobj);
							}
							String strJson = gson.toJson(list);
							System.out.println("-------------------strJson-------------------"+strJson);
							for(WebSocketSession session : connectedUsers) {
								try {
									session.sendMessage(new TextMessage(strJson));
								}
								catch (Exception e) {
									logger.error("메세지 보내기 실패!");
								}
							}
						} catch(Exception e) {
							System.out.println(e.getMessage());
							break;
						}
						if(stop>10)
							break;
					}
				}
			};
			thread.start();
		}*/
}
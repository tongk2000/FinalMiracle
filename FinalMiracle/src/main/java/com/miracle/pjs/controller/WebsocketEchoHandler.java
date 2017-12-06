package com.miracle.pjs.controller;

import org.springframework.web.socket.handler.TextWebSocketHandler;

// === #170. (웹채팅관련3) === 

public class WebsocketEchoHandler extends TextWebSocketHandler {
		//private Logger logger = LoggerFactory.getLogger(WebsocketEchoHandler.class); // 로거가 뭔지 잘 압시다!!!!! -> ?
	    
		// === *** 웹소켓 스터디 *** === //
		/* 웹소켓을 사용하기 위해서 해야할 일
		 *  java 단
		 * 		1. TextWebSocketHandler를 상속받는다.
		 * 		 ┖ 자동으로 3개의 메소드를 오버라이드한다.
		 * 			1) afterConnectionClosed = 웹소켓 연결 종료 후 서버단에서 실행해야 할 일
		 * 			2) afterConnectionEstablished = 웹소켓 연결이 되면 하는 일
		 * 			3) handleTextMessage = 웹소켓 서버단으로 메세지가 도착했을 때 해주어야 할 일...중요!!
		 * 			 ┖ jsp파일에서 클라이언트가 현재 접속중인 닉네임을 웹소켓을 통해 서버로 보내면 이 메소드가 실행
		 * 			   ,현재 접속중인 닉네임은 message.getPayload() 라는 함수를 통해서 메시지에 담긴 텍스트값을 얻는다.
		 * 			   ,dao.count_receive_note 함수는 수신자의 닉네임을 통해서 수신함에서 
		 * 				현재 수신자에게 몇개의 쪽지가 와있는지를 카운트 하는 기능을 가진 메소드
		*/
		//private List<WebSocketSession> connectedUsers = new ArrayList<WebSocketSession>();
		public WebsocketEchoHandler() {
			// 생성자에서 connectUsers 만들어도 된다.
			System.out.println("WebsocketEchoHandler 실행");
		}
		/*@PostConstruct
		public void init() throws Exception {
			System.out.println("웹소켓 init 메소드 실행 !!");
			Thread thread = new Thread() {
				@Override
				public void run() {
					while(true) {
						try {
							Gson gson = new Gson();
							String sfsf = gson.toJson(connectedUsers);
							System.out.println("----- connectedUsers -----"+connectedUsers);
							ArrayList<JSONObject> list = new ArrayList<JSONObject>();
							for(WebSocketSession session : connectedUsers) { //connectedUsers가 없으면 작동X
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
									//session.sendMessage(new TextMessage(strJson));
								}
								catch (Exception e) {
									logger.error("메세지 보내기 실패!");
								}
							}
						} catch(Exception e) {
							System.out.println(e.getMessage());
							break;
						}
					}
				}
			};
			thread.start();
		}
		*/
}
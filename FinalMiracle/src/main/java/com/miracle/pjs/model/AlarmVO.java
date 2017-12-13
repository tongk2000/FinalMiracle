package com.miracle.pjs.model;


//=== #171. (웹채팅관련4) === 

import com.google.gson.Gson; // multichat.jsp에서   messageObj = { message : "반갑습니다."
							 //									 , type : "all"
							 //									 , to : "all" };      이렇게 json형태로 만들기 위해 사용됨
public class AlarmVO {

	private String message;
	private String type;
	private String to;
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public static AlarmVO convertMessage(String source) {
		AlarmVO messagevo = new AlarmVO();
	    Gson gson = new Gson();
	    messagevo = gson.fromJson(source, AlarmVO.class);
	 
	    return messagevo;
	}
}
package com.miracle.jsw.model;

//=== #171. (웹채팅관련4) === 

import com.google.gson.Gson;

public class MessageVO {

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

	public static MessageVO convertMessage(String source) {
	    MessageVO messagevo = new MessageVO();
	    Gson gson = new Gson();
	    messagevo = gson.fromJson(source, MessageVO.class);
	 
	    return messagevo;
	}

}

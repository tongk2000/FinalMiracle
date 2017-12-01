package com.miracle.psw.util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

//===== #165. MySMTPAuthenticator 클래스 생성하기 ===== 
public class MySMTPAuthenticator extends Authenticator {
	
	@Override
	public PasswordAuthentication getPasswordAuthentication() { 
	
		// Gmail 인 경우 @gmail.com 을 제외한 아이디만 입력한다.
		return new PasswordAuthentication("sangwoo1485","wndbth1126!");
	}
}

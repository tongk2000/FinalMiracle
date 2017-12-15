package com.miracle.kdh.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Calendar;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;

// 파일 업로드 다운로드 관리하는 클래스(파일을 서버에 저장하고, 서버에 저장된 파일명을 반환해줌)
@Repository // DAO 처럼 주입하면됨
public class FileManagerKDH {
	// 파일 업로드 해주는 메소드
	public String doFileUpload(byte[] bytes, String orgFilename, String path)
			throws Exception {		
		// ***** 먼저 3가지의 유효성 검사를 한다. *****
		if(bytes == null) { // 파일이 없다면
			return null;
		}
		if(orgFilename.trim().equals("")) { // 원본 파일명이 없다면 
			return null;
		}
		String fileExt = orgFilename.substring(orgFilename.lastIndexOf(".")); // 원본 파일명의 확장자 추출하기
		if(fileExt == null || fileExt.trim().equals("")) { // 원본 파일명에서 확장자가 없다면
			return null;
		}
		
		// ***** 유효성 검사가 끝나면 다음을 실행한다. *****
		String serFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", Calendar.getInstance()); // 년월일시분초 를 가져오고
		// 20171214172145
		
		serFilename += System.nanoTime(); // 나노초를 더하고 (참고로 랜덤은 같은 숫자가 나올수도 있기 때문에 대신 나노초를 이용하는것)
		// 2017121417214528262951792671
		
		serFilename += fileExt; // 확장자를 붙여준다.
		// 2017121417214528262951792671.jpg
		
		File dir = new File(path); // 파일 경로를 사용하는 File 객체 생성
		if(!dir.exists()) { // 업로드할 경로가 없으면 
			dir.mkdirs(); // 새로 만들어준다.
		}
		
		String pathname = path + File.separator + serFilename; // File.separator (파일 분리기호) : 서버의 운영체제가 windows 계열이라면 "\" 를 말하고
															   //                                  Unix 계열이라면 "/" 를 말한다.
		// C:\FinalMiracle\.metadata\.plugins\org.eclipse.wst.server.core\tmp3\wtpwebapps\FinalMiracle\resources\files\2017121417214528262951792671.jpg
	
		FileOutputStream fos = new FileOutputStream(pathname); // 파일을 직렬화해서 해당 pathname 경로로 내보내는(서버에 저장하는) 객체
		fos.write(bytes); // 컨트롤단에서 bytes = ffvo.getAttach().getBytes(); 으로 뷰단에서 받아온 파일을 직렬화해서 보내온것 
		fos.close();
		
		return serFilename; // 서버에 저장되는 파일명 반환(DB에 파일명 저장하려고~)
	}
	
	
	// 파일 다운로드 해주는 메소드
	public boolean doFileDownload(String serFilename, String orgFilename, String path, HttpServletResponse res) {
	/*	serFilename : 서버에 저장된 파일명
		orgFilename : 원본 파일명(사용자가 업로드한 파일명)
		path : 서버에 저장된 경로
	*/
		try {
			if(orgFilename == null || orgFilename.trim().equals("")) { // 혹시라도 원본 파일명이 없다면
				orgFilename = serFilename; // 서버에 저장된 파일명으로 대체해준다.
			}
			orgFilename = new String(orgFilename.getBytes("euc-kr"), "8859_1"); // euc-kr : 반드시 이걸로 해줘야 한글이 안깨짐. 뒤에 8859_1 은 인코딩의 한 종류임.
		} catch(UnsupportedEncodingException e) {
		}
		
		try {
			String pathname = path + File.separator + serFilename;
			File file = new File(pathname); // 경로상에 있는 파일을 File 객체에 넣어줌
			
			if(file.exists()) { // 경로상에 파일이 존재한다면				
				res.setContentType("application/octet-stream");
				res.setHeader("Content-disposition", "attachment;filename="+orgFilename);
				// 이건 그냥 이렇게 해줘야 한다고 하심
				
				BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file)); 
				// new FileInputStream(file) : 위의 file 객체에 빨대를 꼽고 
				// new BufferedInputStream : 거기에 보조스트림도 달아줌
				OutputStream outs = res.getOutputStream();
				byte[] readByte = new byte[4096];
				int read = 0;
				while((read = fin.read(readByte, 0, 4096)) != -1) { // 파일을 추출해서
					outs.write(readByte, 0, read); // 저장시킨다. (따로 경로를 지정 안했으므로 브라우저 기본 경로에 저장됨)
				}
				outs.flush();
				outs.close();
				fin.close();
				
				return true;
			}
		} catch(Exception e) {
		}
		return false;
	}
	
	// 서버에 저장된 파일 삭제하는 메소드
	public void doFileDelete(String serfilename, String path)
			throws Exception {
		String pathname = path + File.separator + serfilename;
		File file = new File(pathname);
		if(file.exists()) { // 파일이 존재하면
			file.delete(); // 삭제한다.
		}
	}
	
	// 서버에 저장된 파일 사이즈 구하는 메소드
	public long getFilesize(String pathname) {
		long size = -1;
		File file = new File(pathname);
		if(file.exists()) { // 파일이 있다면
			size = file.length(); // 파일 사이즈를 저장함
		}
		return size;
	}
	
	// 서버에 저장된 파일 타입 구하는 메소드
	public String getFiletype(String pathname) {
		String type = "";
		try{
			URL url = new URL("file:"+pathname); // 이건 뭐지;;;;;;
			URLConnection uc = url.openConnection(); // 이건 또 뭐고..
			type = uc.getContentType(); // 대체 ㅠㅠㅠㅠㅠ
		} catch(Exception e) {
		}
		return type;
	}
}













































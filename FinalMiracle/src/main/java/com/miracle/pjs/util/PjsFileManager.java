package com.miracle.pjs.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Calendar;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Repository;

// ===== #129. FileManager 클래스 생성하기 =====
@Repository
public class PjsFileManager {
	// path : 파일을 저장할 경로
	// 리턴 : 서버에 저장된 새로운 파일명
	public String doFileUpload(byte[] bytes, String originalFilename, String path) throws Exception {
							  // 올라가는 실제파일		// 실제 파일이름		  // 파일을 업로드할 경로
		String newFilename = null; // 돌려받기 위한 용도록, 실제 업로드 되어진 파일이 나노초로 구별되기에 알아볼 수 없어서 받을 때 식별자로 쓰기위한 용도
		if(bytes == null) // 파일이 없다면 메소드 종료
			return null;
		// 클라이언트가 업로드한 파일의 이름
		if(originalFilename.equals("")) // 파일이름이 없다면 메소드 종료
			return null;
		// 확장자												// lastIndexOf 맨마지막에나오는 .
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf(".")); // 실제 파일이름(식별할 수 있어야 한다.), (lastIndexOF(".")는 파일이름에서 마지막 점)까지 문자를 가져옴
		if(fileExt == null || fileExt.equals(""))  // ex) 강아지.jsp에서 강아지만 잘라온다.
			return null;
		// 서버에 저장할 새로운 파일명을 만든다.
		newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
				         Calendar.getInstance()); // 날짜클래스를 가져옴! 
		newFilename += System.nanoTime();	      // 파일이름이 같거나, 파일내용이 같아서 중복될 수 있는 가능성을 나노초로 나누어 유일한 값을 파일이름으로 한다.
		newFilename += fileExt; 
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(path); // 파일의 경로를 보여주어서 파일생성
		if(!dir.exists())
			dir.mkdirs();
		String pathname = path + File.separator + newFilename; // 
		FileOutputStream fos = new FileOutputStream(pathname); // 파일경로를 가져와 그 파일을 생성한다.
		fos.write(bytes);
		fos.close();
		return newFilename;
	}
	public String doFileUpload(InputStream is, String originalFilename, String path) throws Exception {
		String newFilename = null;
		// 클라이언트가 업로드한 파일의 이름 , 돌려받기 위한 용도
		if(originalFilename==null||originalFilename.equals(""))
			return null;
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals(""))
			return null;
		// 서버에 저장할 새로운 파일명을 만든다.
		newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS",  // 임의의 파일명 : %1$tY%1$tm%1$td%1$tH%1$tM%1$tS
				         Calendar.getInstance());
		newFilename += System.nanoTime();
		newFilename += fileExt;
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(path);
		if(!dir.exists())
			dir.mkdirs();
		String pathname = path + File.separator + newFilename; //
		byte[] b=new byte[1024];
		int size=0;
		FileOutputStream fos = new FileOutputStream(pathname);
		while((size=is.read(b))!=-1) { // ? 질문
			fos.write(b, 0, size);
		}
		fos.close();
		is.close();
		return newFilename;
	}
	// 파일 다운로드
	// saveFilename : 서버에 저장된 파일명
	// originalFilename : 클라이언트가 업로드한 파일명
	// path : 서버에 저장된 경로
	public boolean doFileDownload(String saveFilename, String originalFilename, String path, HttpServletResponse response) {
		System.out.println("==========================="+saveFilename);
		System.out.println("==========================="+originalFilename);
		System.out.println("==========================="+path);
		
		String pathname = path + File.separator + saveFilename; // saveFilename 숫자로 되어진 파일이름
        try {
    		if(originalFilename == null || originalFilename.equals("")) // originalFilename이 없으면 숫자로 되어진 파일이름을 넣어준다.
    			originalFilename = saveFilename;
        	originalFilename = new String(originalFilename.getBytes("euc-kr"),"8859_1");
        } catch (UnsupportedEncodingException e) {
        }
	    try {
	    	System.out.println("======================file=======================");
	        File file = new File(pathname); // pathname은 파일이 있는 전체주소값을 말한다.
	        if (file.exists()){ // 파일이 있다면
	        	System.out.println("======================file 있나요?=======================");
	            byte readByte[] = new byte[4096]; // 읽어들이는 단위 4kb
	            response.setContentType("application/octet-stream"); 
				response.setHeader(
						"Content-disposition",
						"attachment;filename=" + originalFilename); // 다운받을 때 나오는 파일이름 : originalFilename
	            BufferedInputStream  fin  = new BufferedInputStream(new FileInputStream(file)); // 다운받기 위해 InputStream
	            //javax.servlet.ServletOutputStream outs =	response.getOutputStream();
	            OutputStream outs = response.getOutputStream();
	   			int read;
	    		while ((read = fin.read(readByte, 0, 4096)) != -1) { // 4kb씩 input하다가 없으면 리턴값으로 -1반환
	    			outs.write(readByte, 0, read);
	    		}
	    		outs.flush();								   
	    		outs.close();
	            fin.close();
	            System.out.println("======================file 오나요?=======================");
	            return true;
	        }
	    } catch(Exception e) {
	    }
	    return false;
	}
	// 실제 파일 삭제
	public void doFileDelete(String filename, String path) 
	        throws Exception {
		String pathname = path + File.separator + filename;
		File file = new File(pathname);
        if (file.exists())
           file.delete();
	}
	// 파일 길이
	public long getFilesize(String pathname) {
		long size=-1;
		
		File file = new File(pathname);
		if (! file.exists())
			return size;
		
		size=file.length();
		
		return size;
	}
	// 파일 타입
	public String getFiletype(String pathname) {
		String type="";
		try {
			URL u = new URL("file:"+pathname);
		    URLConnection uc = u.openConnection();
		    type = uc.getContentType();
		} catch (Exception e) {
		}
	    return type;
	}
}

package com.miracle.ksh.util;

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
public class KshFileManager {

	// path : 파일을 저장할 경로
	// 리턴 : 서버에 저장된 새로운 파일명
	public String doFileUpload(byte[] bytes, String originalFilename, String path) throws Exception {
		String newFilename = null;

		if(bytes == null)
			return null;
		
		// 클라이언트가 업로드한 파일의 이름
		if(originalFilename.equals(""))
			return null;
		
		// 확장자												// lastIndexOf 맨마지막에나오는 .
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf(".")); 
		if(fileExt == null || fileExt.equals(""))
			return null;
		
		// 서버에 저장할 새로운 파일명을 만든다.
		newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
				         Calendar.getInstance());
		newFilename += System.nanoTime();
		newFilename += fileExt;
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(path);
		if(!dir.exists())
			dir.mkdirs();
		
		String pathname = path + File.separator + newFilename;
		
		FileOutputStream fos = new FileOutputStream(pathname);
		fos.write(bytes);
		fos.close();
		
		return newFilename;
	}

	public String doFileUpload(InputStream is, String originalFilename, String path) throws Exception {
		String newFilename = null;

		// 클라이언트가 업로드한 파일의 이름
		if(originalFilename==null||originalFilename.equals(""))
			return null;
		
		// 확장자
		String fileExt = originalFilename.substring(originalFilename.lastIndexOf("."));
		if(fileExt == null || fileExt.equals(""))
			return null;
		
		// 서버에 저장할 새로운 파일명을 만든다.
		newFilename = String.format("%1$tY%1$tm%1$td%1$tH%1$tM%1$tS", 
				         Calendar.getInstance());
		newFilename += System.nanoTime();
		newFilename += fileExt;
		
		// 업로드할 경로가 존재하지 않는 경우 폴더를 생성 한다.
		File dir = new File(path);
		if(!dir.exists())
			dir.mkdirs();
		
		String pathname = path + File.separator + newFilename;
		
		byte[] b=new byte[1024];
		int size=0;
		FileOutputStream fos = new FileOutputStream(pathname);
		
		while((size=is.read(b))!=-1) {
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
		String pathname = path + File.separator + saveFilename;
		
        try {
    		if(originalFilename == null || originalFilename.equals(""))
    			originalFilename = saveFilename;
        	originalFilename = new String(originalFilename.getBytes("euc-kr"),"8859_1");
        } catch (UnsupportedEncodingException e) {
        }

	    try {
	        File file = new File(pathname);

	        if (file.exists()){
	            byte readByte[] = new byte[4096];

	            response.setContentType("application/octet-stream");
				response.setHeader(
						"Content-disposition",
						"attachment;filename=" + originalFilename);

	            BufferedInputStream  fin  = new BufferedInputStream(new FileInputStream(file));
	            //javax.servlet.ServletOutputStream outs =	response.getOutputStream();
	            OutputStream outs = response.getOutputStream();
	            
	   			int read;
	    		while ((read = fin.read(readByte, 0, 4096)) != -1)
	    				outs.write(readByte, 0, read);
	    		outs.flush();
	    		outs.close();
	            fin.close();
	            
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

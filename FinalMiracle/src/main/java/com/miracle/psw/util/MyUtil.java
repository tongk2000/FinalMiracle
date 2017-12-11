package com.miracle.psw.util;

import java.text.DecimalFormat;
import java.util.Date;
import java.util.Random;
import java.util.Scanner;

import javax.servlet.http.HttpServletRequest;


public class MyUtil {

	public static double myround(double data, int index) {
		 // index  1 ==> data * 1 / 1.0
		 // index  2 ==> data * 10 / 10.0
		 // index  3 ==> data * 100 / 100.0
		 // index  4 ==> data * 1000 / 1000.0
		int num = 1;
				
		for(int i=0; i<index-1; i++) {
			num *= 10;
		}
		
		if(index == 1) {
			return Math.round(data);
		} else {
			return Math.round(data*num)/(double)num;	
		}
	}
	
	// ------ 현재시각 나타내기 ------- //
	public static String getNowTime() {
		Date now = new Date();
        String today = String.format("%tF %tT", now, now);
        return today;
	}

    // ------ 현재요일명 나타내기 ------- //
    public static String getNowDay() {
		Date now = new Date();
        String day = String.format("%tA", now);
        return day;
	}


    //-- 숫자를 입력받아서 세자리 마다 콤마(,)를 찍어서 리턴시켜주는 메소드 생성하기 -- //
	public static String getMoney(long money) {
	
		DecimalFormat df = new DecimalFormat("#,###");
		// 숫자로 되어진 데이터를 세자리 마다 콤마(,)를 찍어주는 객체를 생성함.

		String strmoney = df.format(money);

		return strmoney;
	}
	
	
	// === 랜덤한 정수를 생성하여 리턴해주는 메소드 생성하기 ===
	// 랜덤한정수 = (int)(Math.random() * 구간범위) + 시작값;  
	   public static int myRandom(int startNum, int endNum){
		  
		   int ran = (int)(Math.random() * (endNum - startNum + 1)) + startNum;
		   
		   return ran;
	   }
	   
	   
	// === 랜덤한 정수를 생성하여 리턴해주는 메소드 생성하기 ===
	// Random rnd = new Random(); 
	// 랜덤한 정수 = rnd.nextInt(구간범위) + 시작값;
	   public static int myRandom2(int startNum, int endNum){
		  
		   Random rnd = new Random();
		   
		   int ran = rnd.nextInt(endNum-startNum+1) + startNum; 
		   
		   return ran;
	   }   

	   
	  /*
	   >> 암호정책 -- 
	       암호는 8글자 이상 15글자 이하에서 
	       영문자, 숫자, 특수기호가 혼합되어진 암호이라면 true 를 리턴해주고,
	        아니라면 false 를 리턴해주는 메소드 생성하기 
	  */
	   public static boolean checkPasswd(String passwd) {
		   
		   boolean result = false;
		   int flagAlphabet = 0;
		   int flagNumber = 0;
		   int flagSpecial = 0;
		   
		   int len = passwd.length();
		   
		   if(len < 8 || len > 15) {
			   return result;
		   }
		   else{
			   char ch = ' ';
			   for(int i=0; i<len; i++) {
				   ch = passwd.charAt(i);
				   
				   if(('a' <= ch && ch <= 'z') || 
					  ('A' <= ch && ch <= 'Z') ) {
					   flagAlphabet = 1;
				   }
				   else if('0' <= ch && ch <= '9') {
					   flagNumber = 1;
				   }
				   else if( ch=='!' || ch=='@' ||
						    ch=='#' || ch=='$' || 
						    ch=='%' || ch=='^' ||
						    ch=='&' || ch=='*' ||
						    ch=='(' || ch==')' || 
						    ch=='-' || ch=='_' ||
							ch=='+' || ch=='=') {
					   flagSpecial = 1;
				   }
				   
			   }// end of for------------------
			   
			   if(flagAlphabet+flagNumber+flagSpecial == 3) {
				   result = true;
			   }
			   
			   return result;
			   
		   }// end of if~else-----------------
		   
	   }// end of checkPasswd(String passwd)------------
	   	

	   // *** 키보드로 부터 입력받은 값이 양수일때만 리턴시켜주는 
	   //     메소드 생성하기
	   public static int getYangsu(Scanner sc) {
		   
		   int num = 0;
		   
		   try {
				 num = Integer.parseInt(sc.nextLine());
				  
		   } catch (NumberFormatException e) {
				  System.out.println(">>> 0 보다 큰수를 입력하세요!!");
		   }
		   
		   return num;
	   }// end of getYangsu(Scanner sc)--------------	
	   
	   
	public static String getPageBar(int sizePerPage, int blockSize, int totalPage, int currentShowPageNo, String url) {
		
		String pageBar = "";
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize)*blockSize + 1; 
		// 공식임!!!
		
		// currentShowPageNo 가 1~10 일때 pageNo 는   1 
		// currentShowPageNo 가 11~20 일때 pageNo 는 11
		// currentShowPageNo 가 21~30 일때 pageNo 는 21
		
		String str_pageNo = "";
		
		if (pageNo == 1) {
			str_pageNo = "&nbsp;[Before "+blockSize+" Page]";
		}
		else {
			str_pageNo = "&nbsp;<a href=\""+url+"?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"\" >"+"[Before "+blockSize+" Page]</a>&nbsp;"; 
		}
		
		pageBar += str_pageNo;
		
		while(!(pageNo > totalPage || loop > blockSize)){
			
			if (pageNo == currentShowPageNo)
				str_pageNo = "&nbsp;<span style=\"color:red; font-size:13pt; font-weight:bold; text-decoration:underline;\">"+pageNo+ "</span>&nbsp;";
			else
				str_pageNo = "&nbsp;<a href=\""+url+"?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"\" >"+pageNo+"</a>" + "&nbsp;";
			
			pageBar += str_pageNo; 
			
			pageNo++;
			loop++;
		}
		
		if (pageNo > totalPage) {
			str_pageNo = "&nbsp;[Next "+blockSize+" Page]";
		}
		else {
			str_pageNo = "&nbsp;<a href=\""+url+"?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"\" >"+"[Next "+blockSize+" Page]</a>&nbsp;"; 
		}
		
		pageBar += str_pageNo;	
		
		return pageBar;
		
	}// end of String getPageBar(int sizePerPage, int blockSize, int totalPage, int currentShowPageNo, String url)-----------------	   

	
	public static String getPageBarWithSearch(int sizePerPage, int blockSize, int totalPage, int currentShowPageNo, String colname, String search, String category, String url) {
		String pageBar = "";
		int loop = 1;
		int pageNo = ((currentShowPageNo - 1)/blockSize)*blockSize + 1; // 공식임!!!
		
		// currentShowPageNo 가 1~10 일때 pageNo 는   1 , 11~20 일때 pageNo 는 11 , 21~30 일때 pageNo 는 21
		
		String str_pageNo = "";
		
		if (pageNo == 1) {
			str_pageNo = "&nbsp;[Before "+blockSize+" Page]";
		} else {
			str_pageNo = "&nbsp;<a href=\""+url+"?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&colname="+colname+"&search="+search+"&category="+category+"\" >"+"[Before "+blockSize+" Page]</a>&nbsp;"; 
		}
		
		pageBar += str_pageNo;
		
		while(!(pageNo > totalPage || loop > blockSize)){
			
			if (pageNo == currentShowPageNo) {
				str_pageNo = "&nbsp;<span style=\"color:red; font-size:12pt; font-weight:bold; text-decoration:underline;\">"+pageNo+ "</span>&nbsp;";
			} else {
				str_pageNo = "&nbsp;<a href=\""+url+"?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&colname="+colname+"&search="+search+"&category="+category+"\" >"+pageNo+"</a>" + "&nbsp;";
			}
			pageBar += str_pageNo; 
			pageNo++;
			loop++;
		}
		
		if (pageNo > totalPage) {
			str_pageNo = "&nbsp;[Next "+blockSize+" Page]";
		} else {
			str_pageNo = "&nbsp;<a href=\""+url+"?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&colname="+colname+"&search="+search+"&category="+category+"\" >"+"[Next "+blockSize+" Page]</a>&nbsp;"; 
		}
		pageBar += str_pageNo;	
		
		return pageBar;
	}// end of String getPageBarWithSearch(int sizePerPage, int blockSize, int totalPage, int currentShowPageNo, String searchType, String searchString, String period, String url)--------------------	
	
	
	
	
	
	// **** 돌아갈 URL Page의 값을 알기 위해서 먼저 현재 URL 주소를 얻어오는 메소드 **** //
	public static String getCurrentURL(HttpServletRequest req) {
		String currentURL = req.getRequestURL().toString();  // ==> 확인용 currentURL => http://localhost:9090/MyMVC/memberList.do
		String method = req.getMethod();
		
		if ("GET".equalsIgnoreCase(method)) {  // GET 방식일 때만 ? 뒤에 주소값을 덧붙인다.
			String queryString = req.getQueryString();  // ==> 확인용 queryString => currentShowPageNo=3&sizePerPage=5	
			currentURL += "?" + queryString;  // ==> ==> 확인용 currentURL => http://localhost:9090/MyMVC/memberList.do?currentShowPageNo=3&sizePerPage=5
		} 	// GET이 아닐 경우는 주소값을 추가하지 않는다.
		
		int beginIndex = currentURL.indexOf(req.getContextPath());  // ==> 확인용 beginIndex => 21	
		int ctxNameLength = req.getContextPath().length();  // ==> 6	
		currentURL = currentURL.substring(beginIndex+ctxNameLength+ 1);  // ==> 확인용 currentURL => memberList.do?currentShowPageNo=3&sizePerPage=5
		
		return currentURL;
	}// end of static String getCurrentURL()-----------------------------------
	
	
		
}






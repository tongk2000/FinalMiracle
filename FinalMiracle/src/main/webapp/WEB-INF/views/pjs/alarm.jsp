<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
   
<script type="text/javascript">
	window.onload = function(){
		alert(${msg});
		var n = ${n};
		if(n == 1) {
				
			var arr="";
			var list = ${list};
			for(int i=0; i<list.length; i++) {
				var arr += list[i];
			}
		}
		
		
	}
</script>
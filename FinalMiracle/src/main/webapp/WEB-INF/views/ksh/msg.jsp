<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
    
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/BootStrapStudy/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

<script type="text/javascript">

	if(${msg != ""}){
		alert("${msg}");		
		
		/* swal({
		  title: "${msg}",
		  type: "info",
		  showCancelButton: true,
		  confirmButtonClass: "btn-primary",
		  confirmButtonText: "확인",
		},
		function(isConfirm) {
		  if (isConfirm) {
			  location.href="${loc}";
		  }
		}); */
	}
	
	location.href="${loc}";
	
	

</script>
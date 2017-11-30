<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/BootStrapStudy/css/bootstrap.css">
<script type="text/javascript" src="<%= request.getContextPath() %>/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%= request.getContextPath() %>/BootStrapStudy/js/bootstrap.js"></script> 
<%-- *** 구글맵 api 사용하기 *** --%>
<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAGoOx5t16lxp_DW2Y8WpN2gJB9U3fzPRg"></script>
<style>
	#div_name {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	#div_mobile {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
	#div_findResult {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;		
		position: relative;
	}
	#div_btnFind {
		width: 70%;
		height: 15%;
		margin-bottom: 5%;
		margin-left: 10%;
		position: relative;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		google.maps.event.addDomListener(window, 'load', initialize); // 구글사에서 그대로 따옴!!!
		function initialize(){ // 사용자가 커스텀마이즈 할 수 있다.
		    var mapOptions = { // 구글 맵 옵션 설정
		        zoom : 20, // 기본 확대율(줌 크기조절) , 숫자가 클수록 줌 크기가 확대되는 것이다. 숫자가 작아질 수록 광대역을 볼 수 있다.
		        center : new google.maps.LatLng(37.5338151, 126.89697839999997), // 처음 지도의 중앙 위치 세팅!!
		        //-------------------------------------------------------------------- 지도 옵션에 관련한 세부사항들
		        disableDefaultUI : false,  // 기본 UI(지도창에 나오는 부수적인 아이콘들, 없으면 지도만 나온다.) 비활성화 여부
		        scrollwheel : true,        // 마우스 휠로 확대, 축소 사용 여부
		        zoomControl : true,        // 지도의 확대/축소 수준을 변경하는 데 사용되는 "+"와 "-" 버튼을 표시
		        mapTypeControl : true,     // 지도 유형 컨트롤은 드롭다운이나 가로 버튼 막대 스타일로 제공되며, 사용자가 지도 유형(ROADMAP, SATELLITE, HYBRID 또는 TERRAIN)을 선택할 수 있다. 이 컨트롤은 기본적으로 지도의 왼쪽 위 모서리에 나타난다.
		        streetViewControl : true,  // 스트리트 뷰 컨트롤에는 지도로 드래그해서 스트리트 뷰를 활성화할 수 있는 펙맨 아이콘이 있다. 기본적으로 이 컨트롤은 지도의 오른쪽 아래 근처에 나타난다.
		        scaleControl: true,        // 배율 컨트롤은 지도 배율 요소를 표시한다. 이 컨트롤은 기본적으로 비활성화되어 있다.
		    };
		    // 구글맵 옵션내역 사이트 아래 참조 
		    // https://developers.google.com/maps/documentation/javascript/reference#MapOptions
		    var map = new google.maps.Map(document.getElementById('googleMap'), mapOptions);  // 구글 맵을 사용할 타겟
		    google.maps.event.addDomListener(window, "resize", function() { // 지도를 확대, 축소할 때 관련된 메서드
		        var center = map.getCenter();
		        google.maps.event.trigger(map, "resize");
		        map.setCenter(center); 
		    });
			var storeArr = [ // [] : 배열 	{} : 객체    // 디비서 호출한 위도, 경도, 매장이름!!! 
				<c:set var="cnt" value="1" />
				<c:forEach var="store" items="${mapList}" varStatus="status">					
				     [	// 이중배열은 안쪽의 배열을 하나의 객체로 바라본다.
				    	"${store.storeName}",
				    	"${store.latitude}",
				    	"${store.longitude}",
				    	"${store.zindex}"
					 ]
				     <c:if test="${cnt != mapList.size()}">
				     ,
				     </c:if>
				     <c:set var="cnt" value="${cnt + 1}" />   // 변수 cnt 를 1씩 증가
				</c:forEach>
			];
		    setMarkers(map, storeArr);	// 여기서 map은 지도 <div id="googleMap"	style="width: 100%; height: 360px; margin: auto;"></div>를 가리킴
		} // end of function initialize()--------------------------------
		// 이 문서가 실행이 되면 기본으로    var storeArr가 생성이 된다.
		var markerArr;  // 전역변수로 사용됨.
		function setMarkers(map, storeArr){ // 지도 값과 3이 들어간다.!!!!
			markerArr = new Array(storeArr.length); // 배열의 길이 3!!!
			for(var i=0; i < storeArr.length; i++){
				if(i == 0) { // 디비서 가져온 가계들마다 마커의 색을 각각 주기!!!!
					var image = "<%= request.getContextPath() %>/images/pointerBlue.png";  // 1번 마커 이미지	
				} 
				else if(i == 1) {
					var image = "<%= request.getContextPath() %>/images/pointerPink.png"; // 2번 마커 이미지
				}
				else {
					var image = "<%= request.getContextPath() %>/images/pointerBlue.png"; // 3번 마커 이미지
				}
				var store = storeArr[i]; // 배열의 하나의 객체 값을   var store에 담는다
				//  alert(store[0]);
				var myLatLng = new google.maps.LatLng(Number(store[1]), Number(store[2]));  
				// Number() 함수를 꼭 사용해야 함을 잊지 말자. 
				markerArr[i] = new google.maps.Marker({   // 마커 설정하기
					position: myLatLng,  // 마커 위치 (위도, 경도값을 넣어줌)
					map: map,			 // map (<div id="googleMap"	style="width: 100%; height: 360px; margin: auto;"></div>)
					icon : image,        // 마커 이미지
					title : store[0],    // 위에서 정의한 "${store.storeName}" 임 , 즉  디비의  가계이름!! 마커에 커서를 대면 이 이름이 나온다.
					zIndex : Number(store[3])  // Number() 함수를 꼭 사용해야 함을 잊지 말자. 기본으로 숫자가 작은게 먼저나오고 마커가 겹칠 때 어떤걸 보여줄지 설정하는 것이다.
				});
				markerListener(map, markerArr[i]);
			} // end of for------------------------------	
		}// end of setMarkers(map, locations)--------------------------
///////////////////////////////////////////////////////////////////////////////////////
    var infowindowArr = new Array();  // 풍선창(풍선윈도우) 여러개를 배열로 저장하기 위한 용도 
    // var infowindowArrIdx = 0;
// **** 마커를 클릭했을때 어떤 동작이 발생하게 하려면  
//      addListener() 이벤트 핸들러를 사용하여 이벤트 알림을 등록하면 된다. 
//      이 메소드는 객체, 수신할 이벤트, 지정된 이벤트가 발생할 때 호출할 함수를 인자로 받는다.
	function markerListener(map, marker){  // setMarkers 함수안에서  총 세번 반복되었음     
		// alert(marker.zIndex - 1);	//  0  1  2
		var infowindow = new google.maps.InfoWindow(  // 풍선창(풍선윈도우)만들기
				{// content: '안녕하세요~', 
				 // content: marker.title,	
				  content: viewContent(marker.title), // 사용자 지정 함수 viewContent(가게이름)
				  size: new google.maps.Size(100,100) 
				});
		infowindowArr.push(infowindow); // 풍선창(풍선윈도우)을 배열속에 집어넣기
		google.maps.event.addListener(marker, 'click', 
			 function(){ 
		                 // marker에(i번째 마커) click(클릭)했을 때 실행할 내용들...
		                 //alert(marker.zIndex);
		               goDetail(marker.zIndex);  // 매장번호(marker.zIndex)를 넘겨서 매장지점 상세정보 보여주기와 같은 팝업창 띄우기
			 /* var infowindow = new google.maps.InfoWindow(  // 풍선창(풍선윈도우)만들기
						{// content: '안녕하세요~', 
						 // content: marker.title,	
						  content: goContent(),
						  size: new google.maps.Size(100,100) 
						}); */
			  // alert(infowindowArrIdx);
					// 마커를 클릭하면 이전 마커의 모달창을 닫는 기능	
					  for(var i=0; i<markerArr.length; i++) {   // 생성된 마커의 갯수만큼 반복하여
						 if(i != (marker.zIndex - 1) ) { // 마커에 클릭하여 발생된 풍선창(풍선윈도우)을 제외한 나머지 다른 마커에 달린 풍선창(풍선윈도우)은
						 	infowindowArr[i].close();	 // 닫는다.
						 }
						 else if(i == (marker.zIndex - 1)) {     // 마커에 클릭하여 발생된 풍선창(풍선윈도우)은
							 infowindowArr[i].open(map, marker); // map 상에 표시되어 있는 marker 위에 띄운다.
						 }
					 }	 		
					// infowindowArr[infowindowArrIdx-2].open(map, marker);  // 풍선창(infowindowArr[infowindowArrIdx-2])을 map 상에 표시되어 있는 marker 위에 띄운다.
				    // infowindow.open(map, marker); // 풍선창(infowindow)을 map 상에 표시되어 있는 marker 위에 띄운다.
		  });  // end of google.maps.event.addListener()-------------------
		 // infowindowArrIdx++;
	}// end of function markerListener(map, marker)-----------
	function goDetail(v_pnum)
	{
		var url = "prodViewDetail.do?pnum="+v_pnum;
		window.open(url, "prodViewInfo",
				"width=500px, height=600px, top=50px, left=800px" );
	}
	function viewContent(title) {
		var html =  "<span style='color:red; font-weight:bold;'>"+title+"</span><br/>";
			html += "<a href='javascript:alert(\""+title+" 입니다.\");'>상세보기</a>"; // 오케이!!
		//	html += "<a href='javascript:goDetail("+zIndex+");'>상세보기</a>"; // 팝업창 띄우기
		return html;	
	}
	}); // end of $(document).ready()-------------------------
</script>
<%-- 화면에 나오는 창은 밑에 div 하나만 존재한다.!!! --%>
<div id="googleMap"	style="width: 100%; height: 360px; margin: auto;"></div>











    
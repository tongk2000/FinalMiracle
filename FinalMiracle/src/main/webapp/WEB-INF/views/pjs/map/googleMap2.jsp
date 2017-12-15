<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE>
<html>
<head> 
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyAk84OfDfwA7xmG8uiaFR0HcSXxrcuHfV4"></script>

<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/BootStrapStudy/css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/resources/jqueryuicss/jquery-ui.css" />

<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/jquery-2.0.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/BootStrapStudy/js/bootstrap.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/jqueryuijs/jquery-ui.js"></script>
 --%>
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
	body {overflow-Y:hidden;} 
</style>

<script type="text/javascript">
	$(document).ready(function() {
		$("#displayList").hide();	
	
		google.maps.event.addDomListener(window, 'load', initialize); // 구글사에서 그대로 따옴!!! ====== 구글맵 생성
		function initialize(){ // 사용자가 커스텀마이즈 할 수 있다.									    ====== 구글맵 처음 시작할 때
		    var mapOptions = { // 구글 맵 옵션 설정
		        zoom : 14, // 기본 확대율(줌 크기조절) , 숫자가 클수록 줌 크기가 확대되는 것이다. 숫자가 작아질 수록 광대역을 볼 수 있다.
		        center : new google.maps.LatLng(37.531333, 126.89856710000004), // 처음 지도의 중앙 위치 세팅!!
		        //-------------------------------------------------------------------- 지도 옵션에 관련한 세부사항들
		        disableDefaultUI : false,  // 기본 UI(지도창에 나오는 부수적인 아이콘들, 없으면 지도만 나온다.) 비활성화 여부
		        scrollwheel : true,        // 마우스 휠로 확대, 축소 사용 여부
		        zoomControl : true,        // 지도의 확대/축소 수준을 변경하는 데 사용되는 "+"와 "-" 버튼을 표시
		        mapTypeControl : true,     // 지도 유형 컨트롤은 드롭다운이나 가로 버튼 막대 스타일로 제공되며, 사용자가 지도 유형(ROADMAP, SATELLITE, HYBRID 또는 TERRAIN)을 선택할 수 있다. 이 컨트롤은 기본적으로 지도의 왼쪽 위 모서리에 나타난다.
		        streetViewControl : true,  // 스트리트 뷰 컨트롤에는 지도로 드래그해서 스트리트 뷰를 활성화할 수 있는 펙맨 아이콘이 있다. 기본적으로 이 컨트롤은 지도의 오른쪽 아래 근처에 나타난다.
		        scaleControl: true,        // 배율 컨트롤은 지도 배율 요소를 표시한다. 이 컨트롤은 기본적으로 비활성화되어 있다.
		    };
		    var map = new google.maps.Map(document.getElementById('googleMap'), mapOptions);  // <div>태그를 가리킨다. 
		    google.maps.event.addDomListener(window, "resize", function() { // 지도를 확대, 축소할 때 관련된 메서드
		        var center = map.getCenter();
		        google.maps.event.trigger(map, "resize");
		        map.setCenter(center); 
		    });
			var storeArr = [ // [] : 배열 	{} : 객체    // 디비서 호출한 위도, 경도, 매장이름!!! 
				<c:set var="cnt" value="1" />
				<c:forEach var="obj" items="${list}" varStatus="status">					
				     [	// 이중배열은 안쪽의 배열을 하나의 객체로 바라본다.
				    	"${obj.name}",
				    	"${obj.latitude}",
				    	"${obj.longitude}",
				    	"${obj.idx}",
				    	"${obj.team_idx}"
					 ]
				     <c:if test="${cnt != mapList.size()}">
				     ,
				     </c:if>
				     <c:set var="cnt" value="${cnt + 1}" />   // 변수 cnt 를 1씩 증가
				</c:forEach>
			];
		    setMarkers(map, storeArr);	// 여기서 map은 지도 <div id="googleMap"	style="width: 100%; height: 360px; margin: auto;"></div>를 가리킴
		} // end of function initialize()--------------------------------
		var markerArr;  // 전역변수로 사용됨.
		function setMarkers(map, storeArr){ // 지도 값과 3이 들어간다.!!!!
			markerArr = new Array(storeArr.length); // 배열의 길이 3!!!
			for(var i=0; i < storeArr.length; i++){
				var image = "<%= request.getContextPath() %>/resources/images/pointerYellow.png"; 
				var store = storeArr[i]; // 배열의 하나의 객체 값을   var store에 담는다
				var team_idx = store[4];
				//  alert(store[0]);
				var myLatLng = new google.maps.LatLng(Number(store[1]), Number(store[2]));   //   ===== 구글맵의 위도, 경도가짐
				// Number() 함수를 꼭 사용해야 함을 잊지 말자. 
				markerArr[i] = new google.maps.Marker({   // 마커 설정하기
					position: myLatLng,  // 마커 위치 (위도, 경도값을 넣어줌)
					map: map,			 // map (<div id="googleMap"	style="width: 100%; height: 360px; margin: auto;"></div>)
					icon : image,        // 마커 이미지
					title : store[0],    // 위에서 정의한 "${store.storeName}" 임 , 즉  디비의  가계이름!! 마커에 커서를 대면 이 이름이 나온다.
					zIndex : Number(store[3])  // Number() 함수를 꼭 사용해야 함을 잊지 말자. zIndex는 우선순위! 우선순위가 높은 마커가 
				});
				markerListener(map, markerArr[i], team_idx);
			} // end of for------------------------------	
		}// end of setMarkers(map, locations)--------------------------
	    var infowindowArr = new Array();  // 풍선창(풍선윈도우) 여러개를 배열로 저장하기 위한 용도 
		function markerListener(map, marker, team_idx){  // setMarkers 함수안에서  총 세번 반복되었음     
			// alert(marker.zIndex - 1);	//  0  1  2
			var infowindow = new google.maps.InfoWindow({  // 풍선창(풍선윈도우)만들기
					  content: viewContent(marker.title), // 사용자 지정 함수 viewContent(가게이름)
					  size: new google.maps.Size(100,100) 
			});
			infowindowArr.push(infowindow); // 풍선창(풍선윈도우)을 배열속에 집어넣기
			google.maps.event.addListener(marker, 'click', 
				 function(){ 
			               //alert("team_idx"+team_idx);
			               goDetail(marker.zIndex, team_idx);  // 매장번호(marker.zIndex)를 넘겨서 매장지점 상세정보 보여주기와 같은 팝업창 띄우기
						// 마커를 클릭하면 이전 마커의 모달창을 닫는 기능	
						for(var i=0; i<markerArr.length; i++) {   // 생성된 마커의 갯수만큼 반복하여
							if(i != (marker.zIndex - 1) ) { // 마커에 클릭하여 발생된 풍선창(풍선윈도우)을 제외한 나머지 다른 마커에 달린 풍선창(풍선윈도우)은
								infowindowArr[i].close();	 // 닫는다.
							}
							else if(i == (marker.zIndex - 1)) {     // 마커에 클릭하여 발생된 풍선창(풍선윈도우)은
							 infowindowArr[i].open(map, marker); // map 상에 표시되어 있는 marker 위에 띄운다.
							}
						}	 		
			  });  // end of google.maps.event.addListener()-------------------
		}// end of function markerListener(map, marker)-----------
		
		
		function goDetail(map_idx, map_team_idx) // 모달창을 띄우자
		{
			var data_form = {"map_idx":map_idx, "map_team_idx":map_team_idx};
			alert("map_idx"+map_idx+" map_team_idx"+map_team_idx);
			$.ajax({
				url:"googleMapTeamInfoJSON.mr",
				type:"get",
				data:data_form,
				dataType:"html",
				success : function(data){
					if(data.length > 0) { // 검색된 데이터가 있는 경우라면
						$("#mapInfo").html(data);
						$("#mapInfo").modal(); // 이게 그 뭐더냐 모달열기
					}
					else {
						alert("여기옴?");
					}
				},
				error : function() {
					alert("에러");
				}
			}); // end of $.ajax 
		}
		function viewContent(title) {
			var html =  "<span style='color:red; font-weight:bold;'>"+title+"</span><br/>";
				html += "<a href='javascript:alert(\""+title+" 입니다.\");'>상세보기</a>";
			return html;	
		}
		$("#searchString").keyup(function(){
			$("#displayList").show();
			var data_form = {"searchString":$("#searchString").val(),
							 "choice":$("#choice").val()};
			$.ajax({
				url:"googleMapJSON.mr",
				type:"get",
				data:data_form,
				dataType:"json",
				success : function(data){
					var resultHTML ="";
					if(data.length > 0) { // 검색된 데이터가 있는 경우라면
						$.each(data, function(entryIndex, entry){
							var wordstr = entry.searchString;
							var index = wordstr.toLowerCase().indexOf( $("#searchString").val().toLowerCase() );
							var len = $("#searchString").val().length;
							var result = "";
							result = "<span class='first' style='color:blue;'>" +wordstr.substr(0, index)+ "</span>" + "<span class='second' style='color:black; font-weight:bold;'>" +wordstr.substr(index, len)+ "</span>" + "<span class='third' style='color:blue;'>" +wordstr.substr(index+len, wordstr.length - (index+len) )+ "</span>";  
							resultHTML += "<span class='one' style='cursor:pointer;'>"+ result +"</span><br/>"; 
						}); // end of each
					}
					else {
					}
					$("#displayList").html(resultHTML);
					$("#displayList").show();	
				},
				error : function() {
				}
			}); // end of $.ajax
		}); // end of $("#searchString").keyup
		$("#goSearch").click(function(){
			var frm	= document.map;
			frm.choice.value = $("#choice").val();
			frm.searchString.value = $("#searchString").val();
			frm.action="<%=request.getContextPath()%>/googleMap.mr";
			frm.method="get";
			frm.submit();
		})
		$("#searchString").keydown(function(){
			var key = event.keyCode;
			if(key == 13) {
				$("#goSearch").trigger("click");
			}
		});
		$("#displayList").click(function(event){
			var word = "";
			var $target = $(event.target);
			if($target.is(".first")) {
				word = $target.text() + $target.next().text() + $target.next().next().text();
			}
			else if($target.is(".second")) {
				word = $target.prev().text() + $target.text() + $target.next().text();
			}
			else if($target.is(".third")) {
				word = $target.prev().prev().text() + $target.prev().text() + $target.text();
			}
			$("#searchString").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
			$("#displayList").hide();
		});
		keep();
		teamCall();
	}); // end of $(document).ready()-------------------------
	function keep() {
		<c:if test="${choice!=null&&choice!=''}">
			$("#choice").val("${choice}");
		</c:if>
		<c:if test="${searchString!=null&&searchString!=''}">
			$("#searchString").val("${searchString}");
		</c:if>
	}
	function launchMap() {
		$("#launchMapModal").modal();
	}
	function launchGoogleMap(){
		window.open("googleMapbasic.mr", "subwinpop", "left=300px, top=300px, width=600px, height=600px");
	}
	function teamCall(){
		$.ajax({
			url: "tmFooter.mr",
			type: "GET",
			dataType: "JSON",
			success: function(data){
				var name = data[0].name;
				var tel1 = data[0].tel1;
				var tel2 = data[0].tel2;
				var tel3 = data[0].tel3;
				var post1 = data[0].post1;
				var post2 = data[0].post2;
				var addr1 = data[0].addr1;
				var addr2 = data[0].addr2;
				var regdate = data[0].regdate;
				var img = data[0].img
				var leader = data[0].leader
				
				$("#tm").empty();
				
				var html = "";
				<%-- html <img src="<%= request.getContextPath() %>/resources/files/20171208183923121001009307995.jpg" style="width:200px; heigth:200px;" /> --%>
				html += "<div style='float:left'><img src='<%= request.getContextPath() %>/resources/files/"+img+"' height='150px;' width='150px;'></div><br/>";
				html += "<div style='float:right; margin-right:310px;	'>팀 이름 : " + name + "</div><br/>";
				html += "설립자 : " + leader + "<br/>";
				html += "전화번호 : " + tel1 + "-" + tel2 + "-" + tel3 + "<br/>";
				html += "우편번호 : " + post1 + "-" + post2 + "<br/>";
				html += "주소 : <a onClick='launchGoogleMap();'>" + addr1 + " " + addr2 + "</a><br/>";
				html += "설립일 : " + regdate + "<br/>";
				
				$("#tm").html(html);
			}, error: function(request, status, error){
				alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
			}
		});
	}
</script>
</head>
<body>

<div style="width:100%; height:500px; border:4px dotted red; "> 
	<div style="border:4px dotted skyblue; width:50%; height:250px; float: left;" align="center">
		
		<div style="border:4px dotted blue; width:100%; float: left;"> 
			<span >회사정보</span>
			<div id="tm" style="border:4px dotted green; margin-top:50px; width:100%;"></div>
		</div>
	</div>
	
	<div style="border:4px dotted yellow; width:50%; height: 250px; float: right;">
		<span> 당산 : 서울특별시 영등포구 선유동2로 57 이레빌딩 (구관) 19F, 20F </span>
		<div align="center">
			<img src="<%= request.getContextPath() %>/resources/images/당산이미지.PNG" style="width:400px; height:200px; margin-top:5px;"/>
		</div>
	</div>
	
	<div align="center">
		<div id="googleMap" style="width: 900px; clear:both; height: 450px; border:1px solid red" ></div>
	  
	 	<form name="map">
			<input type="hidden" name="choice">
			<input type="hidden" name="searchString">
		</form>
		
		<select id="choice" name="choice" style="font-size:12pt; margin-top:10px;">
			<option value="0" selected> 전체</option>
			<option value="1" >팀정보</option>
			<option value="-1">맛집정보</option>
		</select>
		
		<input type="text" name="searchString" id="searchString" />
		<button type="button" id="goSearch">검색</button>
		
		<div >
			<div id="displayList" style="background-color:white; border:2px solid gray; width:175px;  margin-left:45px;	 z-index:500;"></div>
		</div>
	</div> 
</div>

<div style="border: 2px solid blue;"> 
	<div class="modal-body" id="launchMapBody" style="border:2px gray dotted; overflow-x:hidden;overflow-y:hidden "  align="center">
		<div class="modal fade" id="mapInfo" role="dialog"></div>
	</div>
</div>
</body>
</html>
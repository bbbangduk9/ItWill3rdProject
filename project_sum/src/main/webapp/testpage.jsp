<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>testPage</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
	    // 서버에서 받은 isLogged 값을 이용하여 버튼 표시 결정
	    let isLogged = "${isLogged}";
	    console.log(isLogged);
	    console.log(isLogged !== '');
	 	// 구독 버튼과 구독 중 버튼을 숨깁니다.
	    $('#subscribeInBtn').css('display', 'none');
	    if (isLogged !== '') {
	 	$('#subscribeBtn').css('display', 'none');
	    
		    if (isLogged === "subscribeOn") {
		    	$('#subscribeBtn').css('display', 'block');
		    } else if (isLogged === "subscribeOff") {
		    	$('#subscribeInBtn').css('display', 'block');
		    } else if (isLogged === "subscribeFalse"){
		        // isLogged가 false인 경우, 구독 버튼을 비활성화
		        $('#subscribeBtn').prop('disabled', true);
		    }
	    }
	    
	});
	// 현재 페이지의 URL을 캡쳐하여 새로고침 시도 시에 리다이렉션
	if (window.performance) {
	  if (performance.navigation.type === 1) {
	    window.location.href = window.location.href;
	  }
	}  
</script>
</head>
<body>
<a href="main.do">메인페이지 이동</a>

<a>구독test</a>
<form action="subscribeSelect.do" method="POST">
	<input type="text" name="channelOwnerId" value="hong12">
	<input type="submit" value="구독" id="subscribeBtn">
	<input type="submit" value="구독중" id="subscribeInBtn">
	
</form>
</body>
</html>
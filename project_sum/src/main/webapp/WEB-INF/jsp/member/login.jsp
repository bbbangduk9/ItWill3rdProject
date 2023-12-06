<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
</head>
<link rel="stylesheet" type="text/css" href="/ft/resources/css/login.css">
<body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<img src="iconImage/home_Image.png" onclick="location.href='main.do'" id="moveHome">

<div id="container">
	<div id = "centerform">
		<div class="one">
				<h1>로그인</h1>
		</div>
		<div class = "login">
			<div>
			<br>
				<input type="text" class="id_line" name="memberId" id="Id" placeholder="아이디"
				title="아이디" class="input_text" maxlength="41">
			</div>
			<div>
				<input type="password" name="pwd" id="password" class = "pwd_line" placeholder="비밀번호"
				title="비밀번호" class="input_text" maxlength="41">
			</div>
			<div>
				<button id="btn_login" class="btn_login">로그인</button>
			</div>
			<div id="fontsize">
				<a href="joinMemberShip.do" class = "find_text">회원가입 / </a>
				<a href="findID.do" class = "find_text">아이디 찾기 / </a>
				<a href="findPwd.do" class = "find_text">비밀번호 찾기</a>
			<div>
		</div>
			<form id="redirectForm" method="post" action="main.do">
			</form>
	</div>
</div>
</body>
<script>
	// 입력란이 포함된 form 요소를 찾습니다.
	const form = document.querySelector('.login');
	// form에서 Enter 키를 누르면 실행되는 함수를 추가합니다.
	form.addEventListener('keypress', function(e) {
	  if (e.key === 'Enter') {
		  $('#btn_login').click();
	  }
	});

	$(document).ready(function () {
	    $('#btn_login').click(function() {
	        let pwd = $('#password').val();
	        let Id = $('#Id').val();
	        console.log("memberId : " + Id)
	        console.log("pwd : " + pwd);
	        $.ajax({
	            type : 'post',
	            url : 'loginCheck.do',
	            data : {"memberId" : Id, "pwd" : pwd},
	            success : function (data) {
	            	code = data;
	                console.log(data);
	                if(data.status === 2){
	                	alert("정지된 계정입니다. 관리자에게 문의바랍니다.");
	                	return;
	                }
	                if(data === ""){
	                	alert("로그인에 실패하였습니다.");
	                	return;
	                } else{
	                	alert("로그인에 성공하였습니다.");
	                	$('#redirectForm').submit();
	                }
	               
	            }
	        }); // end ajax
	    });
	});


</script>
</html>
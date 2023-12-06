<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/faq.css" rel="stylesheet">
  <title>자주묻는질문</title>
</head>
<body>

<h1>자주 묻는 질문</h1>

	<div id="Accordion_wrap">
	     <div class="que">
	      <span>로그인이 안되는 경우</span>
	       <div class="arrow-wrap">
	         <span class="arrow-top">↑</span>
	        <span class="arrow-bottom">↓</span>
	       </div>
	     </div>
	     <div class="anw">
	      <span>아이디와 비밀번호를 정확히 입력했는지 확인하세요.</span>
	      <span>대소문자를 확인하세요.</span>
	     </div>
	      <div class="que">
	      <span>영상재생에 문제가 있는 경우.</span>
	     </div>
	     <div class="anw">
	      <span>인터넷 속도를 확인해보세요.</span>
	      <span>새로고침 후 재접속을 해보세요.</span>
	     </div>
	      <div class="que">
	      <span>회원 가입을하고싶어요.</span>
	     </div>
	     <div class="anw">
	      <span><a href="joinMemberShip.do">회원가입으로 가기</a></span>
	     </div>
	      <div class="que">
	      <span>아이디 찾기/비밀번호 찾기를 하고싶어요.</span>
	     </div>
	     <div class="anw">
	      <span><a href="findID.do">아이디 찾기로 가기</a></span>
	      <span><a href="findPwd.do">비밀번호 찾기로 가기</a></span>
	     </div>
	     <a href="main.do">메인으로 돌아가기</a>
	</div>
<script>
$(".que").click(function() {
	   $(this).next(".anw").stop().slideToggle(300);
	  $(this).toggleClass('on').siblings().removeClass('on');
	  $(this).next(".anw").siblings(".anw").slideUp(300); // 1개씩 펼치기
	});
</script>
 </body>

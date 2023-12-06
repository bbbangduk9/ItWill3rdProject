<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<title>채널 세부정보</title>
</head>
<body>
	<div class="container mt-4">
		<p class="mb-3" style="font-size:20px; font-weight:bolder">정보</p>
		
		<h3 class="mt-1 mb-2" style="font-size:21px; font-weight:bold;">채널 세부 정보</h3>
		<br>
		<p><img src="resources/images/icon/internet.png" width="20px" height="20px">&nbsp;&nbsp;&nbsp;<a style="text-decoration: none; cursor: pointer;" onclick="goMyChannel()">http://localhost:8080/ft/myChannel.do</a></p>
		<p><img src="resources/images/icon/sub.png" width="20px" height="20px">&nbsp;&nbsp;&nbsp;구독자 ${mySub }명</p> 
		<p><img src="resources/images/icon/play.png" width="20px" height="20px">&nbsp;&nbsp;&nbsp;동영상 ${myVideoCount }개</p> 
		<fmt:formatNumber var="viewss" value="${myViews }" type="number" />
		<p><img src="resources/images/icon/views.png" width="20px" height="20px">&nbsp;&nbsp;&nbsp;조회수 ${viewss }회</p> 
		<p><img src="resources/images/icon/info.png" width="20px" height="20px">&nbsp;&nbsp;&nbsp;가입일: ${vo.regDate }</p>
		
	</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script> 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>	
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script>
	function goMyChannel() {
		opener.location.href = "myChannel.do";
		self.close();
	}
</script>

</body>
</html>
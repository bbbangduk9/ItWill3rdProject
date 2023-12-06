<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구독리스트</title>
<script>
	function moveSubscribe(memberId) {
	    location.href="channel.do?memberId=" + memberId;
	}
</script>
</head>
<body>
	<h2>구독리스트</h2>
	<table>
		<c:forEach var="svo" items="${titles }">
		<tr class="hoverPoint" onclick="moveSubscribe('${svo.memberId}')">
			<th><img src="profileImage/${svo.image }" alt="프로필사진" style="width:200px; height:200px; border-radius: 50%;"></th>
			<th style="font-size: 30px; width:200px;">${svo.title }</th>
		</tr>
		</c:forEach>
	</table>
</body>
</html>
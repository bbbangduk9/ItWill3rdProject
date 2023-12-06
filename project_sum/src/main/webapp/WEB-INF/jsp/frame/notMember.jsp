<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌측 프레임</title>
<style>
	table {
		border-collapse: collapse;
	}
	tr {
		height: 40px;
	}
	table, th, td {
    	border-spacing : 0;
    	padding: 0;
    	margin: 0;
    }
</style>
<script>
	
</script>
</head>
<body>
		<table>
		<tr class="hoverBackground" onclick="location.href='main.do'">
			<th><img src="iconImage/home.png" style="width: 30px;"></th>
			<td>홈</td>
	    </tr>
	    <tr class="hoverBackground" onclick="location.href='login.do'">
	    <th><img src="iconImage/mychannel.png" style="width: 30px;"></th>
			<td>내 채널</td>
	    </tr>
	    <tr class="hoverBackground" id="subscribeBtnFrame" onclick="location.href='login.do'">
	    <th><img src="iconImage/Subscription.png" style="width: 30px;"></th>
			<td>구독</td>
	    </tr>
	    <tr class="hoverBackground" onclick="location.href='login.do'">
	    <th><img src="iconImage/like.png" style="width: 30px;"></th>
			<td>좋아요 표시한 동영상</td>
	    </tr>
	</table>
	<table>
			<tr class="hoverBackground">
				<!-- 장르 카테고리  -->
			</tr>
		</table>
		<table>
			 <tr class="hoverBackground" onclick = "location.href='faqQna.do'">
	    <th><img src="iconImage/question.png" style="width: 30px;"></th>
			<td>자주묻는 질문</td>
	    </tr>
	     <tr class="hoverBackground" onclick="location.href='getQnaList.do'">
	    <th><img src="iconImage/Subscription.png" style="width: 30px;"></th>
			<td>고객센터</td>
	    </tr>
		</table>
		      <br><br>
      <jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
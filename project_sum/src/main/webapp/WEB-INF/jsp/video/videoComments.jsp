<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 댓글 조회</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<table>
		<thead>
		<tr>
			<th>아이디</th>
			<th>댓글내용</th>
			<th>작성날짜</th>
		</tr>
		</thead>
		<tbody>
			<c:forEach var="comments" items="${comments}">
				<tr>
					<th>${comments.memberId }</th>
					<th>${comments.cregdate }</th>
				</tr>
				<tr>
					<td>${comments.comments }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>
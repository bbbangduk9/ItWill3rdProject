<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <title>FakeTube Main Page</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

</head>
<body>
	<div class="container-fluid">
		<table class="table">
			<thead>
				<tr>
					<th>번호</th>
					<th>썸네일</th>
				</tr>
				<tr>
					<th>제목</th>
					<th>게시일자</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="video" items="${videoList }">
					<tr>
						<td width="50">${video.videoIdx }</td>
						<td width="150" height="120">
							<a href="getVideo.do?videoIdx=${video.videoIdx }">
								<img src="thumimgs/${video.vimage }" width="150" height="120">
							</a>	
						</td>
					</tr>
					<tr>
						<td id="vt">${video.vtitle }</td>
						<td id="vrd">${video.vregdate }</td>
					</tr>
				</c:forEach>
				<c:if test="${empty videoList }">
				<tr>
					<td colspan="2" class="center">데이터가 없습니다</td>
				</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script> 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>	
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>   

</body>
</html>
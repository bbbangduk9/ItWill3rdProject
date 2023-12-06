<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글등록</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/icofont/1.0.1/css/icofont.css">
<link href="${pageContext.request.contextPath}/resources/css/insertQna.css" rel="stylesheet">
<style>

</style>
</head>
<body>
<div id="container">
	<h1>글등록</h1>
	<p><a href="logout.do">로그아웃</a></p>
	
	<form action="insertQna.do" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<th width="70">제목</th>
				<td>
					<input type="text" name="qtitle">
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="memberId" value="${vo.memberId}" readonly>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="content" rows="10" cols="40"></textarea>
				</td>
			</tr>
			<tr>
				<th>업로드</th>
				<td>
					<input type="file" name="uploadFile">
				</td>
			</tr>
			<tr>
				<td colspan="2" class="center">
					<input type="submit" value="새글 등록">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<label for="secret">비밀글 여부:</label>
         		   <input type="checkbox" id="secret" name="secret" value="Y"> 
				</td>
			</tr>
		</table>
	</form>
	<p>
		<a href="getQnaList.do">글 목록 가기</a>
		
	</p>
	
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<script>
function upCommentDateForm() {
    var comments = document.forms["upCommentForm"]["comments"].value;
	
    console.log(comments);
    
    if (comments == "") {
        alert("댓글을 기입하셔야합니다");
        return false; // 폼 제출 방지
    }

    return true; // 폼 제출 허용
}
</script>
<body>

<div>
	<form name="upCommentForm" action="updateComment.do" method="post" onsubmit="return upCommentDateForm()">
			<input type="hidden" name="videoIdx" value="${comment.videoIdx }" readonly>
			<input type="hidden" name="commentIdx" value="${comment.commentIdx }" readonly>
			<textarea rows="10" cols="100" name="comments" title="댓글">${comment.comments }</textarea>
			<br/>
			<input type="submit" value="수정하기"/>
	</form>
</div>

</body>
</html>
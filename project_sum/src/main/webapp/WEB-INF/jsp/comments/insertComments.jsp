<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 작성</title>
</head>
<body>
<script>
function commentDateForm() {
    var comments = document.forms["commentForm"]["comments"].value;
	
    console.log(comments);
    
    if (comments == "") {
        alert("댓글을 기입하셔야합니다");
        return false; // 폼 제출 방지
    }

    return true; // 폼 제출 허용
}
</script>
<div>
	<form name="commentForm" action="insertComments.do" method="post" onsubmit="return commentDateForm()">
		<p>
		    <input type="hidden" name="memberId" value="${vo.memberId }" readonly>
		</p>
		<p>
			<textarea rows="5" cols="100" name="comments"></textarea>
		</p>
		<p>
			<input type="hidden" name="videoIdx" value="${video.videoIdx }">
			<button type="submit">댓글 작성</button>
		</p>
	</form>
</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>Insert title here</title>
</head>
<script>
$(document).ready(function() {
    alert("비밀번호가 변경되었습니다.");
    var form = $('<form action="login.do" method="post"></form>');
    $('body').append(form);
    form.submit();
});
</script>
</html>
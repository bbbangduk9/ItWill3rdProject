<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function membersListMaster(){
		$.ajax({
            url: 'getMasterList.do',
            type: 'POST',
            success: function (response) {
                $('#subscribeList').html(response);
            },
            error: function (xhr, status, error) {
                console.error('Error while fetching subscribe.do:', error);
            }
        });
	}
</script>
</head>
<body>
	<table>
		<tr class="hoverBackground" onclick="location.href='main.do'">
			<th><img src="iconImage/home.png" style="width: 30px;"></th>
			<td>홈</td>
	    </tr>
	    <tr class="hoverBackground" onclick="membersListMaster()" id="membersListMasterBtn">
	    <th><img src="iconImage/member.png" style="width: 30px;"></th>
			<td>회원관리</td>
	    </tr>
	    <tr class="hoverBackground" onclick="location.href='faqQna.do'">
	    <th><img src="iconImage/question.png" style="width: 30px;"></th>
			<td>자주묻는질문</td>
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
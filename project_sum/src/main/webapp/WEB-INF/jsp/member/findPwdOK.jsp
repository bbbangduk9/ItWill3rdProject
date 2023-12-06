<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="/ft/resources/css/findPwdOK.css">
<title>비밀번호 재설정</title>
</head>
<body>
	<div id = "centerdiv">
		<form action="findPwdOKOK.do" method="post" class="formcenter" id = "container">
			<div class="one">
				<h1>비밀번호 재설정</h1>
			</div>
				<br>
	        <table>
	            <tr>
	                <th>비밀번호</th>
	                <td><input type="password" name="pwd1" id="pwd1"></td>
	            </tr>
	            <tr>
	                <th>비밀번호 확인</th>
	                <td>
	                    <input type="password" name="pwd2" id="pwd2">
	                </td>
	            </tr>

	        </table>
	        <span id="check"></span>
	        <div>
				<input type="submit" value="확인" id="submitButton" disabled>
			</div>
	    </form>
	</div>
<script>
		//ajax로 controller로 비밀번호값 전송

		$('#submitButton').click(function(){
		const pwd = $('#pwd2').val();
			$.ajax({
				type : "get",
				url : "findPwdOKOK.do",
				data : {"pwd" : pwd},
				success : function(data){
					console.log(data);
				},
				error : function(){
					console.log("데이터 넘기기 못함");
				}
			}); // end ajax
		})

		
        // 비밀번호 입력 필드의 값이 변경될 때마다 호출되는 함수
        function checkPasswordMatch() {
            const pwd1 = $('#pwd1').val();
            const pwd2 = $('#pwd2').val();
            const $resultMsg = $('#check');
            // 비밀번호가 일치하는 경우 버튼 활성화
	            if (pwd1 === pwd2 && pwd1.length >= 6 && pwd2.length >= 6) {
	            	$resultMsg.html('비밀번호가 일치합니다.');
	            	$resultMsg.css('color','green');
	                $('#submitButton').prop('disabled', false);
	            } else if(pwd1.length < 6 && pwd2.length < 6){
	                $('#submitButton').prop('disabled', true);
	            	$resultMsg.html('비밀번호 최소 6자리 이상 입력해주세요');
	            	$resultMsg.css('color','red');
	            }else{
	            	$resultMsg.html('비밀번호가 일치하지 않습니다.');
	            	$resultMsg.css('color','red');
	            }
        }

        // 비밀번호 입력 필드 값 변경 이벤트에 함수 연결
        $('#pwd1, #pwd2').on('input', checkPasswordMatch);
</script>
</html>
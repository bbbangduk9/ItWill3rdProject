<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/ft/resources/css/findPwd.css">
<body>   
	<div class="centerdiv">
		<form class="container" action = "findPwdOK.do" method = "post">
			<div class="one">
				<h1>비밀번호 찾기</h1>
			</div>
			<div>
				<input type="text" name = "memberId" placeholder="아이디" id = "memberId">
			</div>
				<div class="input-group">
					<input type="text" class="form-control" name="email" id="email" placeholder="이메일" >
					<select class="form-control" name="email2" id="email2" >
						<option>@naver.com</option>
						<option>@daum.net</option>
						<option>@gmail.com</option>
						<option>@hanmail.com</option>
						<option>@yahoo.co.kr</option>
						<option>@test.com</option>
					</select>
					<button type="button" class="btn btn-primary" id="mail-Check-Btn">이메일 전송</button>
				</div>
				
				<div class="mail-check-box">
					<input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6">
				</div>
				<div>
					<input type ="button" value="비밀번호 재설정" id = "OK" disabled="disabled" onclick="pwdButton()">
				</div>
				<span id="mail-check-warn"></span>
		</form>
	</div>
</body>
<script>

	function pwdButton(){
		let memberId = $('#memberId').val();
		let email = $('#email').val() + $('#email2').val()
		location.href = "findPwdOK.do?memberId=" + memberId + "&email=" + email;
	}
	
	$('#mail-Check-Btn').click(function() {
		const email = $('#email').val() + $('#email2').val(); // 이메일 주소값 얻어오기!
		console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
		const memberId = $('#memberId').val()
		console.log("아이디 : " + memberId);
		const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
		
		$.ajax({
			type : 'get',
		 	url : 'findOKPwd.do',
		 	data : {"email" : email,
		 			"memberId" : memberId},
			success : function (data) {
				code = data;
				console.log("data : " + data);
				if(data === ""){
					alert("입력하신 정보가 올바르지 않습니다.");
				}else{
					alert("이메일 인증번호가 발송되었습니다.");
					checkInput.attr('disabled',false);
					$('#memberId').prop('readonly',true);
					$('#email').prop('readonly',true);
					$('#email2').prop('disabled',true);
				}
			}
		}); // end ajax
	}); // end send email

	
	// 인증번호 비교 
	// blur -> focus가 벗어나는 경우 발생
	$('.mail-check-input').blur(function () {
		const inputCode = $(this).val();
		const $resultMsg = $('#mail-check-warn');
		
		if(inputCode === code){
			$resultMsg.html('인증번호가 일치합니다.');
			$resultMsg.css('color','green');
			$('#mail-Check-Btn').attr('disabled',true);
			
			$('#OK').attr('disabled',false);
			
			$('#email').attr('readonly',true);
			$('#email2').attr('readonly',true);
			$('#email').attr('onFocus', 'this.initialSelect = this.selectedIndex');
	         $('#email2').attr('onChange', 'this.selectedIndex = this.initialSelect');
		}else{
			$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
			$resultMsg.css('color','red');
		}
	});
	
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" type="text/css" href="/ft/resources/css/findID.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.popup-wrap{
  background-color:rgba(0,0,0,.3); 
  justify-content:center;
  align-items:center;     
  position:fixed;         
  top:0;
  left:0;
  right:0;
  bottom:0;               
  display:flex;
  padding:15px; 
}

</style>
</head>

<body>   
	<div class="centerdiv">              
		<form class="container" action = "findIDOK.do" method = "post">
			<div class = "modal">
			
			</div>
			<div class="one">
				<h1>아이디 찾기</h1>
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
					<input type ="button" value="아이디 찾기" id = "OK" disabled="disabled">
				</div>
				<span id="mail-check-warn"></span>
		</form>
	</div>
</body>
<script>

	$('#mail-Check-Btn').click(function() {
		const email = $('#email').val() + $('#email2').val(); // 이메일 주소값 얻어오기!
		console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
		const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
		$.ajax({
			type : 'get',
		 	url : 'findOK.do', // 
		 	data : {"email" : email },
			success : function (data) {
				code = data;
				console.log("data : " + data);
				if(data === ""){
					alert("이메일이 존재하지 않습니다.");
					checkInput.attr('disabled',true);
				}else{
					alert("이메일 인증번호가 발송되었습니다.");
					checkInput.attr('disabled',false);
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
			
			$('#email').attr('onFocus', 'this.initialSelect = this.selectedIndex');
	         $('#email2').attr('onChange', 'this.selectedIndex = this.initialSelect');
		}else{
			$resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
			$resultMsg.css('color','red');
		}
	});
	
	//----------------
	
	$('#OK').click(function(){
		$.ajax({
			type : 'post',
		 	url : 'findIDOK.do',
			success : function (data) {
				code = data;
				if(data === ""){
					alert("Error : data 전송 실패");
					checkInput.attr('disabled',false);
				}else{
					$(".modal").html(data);
					console.log(code);
				}
			},
			error : function(request,status,error){
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		})
	})
	
</script>
</html>
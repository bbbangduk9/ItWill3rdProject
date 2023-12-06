<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>

#centerdivID{
	background-color: white;
	border-radius: 40px;
}

.layer_common {
	width : 50%;
    position: fixed;
    margin-left : 100px;
    -webkit-box-sizing: border-box;
    box-sizing: border-box;
    padding: 19px 19px 24px;
    border: 1px solid #e6e6ea;
    border-radius: 10px;
    background-color: #fff;
    -webkit-box-shadow: 0 2px 4px 0 rgba(107, 119, 172, 0.1);
    box-shadow: 0 2px 4px 0 rgba(107, 119, 172, 0.1);
    z-index: 10;
    align-items: center;
}
.layer_message{
	color: green;
}

</style>
</head>
<body>
	<%-- <div class = "centerdiv" id="centerdivID">
		<form class ="conatainer" method="post" action="login.do">
			<div class="one">
				<h1>가입한 아이디 는 "${id }" 입니다.</h1>
			</div>
			<input type = "submit" class="login_btn" value = "로그인페이지로 이동">
		</form>
	</div> --%>
	
	<form method = "post" action="login.do" id="formmodal">
		<div class = "layer_common">
		<em class="icon_warning">
			<span class="blind">아이디 찾기 결과</span>
		</em>
		<h3 class="layer_title">아이디는</h3>
		<strong class="layer_message">
			${id }
		</strong>
			입니다.
		<br>
		<br>
		<input type="submit" value="확인" class="button_layer_confirm">
		</div>
	</form>
</body>
</html>
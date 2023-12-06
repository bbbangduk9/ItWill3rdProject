<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- <link rel="stylesheet" type="text/css" href="css/realname_dark_min.css">
<link rel="stylesheet" type="text/css" href="css/realname_min.css">	 -->
   <meta charset="UTF-8">
   <title>FAKE_TUBE : 회원가입</title>
</head>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<body>
	<div id = "container">
	    <form name="frm" action="memberRegistGO.do" method="post">
	        <fieldset>
	                <input type="checkbox" name="accept" id="accept1">
	                <label for="accept">이메일 수신 동의하기</label>
	            <div>
					이메일인증이 완료 되었을경우, 해당 코드가 이메일로 전송이 됩니다.
	            </div>
	             <input type="checkbox" name="accept" id="accept2">
	             <label for="accept">동영상 재생 관련 이용약관</label>
	            <div>
					동영상 재생 관련 이용약관을 동의하시면,
					원하는 장르의 동영상을 시청하실 수 있습니다.
	            </div>
	            
	            <p>
	                <input type="submit" value="다음" name="all" disabled="disabled">
	            </p>
	        </fieldset>
	    </form>
    </div>
</body>
<script>
	$(document).ready(function() {
	    // 체크박스 상태를 확인하고 "다음" 버튼을 활성화 또는 비활성화하는 함수
	    function checkCheckboxes() {
	        var checkbox1 = $("#accept1").prop("checked");
	        var checkbox2 = $("#accept2").prop("checked");
	
	        // 두 체크박스가 모두 선택된 경우 "다음" 버튼 활성화, 그렇지 않으면 비활성화
	        if (checkbox1 && checkbox2) {
	            $("input[name='all']").prop("disabled", false);
	        } else {
	            $("input[name='all']").prop("disabled", true);
	        }
	    }
	
	    // 체크박스의 변경 이벤트에 함수를 바인딩
	    $("#accept1, #accept2").change(function() {
	        checkCheckboxes();
	    });
	
	    // 폼 제출 이벤트에 함수를 바인딩하여 버튼이 비활성화된 경우 제출을 막음
	    $("form[name='frm']").submit(function(event) {
	        if ($("input[name='all']").prop("disabled")) {
	            event.preventDefault();
	            alert("두 개의 체크박스에 동의해주세요.");
	        }
	    });
	});
</script>
</html>
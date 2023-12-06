<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/ft/resources/css/passwordOK.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
    #uploadModal {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background-color: #ceced1;
      padding: 20px;
      border-radius: 20px;
      box-shadow: -3px -3px 7px #ffffff,
               3px 3px 5px #31344b;
      width : 400px;
    }
    
.two h1 {
  text-transform: capitalize;
}

.two h1 span {
  font-size: 13px;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 4px;
  line-height: 3em;
  padding-left: 0.25em;
  color: rgba(0, 0, 0, 0.4);
  padding-bottom: 10px;
}
.alt-two h1 {
  text-align:center;
}
.alt-two h1:before {
  left:50%; margin-left:-30px;
}

#memberimage{
	width: 200px;
	height: 200px;
	border-radius: 40%;
}

#memberid,#membername,#memberemail,
#memberlogdate,#memberregdate,
#membertitle,#memberpwd{
 	background-color: #ffffff;
	margin: 0 auto;
	/* display: block; */
}

#memberid,#membername,#memberemail,
#memberlogdate,#memberregdate{	
	background-color: transparent;
	outline: none;
}
#titlediv,#pwddiv,
#iddiv,#namediv,#emaildiv,
#regdatediv,#logdatediv{
	margin-left: 25%;
}
#imagediv{
	text-align: center;
	cursor: pointer;
}

#updatebtn{
	text-align: right;
}
</style>
</head>
<body>
	<div class = "centerdiv">
		<div class = "container">
			<div class="one">
				<h1>비밀번호 확인</h1>
			</div>
			<input type = "password" id="passwordOKinput" name = "password">
			<input type = "button" id="passwordOKbtn" value ="비밀번호 확인"">
		</div>
	</div>
	
	<div id="uploadModal">
	<form action="updateMembersGO.do" method="post" id="submitForm" enctype="multipart/form-data">
		<span id="closeButton" onclick="closeUploadModal()">&times;</span>
	    
		<div class="two alt-two">
			<h1>회원정보 수정
				<span>회원정보 수정</span>
			</h1>
		</div>
		<div id="imagediv">
			<img src="profileImage/${vo.image}" id="memberimage" onclick="imageChange()">
			<br>
         	<input type="file" name="file" id="fileInput" style="display: none" onchange="previewImage()">
		</div>
		
		<div id="titlediv">
			 채널명<br>
			<input type="text" name="title" id="membertitle" value="${vo.title}" placeholder="채널명">
		</div>
		
		<div id="pwddiv">
			비밀번호<br>
			<input type="password" name="pwd" id="memberpwd" value="${vo.pwd }" placeholder="비밀번호">
		</div>
		<div id="iddiv">
			아이디<br>
			<input type="text" name="memberId" id="memberid" value="${vo.memberId}" readonly="readonly">
		</div>
		<div id="namediv">
			이름<br>
			<input type="text" name="name" id="membername" value="${vo.name}" readonly="readonly">
		</div>
		
		<div id="emaildiv">
			이메일<br>
			<input type="email" name="email" id="memberemail" value="${vo.email }" readonly="readonly">
		</div>
		<div id="logdatediv">
			최근접속일<br>
			<input type="text" name="logDate" id="memberlogdate" value="${vo.logDate }" readonly="readonly">
		</div>
		<div id="regdatediv">			
			가입일<br>
			<input type="text" name="regDate" id="memberregdate" value="${vo.regDate }" readonly="readonly">
		</div>
		<div id="updatebtn">
	    	<input type="submit" onclick="submitbtn()" value="수정">
	    </div>
	</form> 
</div>
</body>
<script>
	//모달창 열기
	function openUploadModal() {
	    document.getElementById('uploadModal').style.display = 'block';
	  }
  
	// 모달 창 닫기
	function closeUploadModal() {
	  document.getElementById('uploadModal').style.display = 'none';
	}
	
//------이미지 변경--------	

	function imageChange() {
	    document.getElementById('fileInput').click();
	}


	function previewImage() {
	    var fileInput = document.getElementById('fileInput');
	    var memberImage = document.getElementById('memberimage');

	    // 파일이 선택되었는지 확인
	    if (fileInput.files && fileInput.files[0]) {
	        var reader = new FileReader();

	        // 선택한 파일을 읽어서 이미지로 표시
	        reader.onload = function (e) {
	            memberImage.src = e.target.result;
	        };

	        reader.readAsDataURL(fileInput.files[0]);
	    }
	}
	
	//=========================
	function previewImage(input) {
		
	    var file = input.files[0];
	    var reader = new FileReader();
	    var fileInput = document.getElementById('fileInput');
	    var memberImage = document.getElementById('memberimage');
	    
		console.log(file.type);
	    
	    if (file) {
	        // 이미지 파일인지 확인
				if(validateImageFileType(file)){
	            reader.readAsDataURL(file);
	        } else {
	            // 이미지 파일이 아닌 경우
	            alert('올바른 이미지 파일을 선택하세요 (JPEG, PNG, GIF, JPG).');
	            input.value = ''; // 선택된 파일 제거
	        }
	    }
	    
	    // 파일이 선택되었는지 확인
	    if (fileInput.files && fileInput.files[0]) {
	        var reader = new FileReader();

	        // 선택한 파일을 읽어서 이미지로 표시
	        reader.onload = function (e) {
	            memberImage.src = e.target.result;
	        };

	        reader.readAsDataURL(fileInput.files[0]);
	    }
	}

	//이미지 파일인지 확인하는 함수
	function validateImageFileType(file) {
	    var allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
	    // MIME 타입 확인
	    var fileType = file.type || "";
	    return allowedTypes.some(type => fileType.includes(type));
	}	
	
	
	$('#passwordOKbtn').click(function() {
		const password = $('#passwordOKinput').val();
		console.log("password : " + password);
		
		$.ajax({
			type : "post",
			url : "passwordOK.do",
			data : {"password" : password},
			success : function(data){
				console.log("인증요청 성공")
				console.log("data : " + data);
				if(data === ""){
					alert("비밀번호가 일치하지 않습니다.");
				}
				else{
					alert("비밀번호가 일치합니다.");
					openUploadModal();	
				}
			},
			error : function(){
				console.log("인증요청 실패")
			}
		});
	});
	
	//memberpwd
	function submitbtn(){
		event.preventDefault(); // 폼의 기본 제출 동작을 막음
		const pwd = $('#memberpwd').val().length;
		if(pwd < 6){
			alert("비밀번호는 6자리 이상 입력하세요.");
			return;
		}
		alert("회원정보가 수정되었습니다.");
		$('#submitForm').submit();
	}
	
	
	
	document.getElementById("passwordOKinput").addEventListener('keydown', function(event) {
	       if (event.key === 'Enter' && event.target.value.trim() !== '') {
	          $('#passwordOKbtn').click();
	       }
	   });
</script>
	
</html>
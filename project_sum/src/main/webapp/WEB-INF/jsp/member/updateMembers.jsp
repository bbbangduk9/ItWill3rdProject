<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<title>Insert title here</title>

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

</style>
</head>
<body>
	<button id="uploadButton" class="mb-6" style="background-color: black; color: white;" onclick="openUploadModal()">만들기</button>
<div id="uploadModal">
	<form action="updateMembersGO.do" method="post" enctype="multipart/form-data">
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
	    <input type="submit" value="수정">
	</form> 
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script> 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>	
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
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
	    // 파일 선택 창 열기
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
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<title>회원등록</title>
<script>
    let isIdValid = false;
    let isEmailValid = false;
    let pwdCheck = false;
    
    
   //중복체크 자동
    function checkIdValidity() {
        const memberId = document.getElementById('memberIdInput').value;
        // AJAX를 이용하여 아이디 중복 체크 실행
        const xhrId = new XMLHttpRequest();
        xhrId.onreadystatechange = function() {
          if (xhrId.readyState === XMLHttpRequest.DONE) {
            if (xhrId.status === 200) {
              const response = xhrId.responseText;
              const duplicationMessage = document.getElementById('duplicationIdMessage');
              
             
              if (response === 'DUPLICATE') {
                duplicationMessage.textContent = '중복된 아이디가 존재합니다.';
                duplicationMessage.style.color = 'red';
                isIdValid = false;
              } else if (checkForKorean(memberId)){
                  duplicationMessage.textContent = '5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.';
                duplicationMessage.style.color = 'red';
                isIdValid = false;
              } else {
                duplicationMessage.textContent = '사용 가능한 아이디 입니다.';
                duplicationMessage.style.color = 'green';
                isIdValid = true;
              }
              enableSubmitButton();
            }
          }
        };

        if (memberId !== '') {
            xhrId.open('POST', 'duplicationCheck.do?memberId=' + memberId, true);
            xhrId.send();
        }
   }

    // AJAX를 이용하여 이메일 중복 체크 실행
    function checkEmailValidity() {
   const email = document.getElementById('emailInput').value;
    const xhrEmail = new XMLHttpRequest();
    xhrEmail.onreadystatechange = function() {
      if (xhrEmail.readyState === XMLHttpRequest.DONE) {
        if (xhrEmail.status === 200) {
          const response = xhrEmail.responseText;
          const duplicationMessage = document.getElementById('duplicationEmailMessage');
          if (email === '') {
             return;
         }
          if (response === 'DUPLICATE') {
            duplicationMessage.textContent = '중복된 이메일이 존재합니다';
            duplicationMessage.style.color = 'red';
            isEmailValid = false;
          } else if (response === "INVALID_FORMAT") {
           duplicationMessage.textContent = '이메일 형식이 올바르지 않습니다.';
           duplicationMessage.style.color = 'red';
           isEmailValid = false;
         }else {
            duplicationMessage.textContent = '중복된 이메일이 없습니다';
            duplicationMessage.style.color = 'green';
            $('#mail-Check-Btn').attr('disabled',false);
           // 인증번호 비교 
           // blur -> focus가 벗어나는 경우 발생
           $('.mail-check-input').blur(function () {
              const inputCode = $(this).val();
              const $resultMsg = $('#mail-check-warn');
              
              if(inputCode === code){
                 $resultMsg.html('인증번호가 일치합니다.');
                 $resultMsg.css('color','green');
                 $('#mail-Check-Btn').attr('disabled',true);
                 $('.mail-check-input').attr('disabled',true);
                 
                  isEmailValid = true;
                  enableSubmitButton();
              }else{
                 $resultMsg.html('인증번호가 불일치 합니다. 다시 확인해주세요!.');
                 $resultMsg.css('color','red');
              }
           });
           
          }
          
        }
      }
    };
    if (email !== '') {
        xhrEmail.open('POST', 'duplicationEmailCheck.do?email=' + email, true);
        xhrEmail.send();
    }
}
    
     //icon 클릭시 input type: password, text 변경
   function togglePasswordVisibility(inputId) {
       let passwordInput = document.getElementById(inputId);
       let eyeIcon = document.getElementById("eyeIcon");
       if (passwordInput.type === "password") {
           passwordInput.type = "text";
           eyeIcon.innerHTML = '<img src="iconImage/eye_show_icon.png" alt="Show/Hide Password" style="position: absolute; top: 50%; right: 10px; width: 10%; transform: translateY(-50%); cursor: pointer;">';
       } else {
           passwordInput.type = "password";
           eyeIcon.innerHTML = '<img src="iconImage/eye_hide_icon.png" alt="Show/Hide Password" style="position: absolute; top: 50%; right: 10px; width: 10%; transform: translateY(-50%); cursor: pointer;">';
       }
   }
   //한글정규식
   function checkForKorean(input) {
       const koreanRegex = /[ㄱ-ㅎㅏ-ㅣ가-힣]/; // 한글 정규식
       return koreanRegex.test(input);
   }
   
   
    function enableSubmitButton() {
        const submitBtn = document.getElementById('submitBtn');
        if (isIdValid && isEmailValid && pwdCheck) {
            submitBtn.disabled = false;
        } else {
            submitBtn.disabled = true;
        }
    }
      
   // 포커싱 풀릴 때 정상 체크 실행
   window.addEventListener('load', function() {
       document.getElementById("memberIdInput").addEventListener('blur', checkIdValidity);
       document.getElementById("emailInput").addEventListener('blur', checkEmailValidity);
   });
    
   // Submit 버튼 클릭 시 실행되는 함수
   function onSubmitClick(event) {
      event.preventDefault(); // 폼의 기본 제출 동작을 막음
      
      let okCount = 0; // 입력값이 있는 경우를 카운트하는 변수
      let inputs = document.getElementsByTagName("input");
      console.log(inputs.length);
      
      for (let i = 0; i < inputs.length; i++) {
           if (inputs[i].value.trim() !== "") { // 입력값이 있는 경우
              if (i < 5 || i > 6) { // i가  5 또는 6일 때는 카운트하지 않음
                   okCount++;
               }
           }
       }
      console.log('okCount : ' + okCount);

       if (okCount >= 7) {
          let formGo = document.getElementById("membersForm");
          alert("회원등록이 완료되었습니다.");
           formGo.submit();
       } else {
          alert('* 표시된 입력값을 모두 입력해주세요');
       }
   }
   
</script>
<style>
   table, th, td {
      border: solid 1px var(--GRAY125S, #e5e5e5);
      border-collapse: collapse;
   }
   th {
      width: 100px;
      color: var(--GRAY700S, #666);
       font-size: 14px;
   }
   table{
      width: 500px;
      height: 270px;
   }
   #membersForm {
      top:45%;
      left:50%;
      transform: translate(-50%, -50%);
      position: absolute;
   }
   input[type="text"], input[type="password"], input[type="email"] {
       border: none; /* 테두리 없앰 */
       outline: none; /* 포커스 시 외곽선 없앰 */
   }
   input[type="button"] {
      height: 100%;
   }
   
.thirteen h1 {
  position:relative; 
  font-size:20px; font-weight:700;  
  letter-spacing:0px; 
  text-transform:uppercase; 
  width:150px; 
  text-align:center;
   margin:auto; 
   white-space:nowrap;
   border: solid 1px var(--GRAY125S, #e5e5e5);
   border-radius: 2px;
   padding:5px 11px 3px 11px;
}
.thirteen h1:before, .thirteen h1:after {
    background-color: blue;
    position:absolute; 
    content: '';
    height: 7px;

    width: 7px; border-radius:50%;
    bottom: 12px;
}
.thirteen h1:before {
   left:-20px;
}
.thirteen h1:after {
   right:-20px;
}
</style>
</head>
<body>
   <form id="membersForm" action="memberRegist.do" method="post" enctype="multipart/form-data">
      <div class="thirteen">
         <h1>Sign Up</h1>
      </div>
      <br>
      <table id="tableline">
         <tr>
            <th>아이디(*)</th>
            <td>
               <input type="text" name="memberId" id="memberIdInput" placeholder="아이디" maxlength="10">
               <div id="duplicationIdMessage"></div>
            </td>
         </tr>
         <tr>
            <th>비밀번호(*)</th>
            <td>
               <div style="position: relative;">
                  <input type="password" name="pwd" id="passwordInput" placeholder="비밀번호" maxlength="15">
                  <div id="errorPwd"></div>
                  <span id="eyeIcon" onclick="togglePasswordVisibility('passwordInput')">
                     <img src="iconImage/eye_hide_icon.png" alt="Show/Hide Password" style="position: absolute; top: 50%; right: 10px; width: 10%; transform: translateY(-50%); cursor: pointer;">
                  </span>
               </div>
            </td>
         </tr>
         <tr>
            <th>이메일(*)</th>
            <td>
               <input type="email" name="email" id="emailInput" placeholder="email">
               <div id="duplicationEmailMessage"></div>
               <input class="form-control mail-check-input" placeholder="인증번호 6자리를 입력해주세요!" disabled="disabled" maxlength="6" style="width: 200px;">
               <button type="button" class="btn btn-primary" id="mail-Check-Btn" disabled="disabled" >이메일 전송</button>
               <br>
               <span id="mail-check-warn"></span>
            </td>
         </tr>
         <tr>
            <th>이름(*)</th>
            <td>
               <input type="text" name="name" placeholder="이름">
            </td>
         </tr>
         <tr>
            <th>생년월일(*)</th>
            <td>
               <input type="date" name="birth" placeholder="생년월일">
            </td>
         </tr>
         <tr>
            <th>채널이름</th>
            <td>
               <input type="text" name="title" placeholder="채널명">
            </td>
         </tr>
         <tr style="height:250px;">
            <th>계정이미지</th>
            <td style="vertical-align: top;">
               <input type="file" name="imageFile" onchange="previewImage(this)" style ="margin: inherit;">
               <img id="imagePreview" style="width: 250px;height: 220px;" />
            </td>
         </tr>
         <tr>
            <td colspan="2">
               <input type="button" onclick="onSubmitClick(event)" value="등록" id="submitBtn" disabled
                  style="width: 49%;">
                  <input type="button" value="취소" onclick="location.href='login.do'" style="width: 49%;">
            </td>
         </tr>
      </table>
      <h4>*표시된 항목은 필수 입력 항목입니다.</h4>
   </form>
<script>
   const passwordInput = document.getElementById('passwordInput');
   const errorPwdMessage = document.getElementById('errorPwd');
   
   passwordInput.addEventListener('input', function() {
       const inputValue = this.value;
   
       if (checkForKorean(inputValue)) {
           errorPwdMessage.textContent = "영문 대/소문자, 숫자, 특수문자를 사용해 주세요.";
           errorPwdMessage.style.color = 'red';
           pwdCheck = false;
       } 
       else if(passwordInput.value.length <= 5){
          errorPwdMessage.textContent = "비밀번호는 5자리 이하를 사용할수 없습니다";
           errorPwdMessage.style.color = 'red';
           pwdCheck = false;
       }
       else {
           errorPwdMessage.textContent = "사용가능한 비밀번호입니다.";
           errorPwdMessage.style.color = 'green';
           pwdCheck = true;
       }
       enableSubmitButton();
   });
   
   //-------------
   
       function previewImage(input) {
        var preview = document.getElementById('imagePreview');
        var file = input.files[0];
        var reader = new FileReader();

        reader.onloadend = function () {
            preview.src = reader.result;
        }

        if (file) {
            // 이미지 파일인지 확인
            if (validateFileType(file)) {
                reader.readAsDataURL(file);
            } else {
                // 이미지 파일이 아닌 경우
                alert('올바른 이미지 파일을 선택하세요 (JPEG, PNG, GIF, JPG).');
                input.value = ''; // 선택된 파일 제거
                preview.src = ''; // 이미지 미리보기 초기화
            }
        } else {
            preview.src = '';
        }
    }

    // 이미지 파일인지 확인하는 함수
    function validateFileType(file) {
        var allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
        return allowedTypes.indexOf(file.type) !== -1;
    }
   
    //이메일 전송버튼 클릭
    $('#mail-Check-Btn').click(function() {
      const email = $('#emailInput').val(); // 이메일 주소값 얻어오기!
      console.log('완성된 이메일 : ' + email); // 이메일 오는지 확인
      const checkInput = $('.mail-check-input') // 인증번호 입력하는곳 
      $.ajax({
         type : 'get',
          url : 'emailConfirm.do', // 
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
            }
         }
      }); // end ajax
   }); // end send email

   

   
</script>
</body>
</html>
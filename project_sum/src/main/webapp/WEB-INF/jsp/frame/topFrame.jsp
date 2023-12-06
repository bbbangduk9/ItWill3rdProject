<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>topFrame</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
   //==================================
   //검색 실행시
   function searchData() {
      let searchText = document.getElementById("searchText").value;
       // 첫 번째 AJAX 요청 (titleSearch.do)
       $.ajax({
           url: 'titleSearch.do',
           type: 'POST',
           data: {
               searchText: searchText
           },
           success: function (response) {
               // titleSearch.do의 응답 처리
               console.log('Received response:', response);
   
               $('#titleSearchTable').html(response);
           },
           error: function (xhr, status, error) {
               // 오류 처리
               console.error('Error while fetching :', error);
           }
       });
    
       // 두 번째 AJAX 요청 (videoSearch.do)
       $.ajax({
           url: 'videoSearchMain.do',
           type: 'POST',
           data: {
               searchText: searchText
           },
           success: function (response) {
               // videoSearch.do의 응답 처리
               console.log('Received videoSearch.do response:', response);
  
               $('#videoSearchTable').html(response);
           },
           error: function (xhr, status, error) {
               // 오류 처리
               console.error('Error while fetching videoSearch.do:', error);
           }
       });
   }
   /*  function moveSubscribe(memberId) {
       location.href="channel.do?memberId=" + memberId;
   }  */
   $(document).ready(function() {
      // 서버에서 받은 isLogged 값을 이용하여 버튼 표시 결정
      let isLogged = ${isLogged};
      console.log("topFrame isLogged : " + isLogged);
      if (isLogged) {
          $('#logoutBtn').css('display', 'block'); // isLogged가 true이면 로그아웃 버튼 표시
          $('#updateUserMemberBtn').css('display', 'block'); // isLogged가 true이면 로그아웃 버튼 표시
          
      } else {
          $('#loginBtn').css('display', 'block'); // isLogged가 false이면 로그인 버튼 표시
          $('#updateUserMemberBtn').css('display', 'none'); // isLogged가 false이면 로그인 버튼 표시
      }
   }); 
   
</script>
<style>

#searchText{
    background-color: var(--ytd-searchbox-background);
    border: 1px solid black;
    border-radius: 40px;
    color: black;
    padding: 0 4px 0 16px;
    margin-left: 32px;
}
#searchBtnFrame{
    background-color: var(--ytd-searchbox-background);
    border: none;
   color: white;
   margin-top: 10px;
}

.modal-cont {
    position: fixed;
    height: 100%;
    width: 100%;
    background-color: rgba(0, 0, 0, 0.47);
    top: 0;
    left: 0;
    overflow: auto
}

.modal-box{
    width: 500px;
    height: 29%;
    margin: 50px auto;
    background-color: white;
    position: relative;
}

.modal-box .close {
    position: absolute;
    right: 16px;
    top: 5px;
    font-size: 25px;
    font-weight: bolder;  
    cursor: pointer;
}
 .close:hover{
    color: #c6c6c6;
}
.modal-box .tagALink{
    color: #1483be;
    font-weight: 500px;
    text-decoration: underline
}
.tagALink {
   cursor: pointer;
}
.modal-box {
    animation-name: zoom;
    animation-duration: .7s;
    animation-fill-mode: forwards;
    animation-timing-function: ease;
    border: 1px solid #b7b7b7;
    border-radius: 20px;
    box-shadow: 8px 16px 16px hsl(0deg 0% 0% / 0.25);
}

#modalId, #modalPwd{
    width: 80%;
    border: 1px solid #d0d0d0;
    display: block;
    padding: 8px;
    margin: 5px auto;
    margin-bottom: 10px;
	border-radius : 6px;
}
#btn_login {
    padding: 10px;
    font-size: 15px;
    display: block;
    width: 80%;
    color: white;
    background-color: #262626;
    border-radius : 6px;
    margin: 16px auto;
    display: block;
    margin: 5px auto;
    cursor: pointer;
    border: 1px solid;
}
#modalTitle {
    margin: auto;
    text-align: center;
    display: block;
    margin-top: 20px;
    font-size: 32px;
}
#moveHome {
      margin-left: 30px;
      margin-top: 20px;
      position: fixed;
      width : 50px;
      height : 50px;
      cursor: pointer;
   }
.search {
    position: fixed;
    top: 1%;
    left: 50%;
    transform: translate(-50%);
    width: 800px;
    margin: 0 auto;
    padding: 20px; /* 적절한 패딩 값을 지정하세요 */
}
/* #loginBtn, #logoutBtn {
	position: fixed;
	top: 2px;
	right: 2px;
	border: none;
	color: #000;
	font-style: italic;
	background-color:
} */

#loginBtn, #logoutBtn {
	position: fixed;
    top: 2px;
    right: 2px;
    border: none;
    font-style: italic;
    background-color: #2F3545;
    color: white;
    padding: 10px 20px;
    line-height: var(--font-size);
    border-radius: 24px;
	font-size: 16px;
    letter-spacing: .5px;
}


#updateUserMemberBtn{
	position: fixed;
	top: 2px;
	right : 6%;
	border: none;
    font-style: italic;
    background-color: #2F3545;
    color: white;
    padding: 10px 20px;
    line-height: var(--font-size);
    border-radius: 24px;
	font-size: 16px;
    letter-spacing: .5px;
}
hr{
   border-width: 1px 0 0 0;
   border-color: #9f94945c;
}
#topframeajax {
    position: fixed;
    top: 0;
    left: 0;
    height: 100px;
    width: 100%;
    background-color: white;
    z-index: 1000; /* 다른 요소들 위에 보이도록 설정 */
    align-items: center;
 }
 
 
 
</style>
</head>
<body>
<div id=topframeajax>
<img src="iconImage/home_Image.png" onclick="location.href='main.do'" id="moveHome">
    <form action="logout.do" method="post">
      <input type="submit" id="logoutBtn" style="display: none;" value="로그아웃">
   </form>
      <input type="button" id="loginBtn" onclick = "modalOn()" style="display: none;" value="로그인">
    <form action = "password.do" method="post">
    	<input type="hidden" name="password" value = "${vo.pwd}">
		<input type="submit" id="updateUserMemberBtn" style=" display: none;" value="회원정보수정">
	</form>
		
<div class="search">
    <input type="text" id="searchText" placeholder="검색" style="width: 500px; height: 30px;">
   <input type="image" src="iconImage/search.png" id="searchBtnFrame" onclick="searchData()" style="height: 15px;">
</div>

    <div class="modal-cont" style="display: none;">
        <div class="modal-box">
            <span class="close" onclick="closeModal()">&times;</span>
            <div class="login-box">
                <p id="modalTitle">로그인</p>
                <input type="text" name="memberId" id="modalId" placeholder="아이디" required>
                <input type="password" name="pwd" id="modalPwd" placeholder="비밀번호" required>
                <button id="btn_login">Login</button>
                <div class="close-forgot" style="text-align: center;">
                   <a class="tagALink" onclick="location.href='joinMemberShip.do'">회원가입</a> /
                   <a class="tagALink" onclick="location.href='findID.do'">아이디찾기</a> /
                   <a class="tagALink" onclick="location.href='findPwd.do'">비밀번호찾기</a>
                </div>
            </div>
            <form id="redirectForm" method="post" action="main.do">
         </form>
        </div>
    </div>
</div>
<script>
   document.getElementById("searchText").addEventListener('keydown', function(event) {
       if (event.key === 'Enter' && event.target.value.trim() !== '') {
          searchData();
          $('#subscribeList').html(''); //리스트 초기화
       }
   });
// 입력란이 포함된 form 요소를 찾습니다.
   const form = document.querySelector('.login-box');
   // form에서 Enter 키를 누르면 실행되는 함수를 추가합니다.
   form.addEventListener('keypress', function(e) {
     if (e.key === 'Enter') {
       document.getElementById('btn_login').click();
     }
   });
    var modal = document.querySelector('.modal-cont');
    console.log(modal);

    function modalOn() {
        modal.style.display = "block";
    }
    
    function closeModal () {
        modal.style.display = "none";
    }
    
    $(document).ready(function () {
       $('#btn_login').click(function() {
           let pwd = $('#modalPwd').val();
           let Id = $('#modalId').val();
           console.log("memberId : " + Id)
           console.log("pwd : " + pwd);
           $.ajax({
               type : 'post',
               url : 'loginCheck.do',
               data : {"memberId" : Id, "pwd" : pwd},
               success : function (data) {
                  code = data;
                   console.log(data);
                   if(data.status === 2){
                      alert("정지된 계정입니다. 관리자에게 문의바랍니다.");
                      return;
                   }
                   if(data === ""){
                      alert("로그인에 실패하였습니다.");
                      return;
                   } else{
                      alert("로그인에 성공하였습니다.");
                      $('#redirectForm').submit();
                   }
                  
               }
           }); // end ajax
       });
   });
</script>
</body>
</html>
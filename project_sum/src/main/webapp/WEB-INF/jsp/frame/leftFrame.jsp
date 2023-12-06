<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌측 프레임</title>
<style>
   .leftFrameTable {
      border-collapse: collapse;
   }
   .leftFrameTable tr {
      height: 40px;
   }
   .leftFrameTable, .leftFrameTable th, .leftFrameTable td {
       border-spacing : 0;
       padding: 0;
       margin: 0;
    }
   .leftFrameHr {
    border-color : #595959;
    }
       

   .hoverPoint:hover {
      cursor: pointer;
   }
   .hoverBackground:hover {
      background-color: lightgray;
      cursor: pointer;
   }
   .hoverBackground:active, .hoverPoint:active {
      background-color: gray;
   }

</style>
</head>
<body>
   <form id="redirectForm" method="post" action="move.do">
   </form>
   <table class="leftFrameTable">
      <tr class="hoverBackground" onclick="location.href='main.do'">
         <th><img src="iconImage/home.png" style="width: 30px;"></th>
         <td>홈</td>
       </tr>
       <tr class="hoverBackground" onclick="location.href = 'myChannel.do'">
       <th><img src="iconImage/mychannel.png" style="width: 30px;"></th>
         <td>내 채널</td>
       </tr>
       <tr class="hoverBackground" id="subscribeBtnFrame" onclick="loadSubscribePage()">
       <th><img src="iconImage/Subscription.png" style="width: 30px;"></th>
         <td>구독</td>
       </tr>
       <tr class="hoverBackground" id="LikesBtn" onclick="myLikesSelect('${vo.memberId}')">
       <th><img src="iconImage/like.png" style="width: 30px;"></th>
         <td>좋아요 표시한 동영상 </td>
       </tr>
       
   </table>
   <hr class="leftFrameHr">
    <table class="leftFrameTable">
    <tr><td colspan="2">구독리스트</td></tr>
      <c:forEach var="sub" items="${titles }">
         <tr class="hoverBackground" onclick="moveSubscribe('${sub.memberId}')">
            <th><img src="profileImage/${sub.image }" style="width: 30px; height: 30px; border-radius: 50%;"></th>
            <th>${sub.title}</th>
            
         </tr>
      </c:forEach>
   </table>
   <hr class="leftFrameHr">
      <!-- <table class="leftFrameTable">
         <tr class="hoverBackground">
            장르 카테고리 
         </tr>
      </table> -->
      <table class="leftFrameTable">
          <tr class="hoverBackground" onclick="QnA()">
       <th><img src="iconImage/question.png" style="width: 30px;"></th>
         <td>자주묻는 질문</td>
       </tr>
        <tr class="hoverBackground" onclick="Customer()">
       <th><img src="iconImage/Subscription.png" style="width: 30px;"></th>
         <td>고객센터</td>
       </tr>
      </table>
      <br><br>
      <jsp:include page="footer.jsp"></jsp:include>
</body>
<script>
	function Customer(){
		location.href="getQnaList.do";
		console.log("실행");
	}
	
	function QnA(){
		location.href="faqQna.do";
	}
	
	function loadSubscribePage() {
        $.ajax({
            url: 'subscribe.do',
            type: 'POST',
            success: function (response) {
                $('#subscribeList').html(response);
            },
            error: function (xhr, status, error) {
                console.error('Error while fetching subscribe.do:', error);
            }
        });
    }
	
	//좋아요 표시한 동영상 불러오기
	function myLikesSelect(Id) {
        $.ajax({
            url: 'myLikesSelect.do',
            type: 'post',
            data: {
               memberId: Id
            },
            success: function (response) {
                $('#subscribeList').html(response);
            },
            error: function (xhr, status, error) {
                console.error('Error while fetching subscribe.do:', error);
            }
        });
    }
	
//관리자 페이지
	function myChannel(){
	console.log("실행");
		console.log("vo : " + vo);
		if(vo == null){
			location.href = "login.do";
		}
		else{
			$('#redirectForm').submit();
		}
	}
	
	
	
</script>
</html>
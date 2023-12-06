<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>동영상 보기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>
//우측 비디오 리스트
$(document).ready(function() {
    $.ajax({
        url: "rightVideoList.do",
        type: "GET",
        success: function(response) {
            $("#video-list").html(response);
        }
    });
});

$(document).ready(function() {
    $.ajax({
        url: "putInsertData.do",
        type: "POST",
        data: { videoIdx: "${video.videoIdx}" },
        success: function(response) {
            $("#insertComment").html(response);
        }
    });
});
$(document).ready(function() {
   $(".update-link").on("click", function(e) {
      e.preventDefault();
      
      var videoIdx = $(this).data("video-idx");
        var commentIdx = $(this).data("comment-idx");
        var comments = $(this).data("comments");
        //var comments = $('#comments').val();
      
        console.log("comments : " + comments);
        console.log("commentIdx : " + commentIdx);
        console.log("videoIdx : " + videoIdx);
        
        
       $.ajax({
           url: "upSelectComment.do",
           type: "POST",
            data: { /* videoIdx: "${comment.videoIdx}",
                 commentIdx: "${comment.commentIdx}",
                 comments: "${comment.comments}" */
                 
                  "videoIdx" : videoIdx,
                   "commentIdx": commentIdx,
                 "comments" : comments
           },
           success: function(response) {
               $("#updateComment").html(response);
               console.log("response : " + response);
           },
           error:function(request,status,error){        
              console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
              
           }
       });
   });
}); 

</script>
<style>
.profile{
   margin-left:10px;
   margin-right: 10px; 
   border-radius: 70%;
    overflow: hidden; 
    width:50px; 
    height:50px;
}
a:hover {
   text-decoration: none;
   color: black;
}

video{
   width:800px; 
   height:600px; 
}

.a {
   text-decoration: none;
}
.channel-info {
    display: flex;
    align-items: center;
}

.profile-container {
    display: flex;
}
.text-info {
    display: flex;
    flex-direction: column;
}

.text-info p {
    margin: 5px 0;
    color: black; 
}

.subscribe {
    margin-left: 10px;
}
.comment {
   white-space: normal;
}
 하트 아이콘 스타일 수정
.far.fa-heart {
   color: red;
}

.fas.fa-heart {
   color: red;
}

#heart {
   text-align: center;
}

#heart a {
   text-decoration: none; 
   color: black; 
}
</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<div id="topframe"></div><br><br><br><br><br>
<div id="titleSearchTable" style="margin-left: 20%; "></div>
<div id="videoSearchTable" style="margin-left: 20%; "></div>
<div class="container">
    <div class="row">
        <div class="col-md-8 order-md-1">   
         <div id="listcontainer">
            <video controls autoplay style="width: 100%;" src="videos/${video.video}" type="video/mp4"></video>
            <div class="video-info">         
               <div>
                  <h2>${video.vtitle }</h2>
               </div>
               <div class="channel-info">
                   <a href="channel.do?memberId=${video.memberId}" class="a">
                       <div class="profile-container">
                           <img src="profileImage/${vo2.image }" class="profile">
                          <div class="text-info">
                               <p>채널명 : ${vo2.title }</p>
                               <p>구독자 : ${subCount } 명</p>
                           </div>
                       </div>
                   </a>
<!-- ================================================================================ -->
 				 <span class="subscribe">
                   <input type="hidden" id="memberId" name="memberId" value="${video.memberId }">
                       <input type="button" value="구독" onclick="subscribeSelect()" id="subscribeBtn">
                     <input type="button" value="구독중" onclick="subscribeSelect()" id="subscribeInBtn">
           	    </span>
<!-- ================================================================================ -->
<div id = "heart">
	<p>
		<a href="JavaScript:toggleLikes()" id="likeButton">
		<i class="far fa-heart"></i> 
 		<span id="likesCount">${likesCount}</span >
		</a>
	</p>
</div>
<script>

function toggleLikes() {
    var memberId = "${sessionScope.memberId}";
    var videoIdx = "${video.videoIdx}";

    if ($("#likeButton i").hasClass("fas fa-heart")) {
        // 이미 좋아요 상태인 경우 좋아요 취소 요청
        postDeleteLikes(memberId, videoIdx);
    } else {
        // 좋아요 상태가 아닌 경우 좋아요 요청
        postInsertLikes(memberId, videoIdx);
    }
} 

function postInsertLikes() {
    var memberId = "${vo.memberId}";
    var videoIdx = "${video.videoIdx}";
    var likesCount = parseInt($("#likesCount").text());
    
    $.ajax("postLikes.do", {
        type: "post",
        data: {
            memberId: memberId,
            videoIdx: videoIdx,
            likesCount: likesCount
        },
        success: function(response) {
            // 좋아요 요청이 성공적으로 처리된 후에 실행할 코드 작성
            /* alert("좋아요 성공!!!"); */
            
            // 좋아요 개수 업데이트
            $("#likesCount").text(likesCount + 1);
            
            // 하트 아이콘 변경
            $("#likeButton i").removeClass("far fa-heart").addClass("fas fa-heart");
        },
        error: function() {
            // 좋아요 요청이 실패한 경우에 대한 처리
            alert("좋아요 요청에 실패하였습니다.");
        }
    });
}
function postDeleteLikes() {

	var memberId = "${vo.memberId}";
	var videoIdx = "${video.videoIdx}";
	var likesCount = parseInt($("#likesCount").text());
	
	$.ajax("postLikes.do", {
		type: "post",
		data: {
			memberId: memberId,
			videoIdx: videoIdx,
			likesCount : likesCount
		},
		success: function(response) {
			// 좋아요 요청이 성공적으로 처리된 후에 실행할 코드 작성
			/* alert("좋아요 취소 !!!") */
			
			// 좋아요 개수 업데이트
            $("#likesCount").text(likesCount - 1);
            
            // 하트 아이콘 변경
            $("#likeButton i").removeClass("fas fa-heart").addClass("far fa-heart");
		},
		error: function() {
			// 좋아요 요청이 실패한 경우에 대한 처리
			alert("좋아요 요청에 실패하였습니다.");
		}
	});
}
</script>

<!-- ================================================================================ -->
               </div>               
               <fmt:formatDate value="${video.vregdate}" pattern="yyyy-MM-dd" var="formattedDate" />
               <p class="fts">조회수 ${video.views } 회  ${formattedDate }</p>
               <div>${video.description }</div>
            </div>
         </div>
<%@ page import="com.spring.ft.members.MembersVO" %>
<%
   MembersVO vo = (MembersVO) session.getAttribute("vo");
%>
<script>
var logInMember = <%= (vo != null) ? "true" : "false" %>

$(document).ready(function() {
   if (logInMember) {
      $("#insertComment").show();
   } else {
      $("#insertComment").hide();
      $("<p>댓글 작성에는 로그인이 필요합니다.</p>").insertAfter("#insertComment");
   }
});
//구독
function subscribeSelect(){
   let memberId = document.getElementById("memberId").value;
   $.ajax({
        url: 'subscribeSelect.do',
        type: 'POST',
        data: {
           memberId: memberId
        },
        success: function (Logged) {
            console.log('Received subscribeSelect.do response:', Logged);
         
            if (Logged === "subscribeOn") {
                $('#subscribeBtn').show();
                 $('#subscribeInBtn').hide();
            } else if (Logged === "subscribeOff") {
                $('#subscribeBtn').hide();
                 $('#subscribeInBtn').show();
            } else if (Logged === "subscribeFalse" || Logged === ''){
                // Logged가 false인 경우, 구독 버튼을 비활성화
                $('#subscribeBtn').prop('disabled', true);
                $('#subscribeInBtn').hide();
            }
           
        },
        error: function (xhr, status, error) {
            // 오류 처리
            console.error('Error while fetching subscribe.do:', error);
        }
    });
   //============================================
}
$(document).ready(function() {
    let memberId = document.getElementById("memberId").value;

    // AJAX를 이용해 구독 상태를 확인
    $.ajax({
        url: 'subscribeConfirm.do',
        type: 'POST',
        data: {
            memberId: memberId
        },
        success: function (Logged) {
           console.log("Log : " + Logged);
          
             if (Logged === "subscribeOn") {
                 $('#subscribeBtn').show();
                 $('#subscribeInBtn').hide();
             } else if (Logged === "subscribeOff") {
                 $('#subscribeBtn').hide();
                 $('#subscribeInBtn').show();
             } else if (Logged === "subscribeFalse" || Logged === ''){
                 // Logged가 false인 경우, 구독 버튼을 비활성화
                 $('#subscribeBtn').prop('disabled', true);
                 $('#subscribeInBtn').hide();
             }
           
        },
        error: function (xhr, status, error) {
            console.error('Error while fetching subscribe status:', error);
        }
    });
});
$(document).ready(function() {
    // topFrame.jsp를 불러와서 topFrameContainer에 삽입하는 함수
    function loadTopFrame() {
        $.ajax({
            url: 'topFrame.do',
            type: 'POST',
            success: function (response) {
                // topFrame.do의 응답 처리
                $('#topframe').html(response);
                $('#searchBtnFrame').click(function() {
                    searchData();
                   $('.container').html(''); // 화면 초기화
                });
            },
            error: function (xhr, status, error) {
                // 오류 처리
                console.error('Error while fetching topFrame.do:', error);
            }
        });
    }

    // 페이지 로드 시 topFrame.jsp를 불러오기
    loadTopFrame();
});
</script>

   		   <div id="insertComment" >댓글 작성</div>
   
         <br><br>
         <div>
            <c:forEach var="comment" items="${comments}">
               <div>  
               <div>        
                     ${comment.memberId }
               </div>
                   <br>
               <div>
                     ${comment.cregdate }
            </div>
         
                   <br>
                   <div class="commentlist">
                  ${comment.comments }
                   </div>
                   <br>
                     
                  <%-- memberId를 세션에서 가져와서 현재 댓글 작성자와 비교 --%>
                  <c:set var="logInMemberId" value="${sessionScope.vo.memberId }"/>
                  <%-- 현재 댓글 작성자와 로그인한 사용자가 같으면 수정, 삭제 버튼 표시 --%>
                  <c:if test="${comment.memberId eq logInMemberId }">
                     <div id = "updateComment"></div>
                     <a href="#" class="update-link" data-video-idx="${comment.videoIdx}" data-comment-idx="${comment.commentIdx}" data-comments="${comment.comments }">수정</a>
                     <a href="deleteComment.do?videoIdx=${comment.videoIdx }&commentIdx=${comment.commentIdx}">삭제</a>
                  </c:if>
                  
                  <c:if test="${sessionScope.vo.memberId eq 'admin' }">
                     <a href="deleteComment.do?videoIdx=${comment.videoIdx }&commentIdx=${comment.commentIdx}">삭제</a>
                  </c:if>
                  <hr>   
               </div>      
            </c:forEach>
         </div>
      </div>   
       <div id="video-list" class="col-md-4 order-md-2"></div>
       
   </div>
</div>   
</body>
</html>
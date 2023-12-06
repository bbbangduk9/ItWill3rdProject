<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.spring.ft.likes.LikesVO" %>
<%@ page import="com.spring.ft.view.likes.*" %>
<%-- <%
int likesStatus = (Integer) request.getAttribute("likesStatus");
LikesVO likesVO = (LikesVO) request.getAttribute("likesVO");  

out.println("likesStatus : " + likesStatus);
out.println(likesVO.toString());	
%> --%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" />

<meta charset="UTF-8">
<title>글상세</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<style>
	#container { width: 700px; margin: auto; }
	h1, h3 { text-align: center; }
	table { border-collapse: collapse; }
	table, th, td {
		border: 1px solid black;
		margin: 0 auto;
	}
	th { background-color: orange; }
	.center { text-align: center; }
	
	.border-none, .border-none td { border: none; }
	
	/* 하트 아이콘 스타일 수정 */
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

<div id="container">
	<h1>글상세 [getBoard.jsp]</h1>
	<p><a href="logout.do">로그아웃</a></p>
	
	<form action="updateBoard.do" method="get">
		<input type="hidden" name="videoIdx" value="${board.videoIdx }">
		<table>
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="memberId" value="${board.memberId }">
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="vtitle" value="${board.vtitle }">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="video" rows="10" cols="40">${board.video }</textarea>
				</td>
			</tr>
			<tr>
				<th>장르</th>
				<td>
					<textarea name="genre" rows="10" cols="40">${board.genre }</textarea>
				</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>
					<textarea name="vregdate" rows="10" cols="40">${board.vregdate }</textarea>
				</td>
			</tr>
		</table>
	</form>
	<div id = "heart">
	<p>
		<a href="javascript:toggleLikes()" id="likeButton">
		<i class="fas fa-heart"></i> 
		<%-- <i class="<%= (likesStatus == 0 || likesStatus == -1) ? "far" : "fas" %> fa-heart"></i> --%>		
 		<span id="likesCount">${likesCount}</span >
		</a>
	</p>
	</div>
</div>
<script>
function toggleLikes() {
    var memberId = "${sessionScope.memberId}";
    var videoIdx = "${board.videoIdx}";

    if ($("#likeButton i").hasClass("fas fa-heart")) {
        // 이미 좋아요 상태인 경우 좋아요 취소 요청
        postDeleteLikes(memberId, videoIdx);
    } else {
        // 좋아요 상태가 아닌 경우 좋아요 요청
        postInsertLikes(memberId, videoIdx);
    }
} 

function postInsertLikes() {
    var memberId = "${sessionScope.memberId}";
    var videoIdx = "${board.videoIdx}";
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

	var memberId = "${sessionScope.memberId}";
	var videoIdx = "${board.videoIdx}";
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

</body>
</html>
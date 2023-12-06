<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    .video-container {
        display: flex;
        align-items: flex-start;
        margin: 5px;
        width: 80%;
    }

    .video-thumbnail {
        width: 260px;
        height: 180px;
        border: 1px solid;
        border-radius: 30px;
        border-color: black;
    }

    .video-info {
        display: flex;
        flex-direction: column;
        font-size: 20px;
        padding-left: 20px;
        padding-top: 30px;
    }

    .channel-info {
        
        font-size: 20px;
        padding-right: 300px;
    }
</style>
</head>
<body>
<hr class = "searchhr">
<c:forEach var="vs" items="${videoSearch}">
    <div class="video-container">
        <span class="hoverPoint" onclick="moveVideo('${vs.videoIdx}')">
            <img src="thumimgs/${vs.vimage}" class="video-thumbnail">
        </span>
        <div class="video-info">
            <span class="hoverPoint" onclick="moveVideo('${vs.videoIdx}')" style="font-size: 30px;">${vs.vtitle}</span>
            <div class="hoverPoint" onclick="moveSubscribe('${vs.memberId}')">
               	<span class="channel-info">
               		<img src="profileImage/${vs.image}" style="width: 40px; height: 40px; border-radius: 50%;">
					${vs.title}
                </span>
            </div>
        </div>
    </div>
	<c:set var="logInMemberId" value="${sessionScope.vo.memberId }"/>
		<c:if test="${sessionScope.vo.memberId eq 'admin' }">
			<a href="deleteVideo.do?videoIdx=${vs.videoIdx }" id="deletedMaster">삭제</a>			
		</c:if>
	</c:forEach>


<script>
function moveVideo(videoIdx) {
    location.href="getVideo.do?videoIdx=" + videoIdx;
}
function moveSubscribe(memberId) {
    location.href="channel.do?memberId=" + memberId;
}
</script>
</body>
</html>
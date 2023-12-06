<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 수정 페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<%
	// 파일명이 너무 깁니다 메시지 받아오기
	String fileTooLongMessage = (String) request.getAttribute("scriptMssage");
%>

	<% if (fileTooLongMessage != null) { %>
<script>
	// 파일명이 너무 깁니다 메시지 출력
		alert('<%= fileTooLongMessage %>');
</script>
	<% } %>
	
<script>
function validateForm() {
    var vtitle = document.forms["upVideoForm"]["vtitle"].value;
    var addUploadFile = document.forms["upVideoForm"]["addUploadFile"].value;
	
    console.log(vtitle);
    console.log(addUploadFile);
    if (vtitle == "" || addUploadFile == "") {
        alert("*표시 되어있는 문항은 다 입력해야합니다.");
        return false; // 폼 제출 방지
    }
    return true; // 폼 제출 허용
}

function previewImage(input, elementId, fileType) {
    var preview = document.getElementById(elementId);
    var file = input.files[0];
    var reader = new FileReader();

    reader.onloadend = function () {
        preview.src = reader.result;
    }

    if (file) {
        // 파일 타입 확인
        if (validateFileType(file, fileType)) {
            reader.readAsDataURL(file);
        } else {
            // 파일 타입이 올바르지 않은 경우
            var errorMessage = fileType === 'image' ? '올바른 이미지 파일을 선택하세요 (JPEG, PNG, GIF, JPG).' : '올바른 영상 파일을 선택하세요 (MP4, AVI, MKV, MOV, WMV).';
            alert(errorMessage);
            input.value = ''; // 선택된 파일 제거
            preview.src = ''; // 미리보기 초기화
        }
    } else {
        preview.src = '';
    }
}

// 파일 타입 확인하는 함수
function validateFileType(file, fileType) {
    var allowedTypes = fileType === 'image' ? ['image/jpeg', 'image/png', 'image/gif'] : ['video/mp4', 'video/avi', 'video/mkv', 'video/mov', 'video/wmv'];
    return allowedTypes.indexOf(file.type) !== -1;
}
</script>
<div style="border: 1px solid #ccc; padding: 30px; width: 70%; max-width: 650px; margin: 20px auto;">	
	<form id="updateForm" name="upVideoForm" action="updateVideo.do" method="post" enctype="multipart/form-data" onsubmit="return validateForm()" style="border: 1px solid; padding: 30px;">
	    <h2>게시글 수정</h2>
	    <input id="update-videoIdx" type="hidden" name="videoIdx" title="글번호" value="${video.videoIdx }">
		<input id="update-memberId" type="hidden" name="memberId" title="아이디" value="${video.memberId }">
	    <div>
	      	<h4>동영상 : *</h4>
	      	<video controls id="befoevideo" src="videos/${video.video }" type="video/mp4" width="250" height="200"></video>
	      	<input id="update-video" type="file" name="addUploadFile" onchange="previewImage(this, 'befoevideo', 'video')">
	    </div>
	    <div>
	       	<h4>썸네일 : </h4> 
	      	<img id="befoeImage" src="thumimgs/${video.vimage }" width="150" height="120">
	      	<input id="update-vimage" type="file" name="uploadFile" onchange="previewImage(this, 'befoeImage', 'image')">
	    </div>
	    <div>
	      	제목 : * 
	      	<input id="update-vtitle"  type="text" name="vtitle" title="제목" value="${video.vtitle }" style="width:80%; height:5%;">      	
	    </div>
	    <div>
	      	장르
	      	<select name="genre">
	      		<option value="게임">게임</option>
	      		<option value="음악">음악</option>
	      		<option value="요리">요리</option>
	      		<option value="스포츠">스포츠</option>
	      		<option value="만화">만화</option>
	      		<option value="영화">영화</option>
	      		<option value="드라마">드라마</option>
	      	</select>
	    </div>
	    <div>
	      	<h4>내용  : </h4>
	      	<textarea name="description" title="설명" value="${video.description }" rows="7" cols="70" ></textarea>
		</div>
		<input type="submit" value="게시글 수정" style="float: right;">
	</form>
</div>
</body>
</html>
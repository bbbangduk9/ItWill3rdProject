<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<title>내 채널</title>
<style>
	.container {
		width: 100%;
	}
	.myInfo {
		width: 40%;
	}
	#slate_img {
		display: inline-block; 
		width: 100px; 
		height: 100px; 
	}
	button {
		border-radius: 20px;
		padding: 6px 15px;
		border: none;
		font-size: 14px;
	}
	.make_contents {
		font-size: 14px;
	}
	.fullValue {
		display: none;
	}
	
/* 모달 css */

    #uploadModal {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      background-color: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.5);
      background-color: #e6e6e6;
    }

    #uploadModal h2 {
      margin-bottom: 20px;
    }

    #uploadButton {
      padding: 10px 20px;
      background-color: #3498db;
      color: #fff;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    #closeButton {
      position: absolute;
      top: 10px;
      right: 10px;
      font-size: 20px;
      cursor: pointer;
    }

    #videoPreview, #thumbnailPreview {
      width: 100%;
      max-width: 300px;
      height: auto;
      max-height: 200px;
      margin-top: 10px;
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

#videoPreviewDiv,#thumbnailPreviewDiv,
#vtitleDiv,#genreDiv,#descriptionDiv{
	margin-left: 25%;
}
#thumbnailInput{
	text-align: center;
	cursor: pointer;
}

#updatebtn{
	text-align: right;
}

#textareaForm{
	width: 80%;
}
#memberIdInput,#videoInput,
#thumbnailInput,#vtitleInput{
	background-color: #ffffff;
	margin: 0 auto;
	/* display: block; */
}
#thumbnailInput,#videoInput{
background-color: transparent;
}
</style>
</head>
<body>
<div id="topframe"></div><br><br><br><br><br>
<div id="titleSearchTable" style="margin-left: 20%; "></div>
<div id="videoSearchTable" style="margin-left: 20%; "></div>
<!-- 컨테이너 -->
<div class="container mt-4">

	<!-- 회원정보 출력 -->
	<div class="myInfo w-100">
		<div class="float-left">
			<a href="password.do">
				<span><img style="width:180px; height:180px;"class="mt-3 mr-3" alt="프로필 사진" src="profileImage/${vo.image }"></span>
			</a>
		</div>
		
		<div class="ml-4">
			<div>
				<h1 class="mb-1" style="font-weight: bolder">${vo.name }</h1>
				<p class="pt-2" style="color: #666;">
					@${vo.memberId } ‧ 
					
					<c:if test="${mySub != 0}">
						<c:choose>
							<c:when test="${mySub >= 10000 }">
								<fmt:formatNumber var="sub" value="${mySub / 10000}" pattern="#.##"/>
								구독자 ${mySub }만 명
							</c:when>
							<c:otherwise>
								구독자 ${mySub }명
							</c:otherwise>
						</c:choose>
					</c:if>
					 ‧ 
					<c:if test="${myVideoCount != 0}">
						동영상 ${myVideoCount }개
					</c:if> 
				</p>
				<p><a style="text-decoration: none; cursor: pointer; color: #888; width:200px" onclick="openMyChannelDetailWindow()">채널 자세히 알아보기 &gt;</a></p>
				
				<p><button onclick="javascript:location.href='beforeMyChannelContents.do'">동영상 관리</button></p>
				
			</div>
		</div>
	</div>
	<br>
	<br>
	<div class="home">
		<p class="ml-4">홈</p>
		<hr>
		
		<!-- 홈 아래 부분 -->
		<div class="under_home" style="margin: auto; width: 80%;">
		
			<!-- 동영상 업로드(만들기) -->
			<div class="make_contents" style="clear:left; text-align: center;">
				<img id="slate_img" class="mb-3" alt="이미지" src="resources/images/members/슬레이트.jpg">
				<p>원하는 기기에서 콘텐츠를 만드세요.</p>
				<p>집에서는 물론 이동 중에도<br>
				     업로드할 수 있습니다.<br>
				     게시한 모든 콘텐츠가 여기 표시됩니다.</p>
				<button id="uploadButton" class="mb-6" style="background-color: black; color: white;" onclick="openUploadModal()">만들기</button>
			</div>
			<br><br>
			
			<!-- 영상 목록 띄우는 부분 -->
			<c:choose>
				<c:when test="${myVideoList.size() != 0}">
					<div class="videos">
						<c:forEach var="idx" begin="0" end="${myVideoList.size() - 1 }">
							<div class="float-left" style="text-align:center; width: 30%; margin: 0 auto;">
								<div style="width: 60%; margin:0 auto; position: relative;">
									<p style="margin: 0;">
										<a href="getVideo.do?videoIdx=${myVideoList[idx].videoIdx}">
											<img alt="섬네일" width="150px" height="150px" src="thumimgs/${myVideoList[idx].vimage }"/>
										</a>
									</p>
									<strong>
										<a style="text-decoration: none; cursor: pointer;" onclick="javascript:location.href='getVideo.do?videoIdx=${myVideoList[idx].videoIdx}'">
											<p class="longValue" style="margin: 0; text-align:left; overflow:hidden; text-overflow:ellipsis; white-space: nowrap;">
												${myVideoList[idx].vtitle }
											</p>
											<p class="fullValue" style="position: absolute; z-index:1; left:25px; border:1px solid black; background-color: white; margin: 0; text-align:left; overflow:hidden; text-overflow:clip; white-space: nowrap;">
												${myVideoList[idx].vtitle }
											</p>
										</a>
									</strong>
									<c:choose>
										<c:when test="${myVideoList[idx].views == 0}">
											<p style="margin: 0; text-align:left; color:#aaa">&nbsp;&nbsp;조회수 없음</p>
										</c:when>
										<c:otherwise>
											<p style="margin: 0; text-align:left;">&nbsp;&nbsp;${myVideoList[idx].views }회 조회</p>
										</c:otherwise>
									</c:choose>					
									<br>		
									<br>		
								</div>
							</div>
							<c:if test="${ (idx + 1) % 3 == 0}" >
								<br>
							</c:if>
							
						</c:forEach> 
						
					</div>
				</c:when>
			</c:choose>
			
			<br>
			<br>
		</div>
	</div>
	
	
<!-- 모달창 -->
<div id="uploadModal">
	<form action="insertVideo.do" method="post" enctype="multipart/form-data">
		<div class="two alt-two">
			<h1>파일 업로드</h1>
		</div>
		<span id="closeButton" onclick="closeUploadModal()">&times;</span>
	    <div>
	      	<input type="hidden" name="memberId" id="memberIdInput" value="${vo.memberId }" style="border:none;">
	    </div>
	    <div id = "videoPreviewDiv">
	      	<video id="videoPreview" controls></video>
	      	<br>동영상<br>
	      	<input type="file" name="addUploadFile" id="videoInput" accept="video/*" onchange="previewThumbnailAndImage(this)">
	    </div>
	    <div id = "thumbnailPreviewDiv">
	       	썸네일<br>
	      	<input type="file" name="uploadFile" id="thumbnailInput" onchange="previewImage(this)">
	    </div>
	    <div id = "vtitleDiv">
	      	제목<br>
	      	<input type="text" name="vtitle" id="vtitleInput" style="width:80%; height:5%;">
	    </div>
	    <div id = "genreDiv">
	      	<br>장르 : 
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
	    <div id = "descriptionDiv">
	      	<h4>내용  : </h4>
	      	<textarea name="description" rows="7" cols="70" id="textareaForm"></textarea>
	    </div>
	   	<input type="submit" value="동영상 등록" id = "updatebtn" style="float: right;">
	  </form> 
</div>


<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script> 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>	
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

<script>
	$().ready(function() {
		$(".longValue").on("mouseover", showFullValue);
		$(".longValue").on("mouseleave", hideFullValue);
		
	});
	
	function showFullValue() {		
		$(this).next().css("display", "block");
	}
	
	function hideFullValue() {
		$(this).next().css("display", "none");
	}
	// 채널 자세히 알아보기 누르면 창 띄워줌
	function openMyChannelDetailWindow() {
		window.open("showMyChannelDetail.do", 
				    "myChannelDetail", "width=500, height=350, top=300, left=800");
	}
	
//------------- 모달창--------------

 // 모달 창 열기
  function openUploadModal() {
    document.getElementById('uploadModal').style.display = 'block';
  }

  // 모달 창 닫기
  function closeUploadModal() {
    document.getElementById('uploadModal').style.display = 'none';
  }
//===================================
  // 파일 선택 시 동영상 미리보기
  function nowVideo() {
    var videoInput = document.getElementById('videoInput');
    var videoPreview = document.getElementById('videoPreview');

    if (videoInput.files && videoInput.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        videoPreview.src = e.target.result;
      };

      reader.readAsDataURL(videoInput.files[0]);
    }
  }
  
  //=======================================
  
  function previewThumbnailAndImage(input) {
	    nowVideo();
	    previewVideo(input);
	}

  function previewVideo(input) {
	    var file = input.files[0];
	    var reader = new FileReader();

	    if (file) {
	        // 동영상 파일인지 확인
	        if (validatePlayFileType(file)) {
	            reader.readAsDataURL(file);
	        } else {
	            // 동영상 파일이 아닌 경우
	            alert('올바른 동영상 파일을 선택하세요 (MP4, AVI, MKV, MOV, WMV).');
	            input.value = ''; // 선택된 파일 제거
	        }
	    }
	}


	function validatePlayFileType(file) {
		 var allowedTypes = ['video/mp4', 'video/avi', 'video/mkv', 'video/mov', 'video/wmv'];
	    // MIME 타입 확인
	    var fileType = file.type || "";
	    return allowedTypes.some(type => fileType.includes(type));
	}
	//==============================================
	
	function previewImage(input) {
		
	    var file = input.files[0];
	    var reader = new FileReader();
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
	}

	//이미지 파일인지 확인하는 함수
	function validateImageFileType(file) {
	    var allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
	    // MIME 타입 확인
	    var fileType = file.type || "";
	    return allowedTypes.some(type => fileType.includes(type));
	}
	
	
  
  /* top frame ajax */
  
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
	     
	
	function previewVideo(input) {
	    var file = input.files[0];
	    var reader = new FileReader();

	    if (file) {
	        // 동영상 파일인지 확인
	        if (validatePlayFileType(file)) {
	            reader.readAsDataURL(file);
	        } else {
	            // 동영상 파일이 아닌 경우
	            alert('올바른 동영상 파일을 선택하세요 (MP4, AVI, MKV, MOV, WMV).');
	            input.value = ''; // 선택된 파일 제거
	        }
	    }
	}


	function validatePlayFileType(file) {
		 var allowedTypes = ['video/mp4', 'video/avi', 'video/mkv', 'video/mov', 'video/wmv'];
	    // MIME 타입 확인
	    var fileType = file.type || "";
	    return allowedTypes.some(type => fileType.includes(type));
	}
</script>
</body>

</html>
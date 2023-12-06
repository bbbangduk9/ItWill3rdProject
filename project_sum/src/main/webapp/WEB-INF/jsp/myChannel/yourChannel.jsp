<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<title>채널</title>
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
	#subscribeBtn {
		border-radius: 20px;
		padding: 6px 15px;
		border: none;
		font-size: 14px;
		color: white;
		background-color: black;
	}
	#subscribeInBtn {
		border-radius: 20px;
		padding: 6px 15px;
		border: none;
		font-size: 14px;
	}	
	#jong {
		display: none;
	}
	.make_contents {
		font-size: 14px;
	}
	.fullValue {
		display: none;
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
			<a href="channel.do?memberId=${you.memberId }">
				<span><img style="width:180px; height:180px;"class="mt-3 mr-3" alt="프로필 사진" src="profileImage/${you.image }"></span>
			</a>
		</div>
		
		<div class="ml-4">
			<div>
				<h1 class="mb-1" style="font-weight: bolder">${you.name }</h1>
				<p class="pt-2" style="color: #666;">
					@${you.memberId } ‧ 
					
					<c:if test="${yourSub != 0}">
						<c:choose>
							<c:when test="${yourSub >= 10000 }">
								<fmt:formatNumber var="sub" value="${yourSub / 10000}" pattern="#.##"/>
								구독자 ${yourSub }만 명
							</c:when>
							<c:otherwise>
								구독자 ${yourSub }명
							</c:otherwise>
						</c:choose>
					</c:if>
					 ‧ 
					<c:if test="${videoCount != 0}">
						동영상 ${videoCount }개
					</c:if>
				</p>
				<p><a style="text-decoration: none; cursor: pointer; color: #888; width:200px" onclick="openYourChannelDetailWindow()">채널 자세히 알아보기 &gt;</a></p>
				<div>
					<input type="hidden" id="memberId" name="memberId" value="${you.memberId }">
                    <input type="button" value="구독"  onclick="subscribeSelect()" id="subscribeBtn">
                    <img id="jong" src="resources/images/icon/jong.png"><input type="button" value="구독중" onclick="subscribeSelect()" id="subscribeInBtn">
				</div>
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
		
			<!-- 영상 목록 띄우는 부분 -->
			<c:choose>
				<c:when test="${videoList ne null and videoList.size() ne 0}">
				
				<div class="videos">
					<c:forEach var="idx" begin="0" end="${videoList.size() - 1 }">
						<div class="float-left" style="text-align:center; width: 30%; margin: 0 auto;">
							<div style="width: 60%; margin:0 auto; position: relative;">
								<p style="margin: 0;">
									<a href="getVideo.do?videoIdx=${videoList[idx].videoIdx }">
										<img alt="섬네일" width="150px" height="150px" src="thumimgs/${videoList[idx].vimage }"/>
									</a>
								</p>
								<strong>
									<a style="text-decoration: none; cursor: pointer;" onclick="javascript:location.href='getVideo.do?videoIdx=${videoList[idx].videoIdx }'">
										<p class="longValue" style="margin: 0; text-align:left; overflow:hidden; text-overflow:ellipsis; white-space: nowrap;">
											${videoList[idx].vtitle }
										</p>
										<p class="fullValue" style="position: absolute; z-index:1; left:25px; border:1px solid black; background-color: white; margin: 0; text-align:left; overflow:hidden; text-overflow:clip; white-space: nowrap;">
											${videoList[idx].vtitle }
										</p>
									</a>
								</strong>
								<c:choose>
									<c:when test="${videoList[idx].views == 0}">
										<p style="margin: 0; text-align:left; color:#aaa">&nbsp;&nbsp;조회수 없음</p>
									</c:when>
									<c:otherwise>
										<p style="margin: 0; text-align:left;">&nbsp;&nbsp;${videoList[idx].views }회 조회</p>
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
				<c:otherwise>
				
				</c:otherwise>
			</c:choose>	
			
			<br>
			<br>
		</div>
	</div>

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
	function openYourChannelDetailWindow() {
		window.open("showYourChannelDetail.do", 
				    "yourChannelDetail", "width=500, height=350, top=300, left=800");
	}
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
	                $('#jong').hide();
	                 $('#subscribeInBtn').hide();
	            } else if (Logged === "subscribeOff") {
	                $('#subscribeBtn').hide();
	                $('#jong').show();
	                $('#subscribeInBtn').show();
	            } else if (Logged === "subscribeFalse" || Logged === ''){
	                // Logged가 false인 경우, 구독 버튼을 비활성화
	                $('#subscribeBtn').prop('disabled', true);
	                $('#jong').hide();
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
</script>
</body>

</html>
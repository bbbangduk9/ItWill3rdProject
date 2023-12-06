<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainTest</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script>
	//=======================================
	//jsp 파일 불러오기1
	$(document).ready(function() {
	    // topFrame.jsp를 불러와서 topFrameContainer에 삽입하는 함수
	    function loadTopFrame() {
	        $.ajax({
	            url: 'topFrame.do',
	            type: 'POST',
	            success: function (response) {
	                // topFrame.do의 응답 처리
	                $('#topFrameContainer').html(response);
	                $('#searchBtnFrame').click(function() {
	                    searchData();
	                	$('#subscribeList').html(''); // 구독 리스트 초기화
	                	$('#videoList').html(''); 
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
	//jsp 파일 불러오기2
	$(document).ready(function() {
	    // leftFrame.jsp를 불러와서 leftFrameContainer에 삽입하는 함수
	    function loadLeftFrame() {
	        $.ajax({
	            url: 'leftFrame.do',
	            type: 'POST',
	            success: function (response) {
	                // leftFrame.do의 응답 처리
	                $('#leftFrameContainer').html(response);
	                // loadSubscribePage 함수를 구독 버튼에 바인딩
	                $('#subscribeBtnFrame').click(function() {
	                    loadSubscribePage();
	                	$('#titleSearchTable').html(''); // 검색 결과 초기화
		            	$('#videoSearchTable').html(''); // 비디오 검색 결과 초기화
		            	$('#videoList').html(''); 
	                });
	                
	                $('#LikesBtn').click(function() {
	                     myLikesSelect();
	                     $('#titleSearchTable').html(''); // 검색 결과 초기화
	                     $('#videoSearchTable').html(''); // 비디오 검색 결과 초기화
	                     $('#videoList').html(''); // 비디오 메인리스트 초기화
	                   });
	                
	                $('#membersListMasterBtn').click(function() {
	                	membersListMaster();
	                	$('#titleSearchTable').html(''); // 검색 결과 초기화
		            	$('#videoSearchTable').html(''); // 비디오 검색 결과 초기화
		            	$('#videoList').html(''); 
	                });
	            },
	            error: function (xhr, status, error) {
	                // 오류 처리
	                console.error('Error while fetching leftFrame.do:', error);
	            }
	        });
	    }
	
	    // 페이지 로드 시 leftFrame.jsp를 불러오기
	    loadLeftFrame();
	});
	
	$(document).ready(function() {
	    $.ajax({
	        url: "getVideoList.do",
	        type: "GET",
	        success: function(response) {
	            $("#videoList").html(response);
	        }
	    });
	});
	function moveVideo(videoIdx) {
		location.href="getVideo.do?videoIdx=" + videoIdx;
	}
	function moveSubscribe(memberId) {
		location.href="channel.do?memberId=" + memberId;
	}
</script>
<style>
body {margin:0;}
   #leftFrameContainer {width: 150px;}
    .grid-container {
      margin: 0;
      display: grid;
      grid-template-columns: 1fr 6fr 1fr;
      grid-template-rows: 1fr 4fr 3fr;
      grid-gap: 5px;
      height: 100vh;
      position: relative;
    }
    #topframe {
      grid-column: 2 / 4; /* 1열부터 4열까지 */
      grid-row: 1 / 2;
      position: fixed;
      top: 0;
      height: calc(13%);
      width: calc(86%); /* 그리드의 너비 - 왼쪽 frame 너비 - grid gap 만큼의 너비로 설정 */
      background-color: white;
    }

    #leftframe {
      grid-row: 2 / 4; /* 2행부터 4행까지 */
      grid-column: 1 / 2;
      position: fixed;
      left: 0;
      width: calc(12%);
      height: calc(100%);
    }

    #contentMain {
      grid-row: 2 / 4; /* 2행부터 4행까지 */
      grid-column: 2 / 4; /* 2열부터 4열까지 */
      display: flex;
      flex-direction: column;
      gap: 20px; /* 테이블 간의 간격 설정 */
    }
   #contentMain > * {
     margin-top: -15px; /* 상단 마진을 음수로 설정하여 위로 이동 */
   }
    /* Optional: Added styles to mimic the table appearance */
    #topframe,
    #leftframe,
    #contentMain {
      display: flex;
      font-size: 15px;
      padding: 10px;
    }
    .search {
      margin-top: 45px;
      text-align: center;
      padding-left: 150px;
      display: block;
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
   
   #searchhr{
   border-color: #595959;
}
</style>
</head>
<body>
<div class="grid-container" >
	<div id="topframe">
		<div id="topFrameContainer" style="width: 100%;"></div>
	</div>
	<div id="leftframe">
		<div id="leftFrameContainer" style="width: 100%;"></div>
	</div>
	<div id="contentMain" style=" padding-left: 80px;">
		<div id="titleSearchTable"></div>
		<div id="videoSearchTable"></div>
		<div id="subscribeList"></div>
	
	<!-- 동영상 표시할 곳 -->
	<div id="videoList"></div>
	</div>
</div>
</body>
</html>
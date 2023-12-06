<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<title>채널 콘텐츠</title>
<style>
	.container {
		width: 100%;
		height: 800px;
		margin: 0 10px 20px;
		padding: none;
	}
	.menu {
		margin-left: 1px;
	}
	.menu_item {
		font-weight: bold;
		height: 40px;
		padding: 10px;
		border: none;
	}
	.selected {
		color: red;
		background-color: #F5F5F5;
		border-left: 5px solid red;
	}
	.contents {
		width: 100%;
	}
	.menu_item:hover {
		background-color: #F5F5F5;
	}
	
	
	#closeMenuBtn:hover {
		background-color: rgb(255, 255, 255, 0.8);
	}
	#deleteMenu {
		display: none;
	}
}
</style>

<style>
	.container table {
		width: 100%;
		border-collapse: collapse;
		font-size: 14px;
	}
	th {
		border: 1px solid Gainsboro;
		padding: 1px 10px;
	}
	td {
		border: 1px solid Gainsboro;
		padding: 3px 10px;
	}
	.right {
		text-align: right;
	}
	.container .align-left {
		text-align: left;
	}
	.th_num {
		width: 13%;
	}
	.th_date {
		width: 13%;
	}
	/*** 페이지 표시 영역 스타일(시작) ***/	
	.paging {
		list-style: none;
	}
	.paging li {
		float: left;
		margin-right: 8px;
	}
	.paging li a {
		text-decoration: none;
		display: block;
		padding: 5px 9px;
		border: 1px solid black;
		font-weight: bold;
		color: black;
	}
	.paging .disable {
		border: 1px solid Gainsboro;
		padding: 3px 7px;
		color: silver;
	}
	.now {
		border: 1px solid red;
		background-color: red;
		padding: 5px 9px;
		font-weight: bold;
		color: white;
	}
	span {
		display: inline-block;
	}
	#search_filter {
		display: none;
	}
	#search_btn {
		color: white;
		background-color: black;
		border-radius: 20px;
		padding: 6px 15px;
		border: none;
		font-size: 14px;
	}
</style>

</head>
<body>
<!-- 컨테이너 -->
<div class="container">

	<!-- 메뉴 -->
	<div class="menu float-left" style="width: 190px; height: 100%; font-size: 14px; border-right: 1px solid Gainsboro;">
		
		<!-- 사용자 정보 -->
		<div class="profile" style="text-align: center;">
			<div>
				<a href="myChannel.do">
					<div style="padding-left:14px;"><img style="width:120px; height:120px;"class="mt-3 mr-3" alt="프로필 사진" src="profileImage/${vo.image }"></div>
				</a>
			</div>
			<p style="margin: 0;">내 채널</p>
			<p style="margin: 0; font-size:13px; color: #999">${vo.name }</p>			
		</div>
		<br>
		
		<!-- 메뉴 -->
		<div class="menu">
			<div class="main_menu" style="height: 80%;">
				<div class="menu_item selected">
					<a style="text-decoration: none; cursor: pointer;" onclick="javascript:location.href='beforeMyChannelContents.do'">
						<span>
							<img src="resources/images/icon/videologo.png" width="20px" height="20px" alt="아이콘">
						</span>
						<span style="margin-left: 20px;">콘텐츠</span>
					</a>
				</div>	
				<div class="menu_item"><a style="text-decoration: none; cursor: pointer;" onclick="javascript:location.href='beforeMyChannelAnalysis.do'">
					<span><img src="resources/images/icon/analytics.png" width="20px" height="20px" alt="아이콘"></span>
					<span style="margin-left: 20px;">분석</span>
				</a></div>	
				<div class="menu_item"><a style="text-decoration: none; cursor: pointer;" onclick="javascript:location.href='beforeMyChannelComments.do'">
					<span><img src="resources/images/icon/comment.png" width="20px" height="20px" alt="아이콘"></span>
					<span style="margin-left: 20px;">댓글</span>
				</a></div>	
			</div>
			
			<div class="sub_menu" style="margin-top: 200px;">
				<hr>
				<div class="menu_item"><a style="text-decoration: none; cursor: pointer;" onclick="javascript:location.href='insertQna.do'">
					<span><img src="resources/images/icon/info2.png" width="20px" height="20px" alt="아이콘"></span>
					<span style="margin-left: 20px;">의견 보내기</span>
				</a></div>	
			</div>
		</div>
	</div>

	<!-- 내용 -->
	<div class="contents" style="margin-left: 200px;">
		<div>
			<h3 class="mt-1 mb-2 ml-2" style="font-size:21px; font-weight:bold;">채널 콘텐츠</h3>
		</div>
		<hr>
		
		<!-- 검색 기능 -->
		<form name="frm">
			<input type="hidden" name="cPage" value="1">
			
			<select name="search_select" id="search_select">
				<option value="VTITLE">제목으로 검색</option>
				<option value="VREGDATE">업로드 날짜</option>
				<option value="VIEWS">조회수</option>
				<option value="COMMENTS">댓글수(없는 경우 제외됨)</option>
				<option value="LIKES">좋아요(없는 경우 제외됨)</option>
			</select>
			
			<select name="search_filter" id="search_filter">
				<option value="ge">&ge;</option>
				<option value="le">&lt;</option>
			</select>
			
			<input type="text" id="search_value" name="search_value" style="width:300px;" value="${search_value }" placeholder=" 동영상 제목을 입력하세요.">
			<button id="search_btn">검색하기</button>
			
			<%-- 페이지당 행 수 처리 --%>
			<div class="float-right">
				페이지당 행 수 : 
				<select name="rows" id="rows">
					<option value="2">2</option>
					<option value="5">5</option>
					<option value="10">10</option>
				</select>
			</div>
			
		</form>
		
		<!-- 삭제 메뉴 -->
		<div id="deleteMenu" class="mt-2" style="width:100%; background-color:black; color:white; height:50px;">
		
			<div class="float-left p-1 m-0" style="width:20%; line-height: 40px;">
				<!-- ~개 선택됨 -->
				<div id="checkNum" class="float-left mr-2 pl-2">
				</div>
				
				<!-- (전체 선택) -->
				<div class="float-left m-0">
					<a href="javascript:allCheck('ok')" style="text-decoration:underline; color:white;">
						(전체 선택)
					</a>
				</div>
			</div>
			
			<div class="float-left p-1 pl-3 m-0" style="border: 1px solid black; border-left-color: Gainsboro; width:20%; line-height: 40px;">
				<!-- 삭제 버튼 -->
				<a href="javascript:deleteVideos()" style="text-decoration:none; color:white;">
					삭제하기
				</a>
			</div>
			
			<!-- X -->
			<div class="float-right p-1 pr-3 m-0" style="line-height: 40px;">
				<a id="closeMenuBtn" href="javascript:allCheck('hidden')" style="text-decoration:none; color:white; font-size:20px; font-weight:700;">
					✕
				</a>
			</div>
			
		</div>
		
		<!-- 테이블 -->
		<div class="mt-3">
			<table style="table-layout:fixed;">
				<tr>
					<th style="width:30px;"><input type="checkbox" name="allCheck" id="allCheck"></th>
					<th>동영상</th>
					<th class="th_date">업로드 날짜</th>
					<th class="th_num">조회수</th>
					<th class="th_num">댓글수</th>
					<th class="th_num">좋아요</th>
				</tr>
			
				<c:forEach var="vo" items="${myContentsVideoList }">
					<tr>
						<td>
							<input type="checkbox" name="checks" class="checks">
							<input type="hidden" name="deleteVideo" value="${vo.videoIdx }">
						</td>
					
						<td style="width:33%; position:wrap;">
							<div>
								<a style="text-decoration: none; cursor: pointer;" onclick="javascript:location.href='fixMyVideo.do?memberId=${vo.memberId }&videoIdx=${vo.videoIdx}'">
									<img class="float-left mr-1" style="width:100px; height:60px;" src="thumimgs/${vo.vimage}">
								</a>
							</div>
							<a style="text-decoration: none; cursor: pointer;" onclick="javascript:location.href='fixMyVideo.do?memberId=${vo.memberId }&videoIdx=${vo.videoIdx}'">
								<div class="longValue" style="overflow:hidden; text-overflow:ellipsis; white-space: nowrap;">${vo.vtitle }</div>
							</a>
							<div class="p-1 mt-2 fullValue" style="display: none;">${vo.vtitle }</div>
						</td>	
						<td class="right">${vo.vregdate}</td>
						<td class="right">${vo.views}</td>
						<td class="right">${vo.comments}</td>
						<td class="right">${vo.likes}</td>
					</tr>
				</c:forEach>			
			</table>
		</div>
		<div class="pagingDiv mt-4 mr-5 float-right">
			
			<div class="mt-5"></div>
			
			<c:if test="${myContentsVideoList.size() != 0 }">
			<ol class="paging mt-3">
				
				<%-- [이전으로]에 대한 사용여부 처리 --%>
				<c:if test="${pvo.beginPage == 1 }">
					<li class="disable">&lt;</li>						
				</c:if>
				<c:if test="${pvo.beginPage != 1 }">
					<li><a href="myChannelContents.do?cPage=${pvo.beginPage - 1 }&search_select=${sessionScope.search_select }&search_filter=${sessionScope.search_filter }&search_value=${sessionScope.search_value }&rows=${sessionScope.rows}">&lt;</a></li>
				</c:if>
							
				<%-- 블록내에 표시할 페이지 태그 작성(시작페이지~끝페이지) --%>
				<c:forEach var="pageNo" begin="${pvo.beginPage }" end="${pvo.endPage }">
					<c:if test="${pageNo == pvo.nowPage }">
						<li class="now">${pageNo }</li>
					</c:if>
					<c:if test="${pageNo != pvo.nowPage }">
							<li>
								<a href="myChannelContents.do?cPage=${pageNo }&search_select=${sessionScope.search_select }&search_filter=${sessionScope.search_filter }&search_value=${sessionScope.search_value }&rows=${sessionScope.rows}">${pageNo }</a>
							</li>
					
					</c:if>
				</c:forEach>
								
				<%-- [다음으로]에 대한 사용여부 처리 --%>
				<c:if test="${pvo.endPage >= pvo.totalPage }">
					<li class="disable">&gt;</li>						
				</c:if>
								
				<c:if test="${pvo.endPage < pvo.totalPage }">
					<li><a href="myChannelContents.do?cPage=${pvo.endPage + 1 }&search_select=${sessionScope.search_select }&search_filter=${sessionScope.search_filter }&search_value=${sessionScope.search_value }&rows=${sessionScope.rows}">&gt;</a></li>
				</c:if>
			</ol>
		</c:if>
		
		</div>
		<br>
		<hr>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script> 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>	
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

<script>
	$().ready(function() {
		
		$("#search_select").on("change", viewInput);
		$("#rows").on("change", changeRows);
		$("#search_btn").on("click", checkInput);
		$(".longValue").on("mouseover", showFullValue);
		$(".longValue").on("mouseleave", hideFullValue);
		$("#allCheck").on("change", allCheck);
		$(".checks").on("change", eachCheck);
		
		// 세션 값 체크해서 조건 보여줌
		if ("${sessionScope.search_select ne null}") {
			$("#search_select").val("${sessionScope.search_select}").prop(
					"selected", true);
	
			if ($("#search_select").val() != "VTITLE") {
				$("#search_filter").val("${sessionScope.search_filter}").prop(
					"selected", true);
				viewInput();
			}
		}
		
		if ("${sessionScope.rows ne null}") {
			$("#rows").val("${sessionScope.rows}").prop(
					"selected", true);
		}
	});
	
	// 전체 체크
	function allCheck(menu) {
		checks_arr = $(".checks");
		let check_num = 0;

		if (menu == "ok") {
			$("#allCheck").prop("checked", true);
			allCheck();
		}
		if (menu == "hidden") {
			$("#allCheck").prop("checked", false);
			allCheck();
		}
		
		else {
			if ($("#allCheck").is(":checked")) {
				showMenu();
				for (let check of checks_arr) {
					$(check).prop("checked", true);
					check_num++;
				}
				$("#checkNum").text(check_num + "개 선택됨");
			}
			else {
				hiddenMenu();
				for (let check of checks_arr) {
					$(check).prop("checked", false);
				}
			}
		}
		
	}
	
	// 각각 체크
	function eachCheck() {
		
		let check_num = 0;
		let checks_arr = $(".checks");
		
		for (let check of checks_arr) {
			if($(check).is(":checked"))
				check_num++;
		}
		if (check_num > 0)
			showMenu();
		else
			hiddenMenu();

		
		if (check_num == checks_arr.length)
			$("#allCheck").prop("checked", true);
		else
			$("#allCheck").prop("checked", false);
		
		$("#checkNum").text(check_num + "개 선택됨");
	}
	
	function hiddenMenu() {
		$("#deleteMenu").css("display", "none");
	}
	
	function showMenu() {
		$("#deleteMenu").css("display", "block");
	}
	
	function deleteVideos() {
		// 확인해봄
		if (!confirm("정말로 삭제하시겠습니까?"))
			return false;
		
		// 체크된 거 배열
		let checks_arr = $(".checks");
		
		// 삭제할 videoIdx 배열 
		let delete_arr = [];
		
		for (let check of checks_arr) {
			if ($(check).is(":checked"))
				delete_arr.push($(check).next().val());
		}
		
		location.href = "deleteMyVideos.do?deleteArray=" + delete_arr;
	}
	
	function showFullValue() {
		$(this).next().css("display", "block");
		$(this).next().css("position", "absolute");	
		$(this).next().css("margin-left", "101px");	
		$(this).next().css("background-color", "black");
		$(this).next().css("color", "white");
		$(this).next().css("border-radius", "5px");
		$(this).next().css("opacity", "0.9");
	}
	
	function hideFullValue() {
		$(this).next().css("display", "none");
		$(this).next().css("position", "absolute");
	}
	
	function changeRows() {
		this.form.submit();
	}
	
	// select 박스 변경시
	function viewInput() {
		let searchSelect = $("#search_select").val();
		let searchFilter = $("#search_filter").val();
		let searchValue  = $("#search_value").val();

		if (searchSelect == "VTITLE") {
			$("#search_value").attr("placeholder", " 동영상 제목을 입력하세요.");
			$("#search_filter").css("display", "none");
			$("#search_btn").text("검색하기");
		} else {
			$("#search_filter").css("display", "inline-block");
			$("#search_btn").text("필터");

			if (searchSelect == "VREGDATE") {
				$("#search_value").attr("placeholder",
						" 날짜를 2023-11-20 형태로 입력하세요.");
			} else {
				$("#search_value").attr("placeholder", " 숫자를 입력하세요.");
			} 
		}
	}
	// 버튼 클릭시 입력값 검증
	function checkInput() {
		let searchSelect = $("#search_select").val();
		let searchFilter = $("#search_filter").val();
		let searchValue  = $("#search_value").val();
		
		// 날짜 유효값 검증
		if (searchSelect == "VREGDATE") {
			// 날짜 길이 짧거나 '-' 중간에 안 넣음
			if (searchValue.length != 10 || searchValue[4] != '-' || searchValue[7] != '-') {
				alert("날짜를 2023-11-20 형태로 입력하세요.");
				$("#search_value").focus();
				return false;
			}						
			for (let i = 0; i < searchValue.length; i++) {
				if (searchValue[i] == '-')
					continue;
				
				if (isNaN(searchValue[i])) {
					alert("날짜를 2023-11-20 형태의 숫자로 입력하세요.");
					$("#search_value").focus();
					return false;
				}
			}			
		}
		
		// 숫자 유효값 검증
		if (searchSelect == "VIEWS" ||
			searchSelect == "COMMENTS" ||
			searchSelect == "LIKES") {
			
			if (searchValue.trim() == "" || isNaN(searchValue)) {
				alert("숫자를 입력하세요.");
				$("#search_value").val("");
				$("#search_value").focus();
				return false;
			}
		}
		this.form.submit();
	}
</script>

</body>
</html>
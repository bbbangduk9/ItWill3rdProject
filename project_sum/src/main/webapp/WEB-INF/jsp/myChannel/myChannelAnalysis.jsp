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
<title>채널 분석</title>
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
}
</style>

<style>
	.data_box {
		text-align: center;
		border: 1px solid Gainsboro;
		border-top-width : 2px;
		font-size: 14px;
		background-color: WhiteSmoke;
		border-bottom: none;
	}
	#sub_count {
		font-size: 22px;
		font-weight: 600;
	}
	#comment_count {
		font-size: 22px;
		font-weight: 600;
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
				<div class="menu_item">
					<a style="text-decoration: none; cursor: pointer;" onclick="javascript:location.href='beforeMyChannelContents.do'">
						<span>
							<img src="resources/images/icon/videologo.png" width="20px" height="20px" alt="아이콘">
						</span>
						<span style="margin-left: 20px;">콘텐츠</span>
					</a>
				</div>	
				<div class="menu_item selected"><a style="text-decoration: none; cursor: pointer;" onclick="javascript:location.href='beforeMyChannelAnalysis.do'">
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
			<h3 class="mt-1 mb-2 ml-2" style="font-size:21px; font-weight:bold;">채널 분석</h3>
		</div>
		<hr>
			
		<!-- 왼쪽 -->
		<div class="mb-5" style="width:100%;">	
			<div class="float-left mb-4" style="width:70%;">
				<!-- 지난 ~일 동안  -->
				<h3 id="div_sum" class="mb-4" style="font-weight:bolder; text-align:center;">
				</h3>
			</div>
			<!-- 셀렉트 박스 -->
			<div class="mb-2">
				<div id="div_date" class="mb-2" style="text-align:right;">
				</div>
				<div class="float-right">
					<form name="frm">
						<select name="search_select" id="search_select">
							<option value="7">지난 7일</option>
							<option value="28">지난 28일</option>
							<option value="90">지난 90일</option>
							<option value="365">지난 365일</option>
						</select>
					</form>
				</div>
			</div>
		</div>	
		
		<div class="mt-6 ml-4" style="margin: 0 auto;">
			<br>
			<!-- 버튼 -->
			<div style="width:80%; margin: 0 auto; ">
				
				<div id="sub_value" class="pt-4 pb-4 w-50 float-left data_box" style="border-right: none;">
					<a href="javascript:ee('SUB')" style="text-decoration:none; color:black;">
						<div>구독자</div>
						<div id="sub_count">7</div>
					</a>
				</div>
				<div id="comment_value" class="pt-4 pb-4 w-50 float-right data_box" >
					<a href="javascript:ee('COMMENT')" style="text-decoration:none; color:black;">
						<div>댓글수</div>
						<div id="comment_count">7</div>
					</a>
				</div>
				<!-- 차트 그리기 -->
				<div id="div_chart" style="border:1px solid Gainsboro;">
				</div>
			</div>

		</div>
		
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script> 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>	
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script>
	var status = "SUB";

	window.onload = function() {
		ee();
	};

	$().ready(function() {
		
		$("#search_select").on("change", () => ee(status));
	});
	
	function changeColorSub() {
		$("#sub_value").css("background-color", "white");
		$("#sub_value").css("border-top-color", "#3e95cd");
		$("#comment_value").css("background-color", "WhiteSmoke");
		$("#comment_value").css("border-top-color", "Gainsboro");
	}
	
	function changeColorComment() {
		$("#comment_value").css("background-color", "white");
		$("#comment_value").css("border-top-color", "#3e95cd");
		$("#sub_value").css("background-color", "WhiteSmoke");
		$("#sub_value").css("border-top-color", "Gainsboro");
	}

	// 날짜 계산, 날짜 배열 생성
	function ee(option) {
		
		if (option != null && status != option)
			status = option;
		
		let search_select = $("#search_select").val();

		// 현재 시간
		let now = new Date();	
		
		// 오늘 날짜 
		let end_day = new Date(now.getFullYear(), now.getMonth(), now.getDate());
		let end_day_str = end_day.getFullYear() + "-" + 
					      (end_day.getMonth() + 1).toString().padStart(2, 0) + "-" +
					      end_day.getDate().toString().padStart(2, 0);
		
		
		// 시작 날짜
		let start_day = new Date(now.getFullYear(), now.getMonth(), now.getDate() - search_select + 1);
		let start_day_str = start_day.getFullYear() + "-" + 
							(start_day.getMonth() + 1).toString().padStart(2, 0) + "-" +
							start_day.getDate().toString().padStart(2, 0);
		
		$("#div_date").text(start_day_str + " ~ " + end_day_str);	
		// --------------------------------------------------------------------------
		
		// 날짜 배열
		/*
		지난 7일    - 7개 1일간격으로
		지난 28일  - 7개 4일간격으로
		지난 90일  - 7개 13일 간격으로
		지난 365일 - 12개 달별로
		
		*/
		// 날짜 배열
		let date_arr = new Array();
		let date_label = new Array();
		let term = 0;
		
		if (search_select != 365) {
			if (search_select == 7)
				term = 1;
			if (search_select == 28)
				term = 4;
			if (search_select == 90)
				term = 13;
			
			date_arr[0] = start_day_str;
			
			for (let i = 1; i < 7; i++) {
				let temp = new Date(start_day.getFullYear(), start_day.getMonth(), start_day.getDate() + (i * term));
				
				let yyyy = temp.getFullYear();
				let mm   = temp.getMonth() + 1;
				let dd   = temp.getDate();
				
				date_arr[i] = yyyy + "-" + 
							  mm.toString().padStart(2, 0) + "-" +
							  dd.toString().padStart(2, 0);
			}
			
			if (search_select != 7)
				date_arr[7] = end_day_str;
			
			date_label = date_arr;
			
			getJsonSubCount(search_select, date_arr);
			getJsonCommentCount(search_select, date_arr);
		}
		else {
			for (let i = 0; i < 13; i++) {
				let temp = new Date(start_day.getFullYear(), start_day.getMonth() + i);
				
				let yyyy = temp.getFullYear();
				let mm   = temp.getMonth() + 1;
				
				date_arr[i] = yyyy + "-" + 
							  mm.toString().padStart(2, 0);
				
				date_label[i] = yyyy.toString().substring(2, 4) + "년" + " " + mm + "월";
			}
			
			let arr = new Array();
			arr[0] = date_arr[0] + "-01";
			arr[1] = end_day_str;
			
			getJsonSubCount(search_select, arr);
			getJsonCommentCount(search_select, arr);
		}
		
		$("#div_chart").html("<canvas id='line-chart' width='700px' height='300px' style='margin-left:auto; margin-right:auto;'></canvas>");

		// 바뀜
		if (status == "SUB")
			getJsonChartSub(date_arr, date_label);

		if (status == "COMMENT")
			getJsonChartComment(date_arr, date_label);
		
	}
	
</script>
<script>
function getJsonSubCount(search_select, date_arr) {
	
	$.ajax("getJsonSubCount.do", {
		type : "post",
		data : JSON.stringify(date_arr), // JSON 형식 문자열
		
		// 서버로 전송하는 컨텐츠 유형(JSON 형식)
		contentType : "application/json",
		
		// 서버로 부터 응답받을 데이터 형식
		dataType : "json", 
		
		success : function (subCount) {
			$("#sub_count").text(subCount);
			if (status == "SUB")
				$("#div_sum").text("지난 " + search_select + "일 동안 채널의 증가된 구독자 수는 " + subCount + "명입니다.");
			
		},
		error : function () {
			alert("실패~~");			
		}
	});
}

function getJsonCommentCount(search_select, date_arr) {
	
	$.ajax("getJsonCommentCount.do", {
		type : "post",
		data : JSON.stringify(date_arr), // JSON 형식 문자열
		
		// 서버로 전송하는 컨텐츠 유형(JSON 형식)
		contentType : "application/json",
		
		// 서버로 부터 응답받을 데이터 형식
		dataType : "json", 
		
		success : function (commentCount) {
			$("#comment_count").text(commentCount);
			if (status == "COMMENT")
				$("#div_sum").text("지난 " + search_select + "일 동안 채널의 추가된 댓글 수는 " + commentCount + "개입니다.");
				
		},
		error : function () {
			alert("실패~~");			
		}
	});
}

// 구독자 수 추이
function getJsonChartSub(date_arr, date_label) {
	changeColorSub();
	
	$.ajax("getJsonChartSub.do", {
		type : "post",
		data : JSON.stringify(date_arr), // JSON 형식 문자열
		
		// 서버로 전송하는 컨텐츠 유형(JSON 형식)
		contentType : "application/json",
		
		// 서버로 부터 응답받을 데이터 형식
		dataType : "json", 
		
		success : function (data_list) {
			new Chart($("#line-chart"), {
				type: 'line',
				data: {
					labels: date_label,
					datasets: [{
						data: data_list,
						borderColor: "#3e95cd",
						fill: false
					}]
					
				},
				options: {
					layout: {
				        padding: {
				            left: 0,
				            right: 0,
				            top: 40,
				            bottom: 0
				        }
				    },
					responsive: false,
					tooltips: {
						enabled: false
					},
					hover: {
						animationDuration: 0
					},
					animation: {
						duration: 1,
						onComplete: function() {
							var chartInstance = this.chart;
							var ctx = chartInstance.ctx;
							
							ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
							ctx.fillStyle = "#3e95cd";
							ctx.textAlign = 'center';
							ctx.textBaseline = 'bottom';
							
							this.data.datasets.forEach(function (dataset, i) {
								var meta = chartInstance.controller.getDatasetMeta(i);
								meta.data.forEach(function (bar, index) {
									var data = dataset.data[index];
									ctx.fillText(data, bar._model.x, bar._model.y - 5);
								
								});
						
							});
							}
					},
					legend: {
						display: false
					},
					scales: {
						xAxes: [{
							gridLines: {
								display: false
							}
						}],
						yAxes: [{
							min: 0,
							max: 100,
							display: false,
							gridLines: {
								display: false
							},
							ticks: {
								beginAtZero: true,
							}
							
						}]
					}
				}
			});
		},
		error : function () {
			alert("실패~~");			
		}
	});
}

// 댓글 수 추이
function getJsonChartComment(date_arr, date_label) {
	changeColorComment();
	
	$.ajax("getJsonChartComment.do", {
		type : "post",
		data : JSON.stringify(date_arr), // JSON 형식 문자열
		
		// 서버로 전송하는 컨텐츠 유형(JSON 형식)
		contentType : "application/json",
		
		// 서버로 부터 응답받을 데이터 형식
		dataType : "json", 
		
		success : function (data_list) {
			new Chart($("#line-chart"), {
				type: 'line',
				data: {
					labels: date_label,
					datasets: [{
						data: data_list,
						borderColor: "#3e95cd",
						fill: false
					}]
					
				},
				options: {
					layout: {
				        padding: {
				            left: 0,
				            right: 0,
				            top: 20,
				            bottom: 0
				        }
				    },
					responsive: false,
					tooltips: {
						enabled: false
					},
					hover: {
						animationDuration: 0
					},
					animation: {
						duration: 1,
						onComplete: function() {
							var chartInstance = this.chart;
							var ctx = chartInstance.ctx;
							
							ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
							ctx.fillStyle = "#3e95cd";
							ctx.textAlign = 'center';
							ctx.textBaseline = 'bottom';
							
							this.data.datasets.forEach(function (dataset, i) {
								var meta = chartInstance.controller.getDatasetMeta(i);
								meta.data.forEach(function (bar, index) {
									var data = dataset.data[index];
									ctx.fillText(data, bar._model.x, bar._model.y - 5);
								
								});
						
							});
							}
					},
					legend: {
						display: false
					},
					scales: {
						xAxes: [{
							gridLines: {
								display: false
							}
						}],
						yAxes: [{
							min: 0,
							max: 100,
							display: false,
							gridLines: {
								display: false
							},
							ticks: {
								beginAtZero: true,
							}
							
						}]
					}
				}
			});
		},
		error : function () {
			alert("실패~~");			
		}
	});
}
</script>
</body>
</html>
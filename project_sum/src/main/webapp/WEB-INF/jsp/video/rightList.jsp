<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<style>
	.image{
		border:1px solid;
    	border-radius: 10px; 
	}
	.fts{
		font-size: 0.8em;
	}
</style>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js" integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V" crossorigin="anonymous"></script>
<table class="float-right">
	<c:forEach var="video" items="${rvideoList }">
			<tr>
				<td width="150" height="120">
					<a href="getVideo.do?videoIdx=${video.videoIdx }">
						<img src="thumimgs/${video.vimage }" width="150" height="120" class="image">
					</a>	
				</td>
				<td id="vrd">
					<div class="vt" style="width:250px; overflow:hidden; text-overflow:ellipsis; white-space: nowrap; font-size: 18px; font-weight: 700;">
               			${video.vtitle }
               		</div>
					<fmt:formatDate value="${video.vregdate}" pattern="yyyy-MM-dd" var="formattedDate" />
					<p class="fts">조회수 ${video.views } 회  ${formattedDate }</p>		
				</td>
			</tr>
	</c:forEach>
</table>


</body>
</html>
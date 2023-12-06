<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <title>FakeTube Main Page</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://kit.fontawesome.com/3fe52ae26b.js" crossorigin="anonymous"></script>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&family=Patrick+Hand&display=swap"rel="stylesheet"/>

<link rel="stylesheet" href="resources/css/main.css" />
<style>
a{
	color: white;
}
</style>
</head>
<body>

     <!-- listviews -->
   <div class="videolist">
      <c:forEach var="video" items="${videoList }">
         <div class="float-left">
            <a href="getVideo.do?videoIdx=${video.videoIdx }">
                <img src="thumimgs/${video.vimage }" width="250px" height="200px" class="thumimg" >         
               <div class="vt" style="width:300px; overflow:hidden; text-overflow:ellipsis; white-space: nowrap; font-size: 20px; font-weight: 600;">
                    ${video.vtitle }
               </div>
               <p class="vrd">
                  <fmt:formatDate value="${video.vregdate}" pattern="yyyy-MM-dd" var="formattedDate" />
                   조회수 ${video.views } 회  ${formattedDate} 
               </p>
            </a>         
         </div>
      </c:forEach>
   </div>
</div>
   <div id="container">
      
   </div>   
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script> 
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>   
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>   

</body>
</html>
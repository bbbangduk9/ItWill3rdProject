<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
.imageborder{
	margin-left: 10px;
    margin-right: 10px;
    border-radius: 70%;
    overflow: hidden;
    width: 50px;
    height: 50px;
}
</style>
<body>
	<table style="width: 80%">
      <c:forEach var="ms" items="${myLikesSelect }">
         <tr class="hoverPoint" onclick="moveVideo('${ms.videoIdx}')">
         <th rowspan="2" style="width: 10%">
            <img src="thumimgs/${ms.vimage }" style="width:180px;height:180px;">
         </th>
         <th colspan="2" style="font-size:20px;padding-left:20px;">${ms.vtitle }</th>
         </tr>
         <tr class="hoverPoint" onclick="moveSubscribe('${ms.memberId}')">
         <th style="width: 5%"><img src="profileImage/${ms.image }" class="imageborder"></th>
         <th style="padding-left:20px;font-size:20px;">${ms.title }</th>
      </tr>
      </c:forEach>
   </table>
</body>
</html>
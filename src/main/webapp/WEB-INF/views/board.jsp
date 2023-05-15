<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/user/login' : '/user/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'Logout'}"/>
<c:set var="loginIdView" value="${loginId=='' ? '' : 'ID='+=loginId}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>fastcampus</title>
  <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">
  <link rel="stylesheet" href="<c:url value='/css/boardList.css'/>">
  <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
<div id="menu">
  <ul>
    <li id="logo">fastcampus</li>
    <li>${loginIdView}</li>
    <li><a href="<c:url value='/'/>">Home</a></li>
    <li><a href="<c:url value='/board/list'/>">Board</a></li>
    <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
    <li><a href="<c:url value='/user/join'/>">Join</a></li>
    <li><a href=""><i class="fa fa-search"></i></a></li>
  </ul>
</div>
<script>
  let msg = "${msg}";
  if(msg=="LIST_ERR")  alert("게시물 목록을 가져오는데 실패했습니다. 다시 시도해 주세요.");
  if(msg=="READ_ERR")  alert("삭제되었거나 없는 게시물입니다.");
  if(msg=="DEL_ERR")   alert("삭제되었거나 없는 게시물입니다.");

  if(msg=="DEL_OK")    alert("성공적으로 삭제되었습니다.");
  if(msg=="WRT_OK")    alert("성공적으로 등록되었습니다.");
  if(msg=="MOD_OK")    alert("성공적으로 수정되었습니다.");
</script>
<div style="text-align:center">
  <div class="board-container">
    <h2>게시물 읽기</h2>
    <form action="" id="form">
      <input type="text" name="bno" value="${boardDto.bno}" readonly="readonly">
      <input type="text" name="title" value="${boardDto.title}" readonly="readonly">
      <textarea name="content" id="" cols="30" rows="10" readonly="readonly">${boardDto.content}</textarea>
      <button type="button" id="writeBtn" class="btn">등록</button>
      <button type="button" id="modifyBtn" class="btn">수정</button>
      <button type="button" id="removeBtn" class="btn">삭제</button>
      <button type="button" id="listBtn" class="btn">목록</button>
    </form>
  </div>
  <script>
    $(document).ready(function () {
      $("#listBtn").on("click", function(){
        location.href="<c:url value='/board/list?page=${page}&pageSize=${pageSize}'/>";
      });

      $("#removeBtn").on("click", function(){
        if(!confirm("정말로 삭제하시겠습니까?")) return;
        let form = $('#form')
        form.attr("action", "<c:url value="/board/remove?page=${page}&pageSize=${pageSize}"/>");
        form.attr("method","post");
        form.submit();
      });
    });
  </script>
</div>
</body>
</html>

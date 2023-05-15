<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/user/login' : '/user/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
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
    <div class="search-container">
      <form action="<c:url value="/board/list"/>" class="search-form" method="get">
        <select class="search-option" name="option">
          <option value="A" ${option=='A' ? "selected" : ""}>제목+내용</option>
          <option value="T" ${option=='T' ? "selected" : ""}>제목만</option>
          <option value="W" ${option=='W' ? "selected" : ""}>작성자</option>
        </select>

        <input type="text" name="keyword" class="search-input" type="text" value="${param.keyword}" placeholder="검색어를 입력해주세요">
        <input type="submit" class="search-button" value="검색">
      </form>
      <button id="writeBtn" class="btn-write" onclick="location.href='<c:url value="/board/write"/>'"><i class="fa fa-pencil"></i> 글쓰기</button>
    </div>

    <table>
      <tr>
        <th class="no">번호</th>
        <th class="title">제목</th>
        <th class="writer">이름</th>
        <th class="regdate">등록일</th>
        <th class="viewcnt">조회수</th>
      </tr>
      <c:forEach var="boardDto" items="${list}">
        <tr>
          <td class="no">${boardDto.bno}</td>
          <td class="title"><a href="<c:url value="/board/read?bno=${boardDto.bno}&page=${ph.page}&pageSize=${ph.pageSize}"/>">${boardDto.title}</a></td>
          <td class="writer">${boardDto.writer}</td>
          <c:choose>
            <c:when test="${boardDto.reg_date.time >= startOfToday}">
              <td class="regdate"><fmt:formatDate value="${boardDto.reg_date}" pattern="HH:mm" type="time"/></td>
            </c:when>
            <c:otherwise>
              <td class="regdate"><fmt:formatDate value="${boardDto.reg_date}" pattern="yyyy-MM-dd" type="date"/></td>
            </c:otherwise>
          </c:choose>
          <td class="viewcnt">${boardDto.view_cnt}</td>
        </tr>
      </c:forEach>
    </table>
    <br>
    <div class="paging-container">
      <div class="paging">
        <c:if test="${ph.totalCnt==null || ph.totalCnt==0}">
          <div> 게시물이 없습니다. </div>
        </c:if>
        <c:if test="${ph.totalCnt!=null && ph.totalCnt!=0}">
          <c:if test="${ph.showPrev}">
            <a class="page" href="<c:url value="/board/list?page=${ph.beginPage-1}"/>">&lt;</a>
          </c:if>
          <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
            <a class="page ${i==ph.page? "paging-active" : ""}" href="<c:url value="/board/list?page=${i}"/>">${i}</a>
          </c:forEach>
          <c:if test="${ph.showNext}">
            <a class="page" href="<c:url value="/board/list?page=${ph.endPage+1}"/>">&gt;</a>
          </c:if>
        </c:if>
      </div>
    </div>
  </div>
</div>
</body>
</html>

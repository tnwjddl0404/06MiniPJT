<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ page import="java.util.List" %>
  <%@ page import="com.model2.mvc.service.domain.*" %>
  <%@ page import="com.model2.mvc.common.*" %>
  <%@page import="com.model2.mvc.common.Page"%>
<%@page import="com.model2.mvc.common.util.CommonUtil"%>
<%-- <%
  	User user = (User)session.getAttribute("user");
	System.out.println("세션에 담긴 user:"+user);
	
	Search search = (Search)request.getAttribute("search");
	System.out.println("리퀘스트에 담긴 search:"+search);
	List<Purchase> list = (List<Purchase>)request.getAttribute("list");
	System.out.println("리퀘스트에 담긴 list:"+list);
	
	System.out.println("리퀘스트에 담긴 purchase:"+list);
	Page resultPage=(Page)request.getAttribute("resultPage");
	System.out.println("리퀘스트에 담긴 resultPage:"+resultPage);
	//==> null 을 ""(nullString)으로 변경
	/* String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword()); */
	
%> --%>
    
  <%System.out.println("listPurchase.jsp!!!!!"); %>

<html>
<head>
<title>구매 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
	function fncGetList(currentPage) {
		document.getElementById("currentPage").value = currentPage;
	   	document.detailForm.submit();		
	}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width: 98%; margin-left: 10px;">

<form name="detailForm" action="/listPurchase.do" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">구매 목록조회</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">
		전체 ${resultPage.totalCount }  건수,	현재 ${resultPage.currentPage} 페이지
	</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">회원명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">전화번호</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">배송현황</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">정보수정</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
<%-- <%
		int no  =list.size();
		int no2 =1;
			for(int i=0; i<list.size(); i++) {
		Purchase purchase = (Purchase)list.get(i);
			
	%> --%>
	
	<c:set var="i" value = "0"/>
	<c:forEach var="purchase" items="${list}">
	<c:set var="i" value="${ i+1 }" />
	<tr class="ct_list_pop">
		<td align="center">
			<a href="/getPurchase.do?tranNo=${purchase.tranNo}">${i}</a>
		</td>
		<td></td>
		<td align="center">
			<a href="/getUser.do?userId=${user.userId}">${user.userId}</a>
		</td>
		<td></td>
		<td align="center">${user.userName}</td>
		<td></td>
		<td align="center">${user.phone}</td>
		<td></td>
		<td align="center">
			<%-- <% if(purchase.getTranCode().equals("배송중")) {%> --%>
			<c:if test = "${!empty purchase.tranCode.trim() && purchase.tranCode.trim() =='1' }">
			 현재구매완료 상태입니다. 
			 </c:if>
			<c:if test = "${!empty purchase.tranCode.trim() && purchase.tranCode.trim() =='2' }">
			 현재 배송중입니다.  
			  </c:if>
			  <c:if test = "${!empty purchase.tranCode.trim() && purchase.tranCode.trim() =='3' }">
			 현재 배송완료 상태입니다.  
			  </c:if></td>
				<td></td>
			 
			 <td align="center">
			 <c:if test = "${purchase.tranCode.trim() =='2'}">
			<a href="/updateTranCode.do?tranNo=${purchase.tranNo}&tranCode=3&managerCheck=N">구매확정</a>
			<%-- <%} %> --%>
			</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	
	<%-- <%} %> --%>
	</c:forEach>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
	<tr>
		<td align="center">
		 <input type="hidden" id="currentPage" name="currentPage" value=""/>
		<%-- 	<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					◀ 이전
			<% }else{ %>
					<a href="javascript:fncGetList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					이후 ▶
			<% }else{ %>
					<a href="javascript:fncGetList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
			<% } %>
			 --%>
			<jsp:include page="../common/pageNavigator.jsp"/>	
		</td>
	</tr>
</table>

<!--  페이지 Navigator 끝 -->
</form>

</div>

</body>
</html>
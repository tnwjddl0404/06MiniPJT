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
	System.out.println("���ǿ� ��� user:"+user);
	
	Search search = (Search)request.getAttribute("search");
	System.out.println("������Ʈ�� ��� search:"+search);
	List<Purchase> list = (List<Purchase>)request.getAttribute("list");
	System.out.println("������Ʈ�� ��� list:"+list);
	
	System.out.println("������Ʈ�� ��� purchase:"+list);
	Page resultPage=(Page)request.getAttribute("resultPage");
	System.out.println("������Ʈ�� ��� resultPage:"+resultPage);
	//==> null �� ""(nullString)���� ����
	/* String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword()); */
	
%> --%>
    
  <%System.out.println("listPurchase.jsp!!!!!"); %>

<html>
<head>
<title>���� �����ȸ</title>

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
					<td width="93%" class="ct_ttl01">���� �����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;">
	<tr>
		<td colspan="11">
		��ü ${resultPage.totalCount }  �Ǽ�,	���� ${resultPage.currentPage} ������
	</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">ȸ����</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��ȭ��ȣ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
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
			<%-- <% if(purchase.getTranCode().equals("�����")) {%> --%>
			<c:if test = "${!empty purchase.tranCode.trim() && purchase.tranCode.trim() =='1' }">
			 ���籸�ſϷ� �����Դϴ�. 
			 </c:if>
			<c:if test = "${!empty purchase.tranCode.trim() && purchase.tranCode.trim() =='2' }">
			 ���� ������Դϴ�.  
			  </c:if>
			  <c:if test = "${!empty purchase.tranCode.trim() && purchase.tranCode.trim() =='3' }">
			 ���� ��ۿϷ� �����Դϴ�.  
			  </c:if></td>
				<td></td>
			 
			 <td align="center">
			 <c:if test = "${purchase.tranCode.trim() =='2'}">
			<a href="/updateTranCode.do?tranNo=${purchase.tranNo}&tranCode=3&managerCheck=N">����Ȯ��</a>
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
					�� ����
			<% }else{ %>
					<a href="javascript:fncGetList('<%=resultPage.getCurrentPage()-1%>')">�� ����</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					���� ��
			<% }else{ %>
					<a href="javascript:fncGetList('<%=resultPage.getEndUnitPage()+1%>')">���� ��</a>
			<% } %>
			 --%>
			<jsp:include page="../common/pageNavigator.jsp"/>	
		</td>
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ page import="java.util.List" %>
  <%@ page import="com.model2.mvc.service.domain.*" %>
  <%@ page import="com.model2.mvc.common.*" %>
  <%@page import="com.model2.mvc.common.Page"%>
<%@page import="com.model2.mvc.common.util.CommonUtil"%>
<%@ page import="java.util.Map" %>

<%
  	User user = (User)session.getAttribute("user");
	System.out.println("���ǿ� ��� user:"+user);
	
	Search search = (Search)request.getAttribute("search");
	System.out.println("������Ʈ�� ��� search:"+search);
	
	List<Map<String, Object>> list = (List<Map<String, Object>>)request.getAttribute("list");
	System.out.println("������Ʈ�� ��� purchase:"+list);

	
	Page resultPage=(Page)request.getAttribute("resultPage");
	System.out.println("������Ʈ�� ��� resultPage:"+resultPage);
	//==> null �� ""(nullString)���� ����
	/* String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword()); */
	
%>
    
  

<html>
<head>
<title>�ǸŸ����ȸ</title>

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

<form name="detailForm" action="/listSale.do" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"width="15" height="37"></td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="93%" class="ct_ttl01">�ǸŸ����ȸ</td>
				</tr>
			</table>
		</td>
		<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"	width="12" height="37"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
	
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				
				<%-- <option value="0" <%= (searchCondition.equals("0") ? "selected" : "")%>>��ǰ��ȣ</option>
				<option value="1" <%= (searchCondition.equals("1") ? "selected" : "")%>>��ǰ��</option>
				<option value="2" <%= (searchCondition.equals("2") ? "selected" : "")%>>��ǰ����</option>
				 --%>
				
				<option value="0"
				 <c:if test = "${search.searchCondition eq '0' }"> selected</c:if> >��ǰ��ȣ</option>
				<option value="1"
				 <c:if test = "${search.searchCondition eq '1' }"> selected</c:if> >��ǰ��</option>
				<option value="2"
				 <c:if test = "${search.searchCondition eq '2' }"> selected</c:if> >��ǰ����</option>

			</select>
			<input type="text" name="searchKeyword"  value="${search.searchKeyword }"
					 class="ct_input_g" style="width:200px; height:19px"
					 onkeydown ="javascript:if(event.keyCode==13){fncGetList(1);}"> 
		</td>
		
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23"/>
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetList();">�˻�</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top: 10px;" >
	<tr>
		<td colspan="11">
		��ü ${resultPage.totalCount }  �Ǽ�,	���� ${resultPage.currentPage} ������
	</td>
	</tr>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150" align="center">ȸ��ID</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">������</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">����ó</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">�����Ȳ</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">��������</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
<%-- <%
		int no=list.size();
		int no2=1;
			for(int i=0; i<list.size(); i++) {
		Map<String, Object> map= list.get(i);
			
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
			<a href="/getUser.do?userId=${purchase.buyer.userId}">${purchase.buyer.userId}</a>
		</td>
		<td></td>
		<td align="center">${purchase.receiverName}</td>
		<td></td>
		<td align="center">${purchase.receiverPhone}</td>
		<td></td>
		<td align="center">
			<c:if test = "${!empty purchase.tranCode.trim() && purchase.tranCode.trim() =='1' }">
				 ���籸�ſϷ� �����Դϴ�. 
		    </c:if>
			<c:if test = "${!empty purchase.tranCode.trim() && purchase.tranCode.trim() =='2' }">
			 	���� ������Դϴ�.  
			 </c:if>
			 <c:if test = "${!empty purchase.tranCode.trim() && purchase.tranCode.trim() =='3' }">
				 ���� ��ۿϷ� �����Դϴ�.  
			 </c:if></td></td>
			<td></td>
			<td align="center">
			<c:if test="${purchase.tranCode.trim() =='1'}">
			<a href="/updateTranCode.do?tranNo=${purchase.tranNo}&tranCode=2">��۽���</a>
			<%--  <% }%> --%>
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
			<%-- <% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
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
			<% } %> --%>
			<jsp:include page="../common/pageNavigator.jsp"/>
			
		</td>
	</tr>
</table>

<!--  ������ Navigator �� -->
</form>

</div>

</body>
</html>
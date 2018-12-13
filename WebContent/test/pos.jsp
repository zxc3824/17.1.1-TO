<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList,java.sql.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
table{
	text-align: center;
}
@font-face {
	font-family: '빙그레체';
	src: url(font/Binggrae.ttf) format('truetype');
}
body {
	font-family: '빙그레체' !important;
}
A:link {
	text-decoration: none
}

A:visited {
	text-decoration: none
}

A:hover {
	text-decoration: none
}
</style>
<script language="JavaScript">
function pagestart(){
	window.setTimeout(function(){document.getElementById("form1").submit();/*location.replace("pos.jsp");*/},1000);
	/*window.setTimeout(function(){
	$.ajax({
        url : 'pos.jsp',
        type : 'POST',
        data : $('#form1').serialize()
    });
    return false;
}, 1000);*/
}
</script>
<title>Insert title here</title>
</head>
<body onLoad="pagestart()" style="align:center">
	<sql:query var="rs" dataSource="jdbc/mysql"> /* DB 불러오기(빠른 order by를 위해 각 애트리뷰트 별개 선언) */
		select table_no, name, quantity_hot, quantity_ice, etc, verify, time, quantity_hotshot, quantity_iceshot, quantity_hotsyrup, quantity_icesyrup from ordertable order by time desc limit 30
	</sql:query>
	<%
	int i = -1;
	int num = 0;
	int ordernumber = 0;
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/test";
	
	ArrayList<Integer> orderIndex = new ArrayList<Integer>();
	String[] isVerify = request.getParameterValues("isVerify");
	String[] isCancel = request.getParameterValues("isCancel");
	if(isVerify != null || isCancel != null) { // 체크가 하나로도 될 시
		Class.forName(jdbc_driver);
		conn = DriverManager.getConnection(jdbc_url, "jspbook", "1234");
		String sql;
		
		String[] index = request.getParameterValues("index");
		String[] time = request.getParameterValues("time");
		
		if(isVerify != null){
			for(int a = 0; a < isVerify.length; a++) {
				if(isCancel !=null && isVerify[a].equals(isCancel[a])) { // 한 행에 체크가 둘 다 되어있을시 오류
					out.println("<script>alert('한 주문에 대해 수락과 삭제를 동시에 할 수 없습니다.');</script>");
					break;
				}
				for(int b = 0; b < index.length; b++) {
					if(isVerify[a].equals(index[b])) { // 수락 시 처리
						sql = "update ordertable set verify='y' where time=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, time[b]);
						pstmt.executeUpdate();
						break;
					}
				}
			}
		}
		if(isCancel != null){
			for(int a = 0; a < isCancel.length; a++) {
				if(isVerify !=null && isVerify[a].equals(isCancel[a])) { // 한 행에 체크가 둘 다 되어있을시 오류
					break;
				}
				for(int b = 0; b < index.length; b++) {
					if(isCancel[a].equals(index[b])) { // 삭제 시 처리
						sql = "delete from ordertable where time=?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, time[b]);
						pstmt.executeUpdate();
						break;
					}
				}
			}
		}
		response.sendRedirect("pos.jsp");
	}
	%>
	<c:forEach var="test" items="${rs.rows }">
		<c:if test="${test.etc != ''}"> <%-- DB의 etc에 내용이 있을 시 ArrayList에 저장(주문 시작) --%>
			<%
			i++;
			num = 0;
			num++;
			orderIndex.add(num);
			%>
		</c:if>
		<c:if test="${test.etc eq ''}"> <%-- DB의 etc에 내용이 없을 시 ArrayList값 +1(주문 도중) --%>
			<%
			num++;
			orderIndex.set(i, num);
			%>
		</c:if>
	</c:forEach>
	<%
	int[] orderindex = new int[orderIndex.size()];
	for(int j = 0; j < orderindex.length; j++) {
		orderindex[j] = orderIndex.get(j).intValue();
	}
	%>
	
	<center><%out.print(new java.util.Date()); %></center>
	<hr>
	
	<form name="form1" id="form1" method="post" action="pos.jsp">
		<table border=1 cellspacing=0 cellpadding=5 style="margin-left: auto; margin-right: auto; text-align: center; border-collapse : collapse">
			<tr>
				<td>id</td>
				<td>테이블</td>
				<td>이름</td>
				<td>수량(hot)</td>
				<td>수량(ice)</td>
				<td>기타 사항</td>
				<td>확인</td>
				<td style="background-color:#f99">삭제</td>
			</tr>
			<%
			int index = orderindex.length;
			i = 0;
			%>
			<c:forEach var="row" items="${rs.rows }">
				<tr>
					<c:if test="${row.etc != '' }">
						<td rowspan="<%=orderindex[i] %>">
							<%=index %>
							<input type="hidden" name="index" value="<%=index - 1%>">
						</td>
						<td rowspan="<%=orderindex[i] %>">${row.table_no }번</td>
					</c:if>
					<td>${row.name }</td>
					<td>
						${row.quantity_hot }
						<c:if test="${row.quantity_hotshot ne 0 or row.quantity_hotsyrup ne 0}">
							(
							<c:if test="${row.quantity_hotshot ne 0 }">샷:${row.quantity_hotshot }</c:if>
							<c:if test="${row.quantity_hotsyrup ne 0 }">시럽:${row.quantity_hotsyrup }</c:if>
							)
						</c:if>
					</td>
					<td>
						${row.quantity_ice }
						<c:if test="${row.quantity_iceshot ne 0 or row.quantity_icesyrup ne 0}">
							(
							<c:if test="${row.quantity_iceshot ne 0 }">샷:${row.quantity_iceshot }</c:if>
							<c:if test="${row.quantity_icesyrup ne 0 }">시럽:${row.quantity_icesyrup }</c:if>
							)
						</c:if>
					</td>
					<c:if test="${row.etc != '' }">
						<td rowspan="<%=orderindex[i] %>">
							${row.etc }
						</td>
					</c:if>
					<c:if test="${row.etc != '' }">
						<td rowspan="<%=orderindex[i] %>">
							<c:if test="${row.verify eq 'n' }">
								<input type="checkbox" name="isVerify" value="<%=index - 1 %>">
							</c:if>
							<c:if test="${row.verify eq 'y' }">
								✔
							</c:if>
							<input type="hidden" name="time" value="${row.time }">
						</td>
					</c:if>
					<c:if test="${row.etc != '' }">
						<td rowspan="<%=orderindex[i] %>" style="background-color:#f99">
							<input type="checkbox" name="isCancel" value="<%=index - 1 %>">
							<%
							index--;
							i++;
							%>
						</td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
	</form>
</body>
</html>
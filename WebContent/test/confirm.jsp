<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" errorPage="error.jsp" import="java.sql.*,java.util.*,java.text.*,java.util.Date"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<html> <!-- jsp(html + java) + jquery(javascript + css) + sql(db) + jstl + javascript -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<script	src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<title>주문 확인</title>
</head>
<body>
	<% // 받아온 테이블 번호 확인
	int tn;
	try {
		tn = Integer.parseInt(request.getParameter("tn"));
		if (tn >= 1 || tn <= 6) {
		} else {
			response.sendRedirect("error.jsp");
		}
	} catch (Exception e) {
		response.sendRedirect("error.jsp");
	}
	tn = Integer.parseInt(request.getParameter("tn"));
	%>
	
	<sql:query var="rs_1" dataSource="jdbc/mysql"> /* DB 불러오기 */
		select * from menutable where type='coffee'
	</sql:query>
	<sql:query var="rs_2" dataSource="jdbc/mysql">
		select * from menutable where type='tea'
	</sql:query>
	
	<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/test";
	
	int index = 0; // index 값 초기화
	String[] menuArray1 = request.getParameterValues("slider1"); // 이전 페이지 수량 받아오기(java)
	String[] menuArray2 = request.getParameterValues("slider2");
	pageContext.setAttribute("menuArray1", menuArray1); // java 변수를 jstl에서 사용할 수 있도록 설정
	pageContext.setAttribute("menuArray2", menuArray2);
	String[] addshotArray1 = request.getParameterValues("addshot1");
	String[] addshotArray2 = request.getParameterValues("addshot2");
	pageContext.setAttribute("addshotArray1", addshotArray1);
	pageContext.setAttribute("addshotArray2", addshotArray2);
	String[] addsyrupArray1 = request.getParameterValues("addsyrup1");
	String[] addsyrupArray2 = request.getParameterValues("addsyrup2");
	pageContext.setAttribute("addsyrupArray1", addsyrupArray1);
	pageContext.setAttribute("addsyrupArray2", addsyrupArray2);

	for(int i = 0; i < addshotArray1.length; i++) {
		if(Integer.parseInt(menuArray1[i]) < Integer.parseInt(addshotArray1[i])
				|| Integer.parseInt(menuArray2[i]) < Integer.parseInt(addshotArray2[i])
				|| Integer.parseInt(menuArray1[i]) < Integer.parseInt(addsyrupArray1[i])
				|| Integer.parseInt(menuArray2[i]) < Integer.parseInt(addsyrupArray2[i])) {
			out.println("<script>alert('옵션이 주문 개수를 초과할 수 없습니다.');history.go(-1);</script>");
		}
	}
	%>
	<c:set var="sum" value="0" />
	<c:set var="index" value="0" />
	
	<header data-role="header" data-position="fixed"> <!-- 헤더 부분 -->
		<h1>확인창</h1>
	</header>
	
	<div class="content" data-role="content" style="background-color:white"> <!-- 메인 부분 -->
	
	<c:forEach var="row1" items="${rs_1.rows }"> <!-- 테이블 내역을 가져와서 수량이 있는 부분만 출력 -->
		<c:if test="${menuArray1[index] eq '0' and menuArray2[index] eq '0'}"></c:if>
		<c:if test="${menuArray1[index] != '0' and menuArray2[index] eq '0'}">
			<ul data-role="listview" data-inset="true">
				<li data-role="list-divider">${row1.name }</li>
				<li>hot<span class="ui-li-count"><%=menuArray1[index] %></span></li>
				<c:if test="${addshotArray1[index] != '0'}"><li>샷 추가<span class="ui-li-count"><%=addshotArray1[index] %></span></li></c:if>
				<c:if test="${addsyrupArray1[index] != '0' }"><li>시럽 추가<span class="ui-li-count"><%=addsyrupArray1[index] %></span></li></c:if>
			</ul>
		</c:if>
		<c:if test="${menuArray1[index] eq '0' and menuArray2[index] != '0'}">
			<ul data-role="listview" data-inset="true">
				<li data-role="list-divider">${row1.name }</li>
				<li>ice<span class="ui-li-count"><%=menuArray2[index] %></span></li>
				<c:if test="${addshotArray2[index] != '0'}"><li>샷 추가<span class="ui-li-count"><%=addshotArray2[index] %></span></li></c:if>
				<c:if test="${addsyrupArray2[index] != '0' }"><li>시럽 추가<span class="ui-li-count"><%=addsyrupArray2[index] %></span></li></c:if>
			</ul>
		</c:if>
		<c:if test="${menuArray1[index] != '0' and menuArray2[index] != '0'}">
			<ul data-role="listview" data-inset="true">
				<li data-role="list-divider">${row1.name }</li>
				<li>hot<span class="ui-li-count"><%=menuArray1[index] %></span></li>
				<c:if test="${addshotArray1[index] != '0'}"><li>샷 추가<span class="ui-li-count"><%=addshotArray1[index] %></span></li></c:if>
				<c:if test="${addsyrupArray1[index] != '0' }"><li>시럽 추가<span class="ui-li-count"><%=addsyrupArray1[index] %></span></li></c:if>
				<li>ice<span class="ui-li-count"><%=menuArray2[index] %></span></li>
				<c:if test="${addshotArray2[index] != '0'}"><li>샷 추가<span class="ui-li-count"><%=addshotArray2[index] %></span></li></c:if>
				<c:if test="${addsyrupArray2[index] != '0' }"><li>시럽 추가<span class="ui-li-count"><%=addsyrupArray2[index] %></span></li></c:if>
			</ul>
		</c:if>
		<c:set var="sum" value="${sum + (menuArray1[index] * row1.price_hot) + (menuArray2[index] * row1.price_ice)}" />
		<%index = index + 1; %>
		<c:set var="index" value="${index + 1 }" />
	</c:forEach>
	
	<c:forEach var="row2" items="${rs_2.rows }">
		<c:if test="${menuArray1[index] eq '0' and menuArray2[index] eq '0'}"></c:if>
		<c:if test="${menuArray1[index] != '0' and menuArray2[index] eq '0'}">
			<ul data-role="listview" data-inset="true">
				<li data-role="list-divider">${row2.name }</li>
				<li>hot<span class="ui-li-count"><%=menuArray1[index] %></span></li>
			</ul>
		</c:if>
		<c:if test="${menuArray1[index] eq '0' and menuArray2[index] != '0'}">
			<ul data-role="listview" data-inset="true">
				<li data-role="list-divider">${row2.name }</li>
				<li>ice<span class="ui-li-count"><%=menuArray2[index] %></span></li>
			</ul>
		</c:if>
		<c:if test="${menuArray1[index] != '0' and menuArray2[index] != '0'}">
			<ul data-role="listview" data-inset="true">
				<li data-role="list-divider">${row2.name }</li>
				<li>hot<span class="ui-li-count"><%=menuArray1[index] %></span></li>
				<li>ice<span class="ui-li-count"><%=menuArray2[index] %></span></li>
			</ul>
		</c:if>
		<c:set var="sum" value="${sum + (menuArray1[index] * row2.price_hot) + (menuArray2[index] * row2.price_ice)}" />
		<%index = index + 1; %>
		<c:set var="index" value="${index + 1 }" />
		
	</c:forEach>
	
	<ul data-role="listview" data-inset="true"> <!-- 총 비용 출력 -->
	<li>총 비용<span class="ui-li-count"><c:out value="${sum } 원"/></span></li>
	</ul>
	
	<form name=form1 method="post">
	추가 주문 내역<input name="additional_order" type="text"> <!-- 추가 주문 내역 -->
	
	<input type="submit" value="주문"> <!-- 주문내역 DB에 추가 -->
	<input type="hidden" name="tn" value=<%=tn %>>
	<input type="hidden" name="or" value="1">
	<input type="hidden" name="check" value="off">
	<%index = 0; %>
	<c:forEach var="test1" items="${rs_1.rows }">
		<input type="hidden" name="slider1" value="<%=menuArray1[index] %>">
		<input type="hidden" name="slider2" value="<%=menuArray2[index] %>">
		<input type="hidden" name="addshot1" value="<%=addshotArray1[index] %>">
		<input type="hidden" name="addshot2" value="<%=addshotArray2[index] %>">
		<input type="hidden" name="addsyrup1" value="<%=addsyrupArray1[index] %>">
		<input type="hidden" name="addsyrup2" value="<%=addsyrupArray2[index] %>">
		<%index = index + 1; %>
	</c:forEach>
	<c:forEach var="test2" items="${rs_2.rows }">
		<input type="hidden" name="slider1" value="<%=menuArray1[index] %>">
		<input type="hidden" name="slider2" value="<%=menuArray2[index] %>">
		<%index = index + 1; %>
	</c:forEach>
	<%
		try{
		if(Integer.parseInt(request.getParameter("or")) == 1){
			boolean order = false;
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "jspbook", "1234");
			String sql = "select * from menutable";
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			for(int i = 0; rs.next(); i++) {
				if(Integer.parseInt(menuArray1[i]) != 0 || Integer.parseInt(menuArray2[i]) != 0) {
					order = true;
					break;
				}
			}
			
			if(order == false) out.println("<script>alert('주문 내역이 없습니다.');</script>");
			rs.beforeFirst();
			if(order == true){
				Date now= new Date();
				SimpleDateFormat SDFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				String time = SDFormat.format(now);
				ArrayList<String> menu_name = new ArrayList<String>(); // 메뉴 DB 이름 배열로 저장
				while(rs.next()) {
					menu_name.add(rs.getString("name"));
					if(rs.isLast()) break;
				}
				String[] name = new String[menu_name.size()];
				name = menu_name.toArray(name);
				String additional_order = "";
				/*
				for(int i = 0; i < addshotArray1.length; i++) {
					if(!addshotArray1[i].equals("0")) additional_order += name[i] + " hot 샷 : " + addshotArray1[i] + " / ";
					if(!addshotArray2[i].equals("0")) additional_order += name[i] + " ice 샷 : " + addshotArray2[i] + " / ";
					if(!addsyrupArray1[i].equals("0")) additional_order += name[i] + " hot 시럽 : " + addsyrupArray1[i] + " / ";
					if(!addsyrupArray2[i].equals("0")) additional_order += name[i] + " ice 시럽 : " + addsyrupArray2[i] + " / ";
				}
				*/
				boolean only1 = true;
				rs.beforeFirst();
				for(int i = 0; rs.next(); i++) {
					sql = "insert into ordertable(table_no, name, quantity_hot, quantity_ice, etc, time, quantity_hotshot, quantity_iceshot, quantity_hotsyrup, quantity_icesyrup) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; // 주문 DB 삽입(테이블 번호, 메뉴 이름, 각 수량, 추가 주문, 주문시간)
					pstmt = conn.prepareStatement(sql);
					if(Integer.parseInt(menuArray1[i]) != 0 || Integer.parseInt(menuArray2[i]) != 0) {
						pstmt.setInt(1, tn);
						pstmt.setString(2, name[i]);
						pstmt.setInt(3, Integer.parseInt(menuArray1[i]));
						pstmt.setInt(4, Integer.parseInt(menuArray2[i]));
						if(only1 == true) {
							if(request.getParameter("additional_order") == ""){
								pstmt.setString(5, additional_order + "특이 사항 없음");
							} else {
								pstmt.setString(5, additional_order + request.getParameter("additional_order"));
							}
							only1 = false;
						} else {
							pstmt.setString(5, "");
						}
						pstmt.setString(6, time);
						if(i < addshotArray1.length){
						pstmt.setString(7, addshotArray1[i]);
						pstmt.setString(8, addshotArray2[i]);
						pstmt.setString(9, addsyrupArray1[i]);
						pstmt.setString(10, addsyrupArray2[i]);
						} else {
							pstmt.setString(7, "0");
							pstmt.setString(8, "0");
							pstmt.setString(9, "0");
							pstmt.setString(10, "0");
						}
						pstmt.executeUpdate();
					}
				}
				response.sendRedirect("order_send.jsp?time=" + time + "&tn=" + tn);
			}
		}
		} catch (Exception e) {System.out.println(e);}
	%>
	</form>
	
	<input type="button" onclick="back();" value="돌아가기"> <!-- 전 페이지로 복귀(이전 선택 수량 유지) -->
	<script>
		function back(){
			history.go(-1);
		}
	</script>
	
	</div>
</body>
</html>
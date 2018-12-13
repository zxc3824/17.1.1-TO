<%@ page language="java" contentType="text/html; charset=utf-8" import="java.sql.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%request.setCharacterEncoding("utf-8"); %>
<%
Connection conn = null;
PreparedStatement pstmt = null;

String jdbc_driver = "com.mysql.jdbc.Driver";
String jdbc_url = "jdbc:mysql://localhost/test";

try{
	Class.forName(jdbc_driver);
	
	conn = DriverManager.getConnection(jdbc_url, "jspbook", "1234");
	
	String sql = "insert into menutable values(?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1,request.getParameter("type"));
	pstmt.setString(2,request.getParameter("name"));
	pstmt.setString(3,request.getParameter("price_hot"));
	pstmt.setString(4,request.getParameter("price_ice"));
	
	if(request.getParameter("type") != null){
		pstmt.executeUpdate();
	}
}
catch(Exception e){
	System.out.println(e);
}
%>

<html> <!-- html + jsp -->
<head>
<title>메뉴 추가 테스트</title>
</head>
<body>
<center>
<h1>메뉴 추가</h1>
<hr>

<form name=form1 method=post>
종류 : <select name=type>
<option>coffee</option>
<option>tea</option>
</select>
이름 : <input type=text name=name size=20>
가격(hot) : <input type=number name=price_hot>
가격(ice) : <input type=number name=price_ice>
<input type=submit value="등록">
</form>
<hr>
<h2>메뉴 목록</h2><p>
<%
try{
	String sql = "select type, name, price_hot, price_ice from menutable where type='coffee'";
	
	out.println("<h4>Coffee</h4>");
	
	pstmt = conn.prepareStatement(sql);
	
	ResultSet rs = pstmt.executeQuery();
	int i = 1;
	while(rs.next()){
		out.println(i + " : " + rs.getString("name") + " , " + rs.getString("price_hot") + " / " + rs.getString("price_ice") + "<br>");
		i++;
	}

	sql = "select type, name, price_hot, price_ice from menutable where type='tea'";
	
	out.println("<h4>Tea</h4>");
	
	pstmt = conn.prepareStatement(sql);
	
	rs = pstmt.executeQuery();
	i = 1;
	while(rs.next()){
		out.println(i + " : " + rs.getString("name") + " , " + rs.getString("price_hot") + " / " + rs.getString("price_ice") + "<br>");
		i++;
	}
	
	rs.close();
	pstmt.close();
	conn.close();
}
catch(Exception e){
	System.out.println(e);
}
%>
</center>
</body>
</html>
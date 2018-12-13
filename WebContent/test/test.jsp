<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
$('#form_submit').click(function(){
	   $.ajax({
	        type: 'post',
	        url: 'test.jsp',
	        success: function(data){
	            alert(data);
	        }
	   });
	    return false; //<- 이 문장으로 새로고침(reload)이 방지됨
	});
$(document).ready(function(){
	window.setTimeout(function(){
		$.ajax({
            type : 'POST',
            url : 'test.jsp',
            data : $('#form1').serialize()
        });
		return false;
	}, 1000);
});
function postForm()
{
    $.ajax({
        type: $('form1').attr('post'),
        url: $('/Capstone/test/' + this.id),
        data: $('form1').serialize(),
        dataType: 'json',
        async: true,
        success: function(data) {
            mediaSource = response.url;                
        },
        error: function (xhr, ajaxOptions, thrownError) {
            alert("Error: " + xhr.status + "\n" +
                    "Message: " + xhr.statusText + "\n" +
                    "Response: " + xhr.responseText + "\n" + thrownError);
        }
    });
    return false;
}
</script>
<title>Insert title here</title>	
</head>
<body style="align:center" onLoad="window.setTimeout(postForm(),1000);">
	<form name="form1" id="form1">
		<%=new java.util.Date() %>
		<input type="submit" name="form_submit" id="form_submit" value="확인">
	</form>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
	a<br>
</body>
</html>
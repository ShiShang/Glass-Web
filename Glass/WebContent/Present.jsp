<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="com.glass.Model.Article" %>
<%@ page import="com.glass.Model.Question" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="description"/>
<meta name="keywords" content="keywords"/> 
<meta name="author" content="author"/> 
<link rel="stylesheet" type="text/css" href="CSS/default.css" media="screen"/>
<title>Cicle-发表</title>

<script language="javascript"  src="JS/AjaxRequest.js"></script>	
<script language="javascript"  src="JS/glassFunctions.js"></script>	
<script language="javascript" >

function onload()
{
	var username="${sessionScope.username}";
	if(!"${sessionScope.username}")
	{
		document.getElementById('log').style.display= "none";
		document.getElementById('nolog').style.display= "block";
	}
    else{
	    document.getElementById('log').style.display= "block";
	    document.getElementById('nolog').style.display= "none";
    }
    var loader=new net.AjaxRequest("PresentServlet?action=getMyArticle&username="+username+"&nocache="+new Date().getTime(),deal_onload,onerror, "GET", "");
    var loader=new net.AjaxRequest("PresentServlet?action=getMyQuestion&username="+username+"&nocache="+new Date().getTime(),deal_onload,onerror, "GET", "");
}
function deal_onload()
{
	
}

function onerror()
{
	alert("出错啦！");
}
</script>
</head>


<body  onload="onload()">

<div class="container" >

	<div class="header">
		
		<div class="title">
			<h1>Cicle-发现更大的自己</h1>
		</div>

		<div class="navigation">
			<a href="Home.jsp">首页</a>
			<a href="Question.jsp">问题</a>
			<a href="Keep.jsp">收藏</a>
			<a href="Present.jsp">发表</a>
			<a href="Profile.jsp">个人信息</a>
			<div class="clearer"><span></span></div>
		</div>

	</div>
	<div class="main">
		
		<div class="content">
		    <br><br>
		    <h><a href="Article_Edit.jsp">发表文章  </a>&nbsp&nbsp&nbsp&nbsp&nbsp   <a href="Question_Edit.jsp">发布问题</a></h>
		    <br><br><br><br>   
		    <h style="color:black;font-size:16px;">我发表的文章：</h>
		    <br>	
             <p><% ArrayList<Article> ar_list=(ArrayList<Article>)request.getSession().getAttribute("ar_list");
		       if(ar_list==null || ar_list.size()<1){ %>
             <p>还没有发表文章哦，快去试试吧...</p>
             <% }else{
                 for(Article article:ar_list){ %></p>
			<p id="title"> <a href="Article_detail.jsp?action=getArticle&article_id=<%= article.getId() %>"><%= article.getTitle()  %> </a>&nbsp &nbsp &nbsp--发表于<%= article.getStart_time() %></p>
            <% } }%>
            
            <br><br><br><br>   
		    <h style="color:black;font-size:16px;">我发布的问题：</h>
		    <br>	
             <p><% ArrayList<Question> qu_list=(ArrayList<Question>)request.getSession().getAttribute("qu_list");
		       if(qu_list==null || qu_list.size()<1){ %>
             <p>还没有发布问题哦，快去试试吧...</p>
             <% }else{
                 for(Question question:qu_list){ %></p>
			<p id="title"> <a href="Question_detail.jsp?action=getQuestion&question_id=<%= question.getId() %>"><%= question.getTitle()  %> </a>&nbsp &nbsp &nbsp--发布于<%= question.getStart_time() %></p>
            <% } }%>
        </div>
		
		<div class="sidenav">
		    <div id="log">
            <h1>当前为登录状态</h1>
			<div>
			<button type="登出" value="logout" class="button"  onclick="logout()">退出</button>
			</div>
			</div>
			<div id="nolog">
			<h1>未登录,你是游客。&nbsp</h1><button type="登录" value="login" class="button" onclick="window.location.href='login.jsp'">登录</button><button type="注册" value="logout" class="button" onclick="window.location.href='register.jsp'"> 注册</button>
			</div>
			<h1>Search</h1>
			<form action="index.html">
			<div>
				<input type="text" name="search" class="styled" /> <input type="submit" value="submit" class="button" />
			</div>
			</form>

			<h1>Something</h1>
			<ul>
				<li><a href="index.html">pellentesque</a></li>
				<li><a href="index.html">sociis natoque</a></li>
				<li><a href="index.html">convallis</a></li>
			</ul>

			<h1>Another thing</h1>
			<ul>
				<li><a href="index.html">consequat molestie</a></li>
				<li><a href="index.html">sem justo</a></li>
				<li><a href="index.html">semper</a></li>
			</ul>

			<h1>Third and last</h1>
			<ul>
				<li><a href="index.html">sociis natoque</a></li>
				<li><a href="index.html">magna sed purus</a></li>
				<li><a href="index.html">tincidunt</a></li>
			</ul>

		</div>
	
		<div class="clearer">&nbsp;</div>

	</div>

</div>


<div class="footer">

	<div class="left">&copy; 2018 <a href="index.html">lala.com</a>. <a href="http://jigsaw.w3.org/css-validator/check/referer">Design By</a><a href="http://validator.w3.org/check?uri=referer">   @George</a>.</div>
	
	<div class="right"><a href="http://www.cssmoban.com/">Love Anna</a> from George <a href="http://cssmoban.com/">www.baidu.com</a></div>
	
	<div class="clearer">&nbsp;</div>

</div>

</body>

</html>
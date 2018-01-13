<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.glass.Model.Article" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="description"/>
<meta name="keywords" content="keywords"/> 
<meta name="author" content="author"/> 
<link rel="stylesheet" type="text/css" href="CSS/default.css" media="screen"/>
<title>Cicle-个人信息</title>

<script language="javascript"  src="JS/AjaxRequest.js"></script>	
<script language="javascript"  src="JS/glassFunctions.js"></script>	
<script language="javascript" >

function selprofile()
{   
	var username = "${sessionScope.username}";
	var loader=new net.AjaxRequest("UserServlet?action=selprofile&username="+username+"&nocache="+new Date().getTime(),deal_selprofile,onerror,"GET","");
}
function deal_selprofile()
{
	var result_json= eval('(' + this.req.responseText + ')');
	var user_json=result_json.message;
	var username=user_json.username;
	var email=user_json.email;
	var address=user_json.address;
	var profile=user_json.profile;
	
	if(username==null)
	{alert("请先登陆！");window.location="Home.jsp";}
	else{
	//处理显示
	document.getElementById('username').innerText="你好， "+username;
	document.getElementById('email').innerText="邮箱信息：  "+email;
	document.getElementById('address').innerText="地址信息：  "+address;
	document.getElementById('profile').innerText="个人简介：  "+profile;
	
	if(!"${sessionScope.username}")
	{
		document.getElementById('log').style.display= "none";
		document.getElementById('nolog').style.display= "block";
	}
    else{
	    document.getElementById('log').style.display= "block";
	    document.getElementById('nolog').style.display= "none";
    }}
}
function onerror()
{
	alert("出错啦！");
}
</script>


</head>


<body  onload="selprofile()">

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
		<br><br>
		<div class="content">
			<p id="username"></p>
			<p id="email"></p>		
			<p id="address"></p>			
			<p id="profile"></p>
            <br><br>
        </div>
		
		<div class="sidenav">
		<c:import url="/Sidenav_listServlet"/>
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
		    <h1>最新发表-文章</h1>
            <% ArrayList<Article> list_time=(ArrayList<Article>)request.getAttribute("list_time");
               if(list_time==null||list_time.size()<1) { out.print("暂无数据..."); }
 		       else {
 			   for(Article article:list_time) { 
 				  String name;
 			      if (article.getTitle().length()>10)
 			      {
 			         name=article.getTitle().substring(0,9)+"...";
 			      }else{ name=article.getTitle();}%>
			<ul>
				<li><a href="Article_detail.jsp?action=getArticle&article_id=<%=article.getId()%>"> <%=name %></a></li>
			</ul>
	    	<%}} %>
			<h1>点赞最多-文章</h1>
            <% ArrayList<Article> list_poll=(ArrayList<Article>)request.getAttribute("list_poll");
               if(list_poll==null||list_poll.size()<1) { out.print("暂无数据..."); }
 		       else {
 			   for(Article article:list_poll) { 
 				  String name;
 			      if (article.getTitle().length()>10)
 			      {
 			         name=article.getTitle().substring(0,9)+"...";
 			      }else{ name=article.getTitle();}%>
			<ul>
				<li><a href="Article_detail.jsp?action=getArticle&article_id=<%=article.getId()%>"> <%=name %></a></li>
			</ul>
			<%}} %>
	   </div>
		<div class="clearer">&nbsp;</div>
		</div>
	</div>



<div class="footer">

	<div class="left">copyright&copy; 2018 <a href="Home.jsp">cicle.top</a></div>
	
	<div class="right"><a href="index.jsp">Love Anna</a> from George <a href="Home.jsp">www.cicle.top</a></div>
	
	<div class="clearer">&nbsp;</div>

</div>

</body>

</html>
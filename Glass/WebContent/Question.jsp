<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="com.glass.Model.Question" %>
<%@ page import="com.glass.Model.Article" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.glass.Tools.Pagination" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="description" content="description"/>
<meta name="keywords" content="keywords"/> 
<meta name="author" content="author"/> 
<link rel="stylesheet" type="text/css" href="CSS/default.css" media="screen"/>
<title>Cicle-问题</title>


<script language="javascript"  src="JS/AjaxRequest.js"></script>	
<script language="javascript"  src="JS/glassFunctions.js"></script>	
<script language="javascript" >

function load()
{
	if(!"${sessionScope.username}")
	{
		document.getElementById('log').style.display= "none";
		document.getElementById('nolog').style.display= "block";
	}
    else{
	    document.getElementById('log').style.display= "block";
	    document.getElementById('nolog').style.display= "none";
    }
}
function onload(){
	return;
	}
function onerror()
{alert("出错啦");}

</script>
</head>


<body onload="load()">
<div class="container">

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
		<c:import url="Question_listServlet"/>
		<% ArrayList<Question> list=(ArrayList<Question>)request.getAttribute("list1");
		   if(list==null||list.size()<1) { out.print("没有数据？刷新一下试试..."); }
		   else {
			   for(Question question:list) { %>
			   
			<h1 style="font-size:16px"><a href='Question_detail.jsp?action=getQuestion&question_id=<%=question.getId() %>'> <%= question.getTitle() %>  </a></h1>
			<p>提问者 ：       <%=question.getAuthor() %>&nbsp&nbsp
			        提问时间：     <%=question.getStart_time() %>&nbsp&nbsp
			        赞（                 <%=question.getPoll() %>） &nbsp&nbsp
			        踩 （                <%=question.getHate() %>） 
			       回答 （                0                                                                   ） 
			</p>
			<%  if(question.getContents().length()>100){ %>
			<p  style="font-size:14px"> <%=question.getContents().substring(1,80) %>...&nbsp&nbsp&nbsp&nbsp
			<a href='Question_detail.jsp?action=getQuestion&question_id=<%=question.getId() %>'> <br>    阅读更多</a></p>
			 
			<% }else{ %>
			<p> <%= question.getContents() %></p>
			<% }}}%>
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
	    <br><br><br>
		<div class="clearer">&nbsp;</div>
		<% Pagination pagination=new Pagination(); 
		   String currentPage=(String)request.getAttribute("currentPage");
		   String listnum=(String)request.getAttribute("listnum");
		   String strHtml="";
		   if(listnum==null || listnum.equals("没有获取到问题！")){strHtml="";}else{
		   strHtml=pagination.printCtrl(currentPage,"Question.jsp?", listnum);}
		%>
		<%= strHtml %>

	</div>



<div class="footer">

	<div class="left">copyright&copy; 2018 <a href="Home.jsp">cicle.top</a></div>
	
	<div class="right"><a href="index.jsp">Love Anna</a> from George <a href="Home.jsp">www.cicle.top</a></div>
	
	<div class="clearer">&nbsp;</div>

</div>

</body>

</html>
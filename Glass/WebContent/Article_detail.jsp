<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.glass.Model.Article" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.glass.Tools.Pagination" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="CSS/default.css" media="screen"/>
<title>Cicle-文章</title>

<script language="javascript"  src="JS/AjaxRequest.js"></script>	
<script language="javascript"  src="JS/glassFunctions.js"></script>	
<script language="javascript">
function load()
{
	var article_id=GetQueryString("article_id");
	var loader=new net.AjaxRequest("ArticleServlet?action=getArticle&article_id="+article_id+"&nocache"+new Date().getTime(),onload,onerror,"GET","");
    var loader1=new net.AjaxRequest("ArticleServlet?action=getComment&article_id="+article_id+"&nocache"+new Date().getTime(),deal_getComment,onerror,"GET","");
}
function onload()
{
	var result=this.req.responseText;
	var rs_json=eval("("+result+")");
	var message=rs_json.message;
	var title=message.title;
	var author=message.author;
	var start_time=message.start_time;
	var contents=message.contents;
	var poll=message.poll;
	var hate=message.hate;
	if(message=="系统异常")
	{alert("该页面不存在！");
     window.location.href="Home.jsp";}
	else{
		document.getElementById("title").innerText=title;
		document.getElementById("author").innerText="作者：  "+author+"    创建时间："+start_time;
		document.getElementById("contents").innerText=contents;
		document.getElementById("poll").innerText="赞：     （"+poll+" )";
		document.getElementById("hate").innerText="踩 ：     （"+hate+" )";
	}
	//处理登录状态
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
function deal_getComment()
{
	var result=eval("("+this.req.responseText+")");
	var message=result.message;
	var length=message.length;
	//如果没有评论
	if(length==0)
		{
	     	    var node=document.createElement("p2");
	            node.setAttribute("style","color:grey");
	            var textnode=document.createTextNode("还没有评论，快来抢沙发吧~~");
	            node.appendChild(textnode);  
	            document.getElementById("comment").appendChild(node);
		}
	else{
		for(var i=0;i<length;i++)
			{
			    var time=message[i].start_time;
			    var name=message[i].real_name;
			    var content=message[i].content;
			    var str="#"+(i+1)+"楼"+time+"  "+name+"   说：";
			    var str1=content;
			    
			    var node=document.createElement("p2");
			    node.setAttribute("style","color:grey");
			    var textnode=document.createTextNode(str);
			    node.appendChild(textnode);  
			    var node1=document.createElement("p2");
			    var textnode1=document.createTextNode(str1);
			    node.appendChild(textnode1); 
			    
			    document.getElementById("comment").appendChild(node);
			    document.getElementById("comment").appendChild(document.createElement("br"));
			    document.getElementById("comment").appendChild(node1);
			    document.getElementById("comment").appendChild(document.createElement("br"));   
			}
	}
}
function poll()
{
	var article_id=GetQueryString("article_id");
	var loader=new net.AjaxRequest("ArticleServlet?action=poll&article_id="+article_id+"&nocache"+new Date().getTime(),deal_poll,onerror,"GET","");
}
function deal_poll()
{
	var result=this.req.responseText;
	if(result.indexOf("成功"))
		{
		    location.reload();
		    alert(result);
		}
	else{
		alert(result);
	}
}
function hate()
{
	var article_id=GetQueryString("article_id");
	var loader=new net.AjaxRequest("ArticleServlet?action=hate&article_id="+article_id+"&nocache"+new Date().getTime(),deal_hate,onerror,"GET","");
}
function deal_hate()
{
	var result=this.req.responseText;
	if(result.indexOf("成功"))
		{
		    location.reload();
		    alert(result);
		}
	else{
		alert(result);
	}
}
function submit_comment()
{
	var content=document.getElementById("comments").value;
	var username = "${sessionScope.username}";
	if(!"${sessionScope.username}")
	{
	    alert("您需要先登录哦！快去吧~");
	    window.location.href="login.jsp";
	    return;
	}
	var article_id=GetQueryString("article_id");
	var params="username="+username+"&article_id="+article_id+"&content="+content;
	if(content==""|| content==undefined){alert("请先编辑评论！");return;}
	else
		{
		  var loader=new net.AjaxRequest("ArticleServlet?action=submit_comment&nocache="+new Date().getTime(), deal_submit_comment,onerror,"POST", params)
		}
}
function deal_submit_comment()
{
	var result=this.req.responseText;
	if(result.indexOf("成功"))
		{
		alert(result);
		window.location.reload();
		}
	else{alert(result);}
}
function addFavorite()
{
	var username = "${sessionScope.username}";
	if(!"${sessionScope.username}"){alert("您尚未登录！");return;}
	var article_id=GetQueryString("article_id");
	var type="1";
	var params="username="+username+"&type="+type+"&article_id="+article_id;
	var loader=new net.AjaxRequest("PresentServlet?action=addFavorite&nocache="+new Date().getTime(), deal_addFavorite, onerror, "POST", params)
}
function deal_addFavorite()
{
	var result=this.req.responseText;
	if(result.indexOf("成功"))
		{
		   alert(result);
		   document.getElementById("favorite").setAttribute("style","color:green;");
		   document.getElementById("favorite").setAttribute("onclick","''");
		}
	else{
		alert(result);
		document.getElementById("favorite").setAttribute("style","color:red;");
	}
}
function onerror()
{
    alert("出错啦！");
}
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
            <br><br>
			<h1 id="title" style="font-size:20px"></h1><br>
			<div class="descr">
			<p id="author"></p>
			</div>
			
			<p id="contents" style="font-size:15px"></p>
			<p><a  id="poll"  onclick="poll()"></a> &nbsp &nbsp &nbsp &nbsp &nbsp <a id="hate"  onclick="hate()"></a>&nbsp &nbsp &nbsp &nbsp &nbsp<a  id="favorite"  onclick="addFavorite()">收藏</a></p>  &nbsp;&nbsp; 
            <br>
            <br>  

		<h1 >评论</h1><br>
		<h1 id="comment"></h1>

        <br>
        <br>
        <br>   
        <h1>发表评论</h1>
        <form>
        <textarea   rows="6" cols="70"  id="comments"></textarea><br><br>
		<input type="button" value="提交" onclick="submit_comment()">
		<br><br>
        </form>
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
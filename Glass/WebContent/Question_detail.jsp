<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="CSS/default.css" media="screen"/>
<title>知乎-问题</title>

<script language="javascript"  src="JS/AjaxRequest.js"></script>	
<script language="javascript"  src="JS/glassFunctions.js"></script>	
<script language="javascript">

function load()
{
	var question_id=GetQueryString("question_id");
	var loader=new net.AjaxRequest("QuestionServlet?action=getQuestion&question_id="+question_id+"&nocache="+new Date().getTime(),onload,onerror,"GET","");
	var loader1=new net.AjaxRequest("QuestionServlet?action=getAnswer&question_id="+question_id+"&nocache="+new Date().getTime(),deal_getAnswer,onerror,"GET","");
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

function deal_getAnswer()
{
	var result=eval("("+this.req.responseText+")");
	var message=result.message;
	var length=message.length;
	//如果没有评论
	if(length==0)
		{
	     	    var node=document.createElement("p2");
	            node.setAttribute("style","color:grey");
	            var textnode=document.createTextNode("还没有回答，快来添加一个吧~~");
	            node.appendChild(textnode);  
	            document.getElementById("answer").appendChild(node);
		}
	else{
		for(var i=0;i<length;i++)
			{
			    var time=message[i].start_time;
			    var name=message[i].real_name;
			    var content=message[i].content;
			    var str=name+"   在"+time+"  "+"   回答了：";
			    var str1=content;
			    
			    var node=document.createElement("p2");
			    node.setAttribute("style","color:grey");
			    var textnode=document.createTextNode(str);
			    node.appendChild(textnode);  
			    var node1=document.createElement("p2");
			    var textnode1=document.createTextNode(str1);
			    node.appendChild(textnode1); 
			    //换行
			    var brDiv = document.createElement('br');
                brDiv.innerHTML = "<br/>";
                
			    document.getElementById("answer").appendChild(node);
			    document.getElementById("answer").appendChild(brDiv)
			    document.getElementById("answer").appendChild(node1);
			    document.getElementById("answer").appendChild(document.createElement("br"));   
			}
	}
}

function poll()
{
	var question_id=GetQueryString("question_id");
	var loader=new net.AjaxRequest("QuestionServlet?action=poll&question_id="+question_id+"&nocache"+new Date().getTime(),deal_poll,onerror,"GET","");
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
	var question_id=GetQueryString("question_id");
	var loader=new net.AjaxRequest("QuestionServlet?action=hate&question_id="+question_id+"&nocache"+new Date().getTime(),deal_hate,onerror,"GET","");
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
function submit_answer()
{
	var content=document.getElementById("answers").value;
	var username = "${sessionScope.username}";
	if(!"${sessionScope.username}")
	{
	    alert("您需要先登录哦！快去吧~");
	    window.location.href="login.jsp";
	    return;
	}
	var question_id=GetQueryString("question_id");
	var params="username="+username+"&question_id="+question_id+"&content="+content;
	if(content==""|| content==undefined){alert("请先编辑答案！");return;}
	else
		{
		  var loader=new net.AjaxRequest("QuestionServlet?action=submit_answer&nocache="+new Date().getTime(), deal_submit_answer,onerror,"POST", params)
		}
}
function deal_submit_answer()
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
	var question_id=GetQueryString("question_id");
	var type="2";
	var params="username="+username+"&type="+type+"&question_id="+question_id;
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
			<h1>拉拉-发现更大的自己</h1>
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
			<h1 id="title"></h1>
			<div class="descr">
			<p id="author"></p>
			</div>
			
			<p id="contents"></p>
			<p><a  id="poll"  onclick="poll()"></a> &nbsp &nbsp &nbsp &nbsp &nbsp <a id="hate"  onclick="hate()"></a></a>&nbsp &nbsp &nbsp &nbsp &nbsp<a  id="favorite"  onclick="addFavorite()">收藏</a></p>  &nbsp;&nbsp; 
            <br>
            <br>  

		<h1 >回答</h1><br>
		<h1 id="answer"></h1>

        <br>
        <br>
        <br>   
        <h1>添加回答</h1>
        <form>
        <textarea   rows="6" cols="70"  id="answers"></textarea><br><br>
		<input type="button" value="提交" onclick="submit_answer()">
		<br><br>
        </form>
	    </div>
		<div class="sidenav">
		    <div id="log">
            <h1>当前为登录状态</h1>
			<button type="登出" value="logout" class="button"  onclick="logout()">退出</button>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>知乎-编辑问题</title>
    <link href="CSS/demo.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="JS/AjaxRequest.js"></script>	
   
    <script type="text/javascript">
    function save()
    {
    	var author=document.getElementById("author").value;
    	var email=document.getElementById("email").value;
    	var title=document.getElementById("title").value;
    	var tips=document.getElementById("tips").value;
    	var content=document.getElementById("content").value;
    	var start_time=new Date().getTime();
    	
    	if(author=="" ||email=="" ||title=="" ||tips=="" ||content=="")
    		{
    		   alert("请完善所有信息后再次提交！");
    		}
    	else
    		{
    		  var params="author="+author+"&email="+email+"&title="+title+"&content="+content;
    		  var loader=new net.AjaxRequest("QuestionServlet?action=save&nocache="+new Date().getTime(),deal_save,onerror,"POST",params);
    		}
    }
    function deal_save()
    {
    	var result=this.req.responseText;
    	var json=eval("("+result+")");
    	var message=json.message;
    	alert(message);
    	if(message.indexOf("成功"))
    		{
    		 window.location.href="Question.jsp";
    		}
    	else{
    		return;
    	}
    }
    function onerror()
    {
    	alert("出错啦！");
    }
    
    function islogin()
    {
    	if(!"${sessionScope.username}")
    		{
    		    alert("您需要先登录哦！快去吧~");
    		    window.location.href="login.jsp";
    		}
    }
    </script>  
</head>

<body onload="islogin()">
    <div class="demos-buttons">
        <h3>
            热门标签</h3>
        <a href="index.html" class="submit">Simple</a><br />
        <a href="flipin.html" class="submit">Flip In</a> <a href="fromright.html" class="submit">
            From Right</a>
        <br>
        <a href="bouncy.html" class="submit">Bouncy</a> <a href="fadein.html" class="submit active">
            Fade In</a><br>
        <a href="roatebottom.html" class="submit">Rotate From Bottom</a>
        <br>
        <a href="fromtop.html" class="submit">From Top</a><br>
        <a href="pagelevel01.html" class="submit">Page Level 01</a><br>
        <a href="pagelevel02.html" class="submit">Page Level 02</a><br>
        <a href="pagelevel03.html" class="submit">Page Level 03</a>
    </div>
    <section id="getintouch" class="fadeIn animated">
        <div class="container" style="border-bottom: 0;">
            <h1>
                <span>知乎--爱分享爱自由</span>
            </h1>
        </div>
        <div class="container">
            <form class="contact" action="#" method="post" id="form">
            <div class="row clearfix">
                <div class="lbl">
                    <label for="name">
                                                          提问者</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="author" name="name" data-required="true" data-validation="text"
                        data-msg="Invalid Name" placeholder="请输入姓名或昵称"  value="${sessionScope.username}" readonly="readonly">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="email">
                        邮箱</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="email" name="email" data-required="true" data-validation="email"
                        data-msg="Invalid E-Mail" placeholder="请输入邮箱">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="email">
                        标题</label>
                </div>
                <div class="ctrl">
                    <input type="text" id="title" name="phone" data-required="true" data-validation="custom"
                        data-msg="Invalid Phone #" placeholder="请输入标题">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="subject">
                        标签</label>
                </div>
                <div class="ctrl">
                    <input type="text" name="subject" id="tips" placeholder="请输入标签">
                </div>
            </div>
            <div class="row clearfix">
                <div class="lbl">
                    <label for="message">
                        问题描述</label>
                </div>
                <div class="ctrl">
                    <textarea id="content" name="message" rows="6" cols="10"  style="overflow-y:hidden; height:300px; color:grey;"></textarea>
                </div>
            </div>
            <div class="row  clearfix">
                <div class="span10 offset2">
                    <input id="submit" class="submit" value="写完了？ 提交一下"  onclick="save()">
                </div>
            </div>
            </form>
            <div id="success" style="display:none;">
                Your E-Mail has been sent successfully!</div>
            <div id="error" style="display:none;>
                Unable to send e-mail at the moment, please try later.</div>
            <div id="validation" ">
            </div>
        </div>
    </section>
</body>
</html>
    
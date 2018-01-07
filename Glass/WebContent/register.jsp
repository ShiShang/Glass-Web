<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Cicle-注册 </title>
	<meta author="George.Shi">
	<link rel="stylesheet" type="text/css" href="CSS/register-login.css">

<script type="text/javascript" src="JS/AjaxRequest.js"></script>	
<script language="javascript"  src="JS/glassFunctions.js"></script>	

<script type="text/javascript" language="javascript">
function flag()
{
	document.getElementById("checkinfo").innerHTML=" ";
}
function checkUser(str)
{
	if(str=="")
		{
		  document.getElementById("checkinfo").innerHTML="用户名不能为空！";
		  document.getElementById("checkinfo").style.display="block";
		  form.user.focus();
		}
	else if(! checklength(str,6))
		{
		  document.getElementById("checkinfo").innerHTML="用户名长度要大于6位！";
		  document.getElementById("checkinfo").style.display="block";
		  form.user.focus();
		}
	else
		{
		document.getElementById("checkinfo").innerHTML="";
		var loader=new net.AjaxRequest("UserServlet?action=checkUser&username="+str+"&nocache="+new Date().getTime(),deal,onerror,"GET","");
		}
}

function deal()
{
	result=this.req.responseText;
	result=result.replace(/\s/g,"");
	if (result==1)
		{
		return false;
		}
	else
		{
		alert(result);
		return false;
		}
}

function onerror(){		//错误处理函数
	alert("出错了");
	return;
}

function checkPwd(str)
{
     if(str.length<6 )
		 {
		  document.getElementById("checkinfo").innerHTML="用户密码应该以字母开头并大于6位！";
		  document.getElementById("checkinfo").style.display="block";
		  form.pwd.focus();
		 }
     else
    	 {
    	 document.getElementById("checkinfo").innerHTML="";
    	 }
}

function checkRepwd(str)
{
	if(str=="")
	 {
	  document.getElementById("checkinfo").innerHTML="请输入确认密码哦！";
	  document.getElementById("checkinfo").style.display="block";
	  form.repwd.focus();
	 }
	else if(form.pwd.value!=str)
	{
	  document.getElementById("checkinfo").innerHTML="二次输入的密码需要一致哦！";
	  document.getElementById("checkinfo").style.display="block";
	  form.repwd.focus();
	}
	else
	{
		document.getElementById("checkinfo").innerHTML="";
	}
	
}

function checkEmail(str)
{
	if(! checkeEmail(str))
		{

		  document.getElementById("checkinfo").innerHTML="邮箱地址的格式不正确！";
		  document.getElementById("checkinfo").style.display="block";
		  form.email.focus();
		}
	else
		{
		document.getElementById("checkinfo").innerHTML="";
		}
}
//var loader=new net.AjaxRequest("UserServlet?action=checkUser&username="+str+"&nocache="+new Date().getTime(),deal,onerror,"GET","");
function getProvince()
{ 
	var loader=new net.AjaxRequest("UserServlet?action=getProvince&nocache="+new Date().getTime(),deal_province,onerror,"GET","");
}

function deal_province()
{
	province=this.req.responseText.split(",");
	var sel = document.getElementById("province");
	sel.innerHTML = ""
	for(var i=0;i<province.length;i++)
		{
		sel.add(new Option(province[i],province[i])); 
		}
}

function getCity(selprovince)
{
	var sel = document.getElementById("province");
	var str=sel.value;
	if(!str){return;}
	var loader=new net.AjaxRequest("UserServlet?action=getCity&selprovince="+str+"&nocache="+new Date().getTime(),deal_city,onerror,"GET","");
}

function deal_city(str)
{
	var city="";
	city=this.req.responseText.split(",");
	var sel = document.getElementById("city");
	sel.innerHTML = ""
	for(var i=0;i<city.length;i++)
		{
		sel.add(new Option(city[i],city[i])); 
		}
}
function getQuestions()
{
	var loader=new net.AjaxRequest("UserServlet?action=getQuestion&nocache="+new Date().getTime(),deal_question,onerror,"GET","");
}
function deal_question()
{
	document.getElementById("question").innerHTML = "";
	question=this.req.responseText.split(",");
	var sel=document.getElementById("question");
	sel.innnerHTML="";
	for(var i=0;i<question.length;i++)
	{
		sel.add(new Option(question[i],question[i])); 
	}
}
function checkQuestion(str)
{
	if(str==""){
		  document.getElementById("checkinfo").innerHTML="请输入密码提示问题答案！";
		  document.getElementById("checkinfo").style.display="block";
		  form.answer.focus();
	}else{
		document.getElementById("checkinfo").innerHTML="";
	}
}

function save()
{
	var user=document.getElementById("user").value;
	var pwd=document.getElementById("pwd").value;
	var repwd=document.getElementById("repwd").value;
	var email=document.getElementById("email").value;
	var answer=document.getElementById("answer").value;
	if(user==""||email==""||pwd==""||repwd==""||answer==""){alert("你有信息未完善！");return;}
	else{
        var params="username="+form.user.value+"&password="+form.pwd.value+"&email="+form.email.value+"&address="+form.province.value+"-"+form.city.value+"&question="+form.question.value+"&answer="+form.answer.value;
        var loader=new net.AjaxRequest("UserServlet?action=save&nocache="+new Date().getTime(),deal_save,onerror,"POST",params);
        }
}
function deal_save()
{
	var msg=this.req.responseText;
	if(msg.indexOf("成功")>=0)
		{
		   alert(msg);
		   window.location.href="Home.jsp";
		}
	else{
		   alert(msg);
		   window.location.href="Register.jsp";
	}
}
</script>

	
</head>
<body onload="flag()">
<div id="box"></div>
<div class="cent-box register-box">
	<div class="cent-box-header">
		<h1 class="main-title hide">扯犊子</h1>
		<h2 class="sub-title">生活热爱分享 </h2>
	</div>

	<div class="cont-main clearfix">
		<div class="index-tab">
		<div class="index-slide-nav">
				<a href="/Glass/login.jsp">登录</a>
				<a href="/Glass/register.jsp" class="active">注册</a>
								
			</div>
		</div>

		<div class="login form">
			 <div class="group"  style="width:380px">
			    <form name="form" active='#' method='post'>
                     <table   width="100%" height="100%">
                     
                     <!-- 检查输入 并给出错误信息-->
                     <tr id="tr_user" style="display:none">
                         <td id="div_user"  width=100%  height=10px style="border:#FF6600 1px solid; color:#FF0000;"></td>
                     </tr>
                     
                     <tr>
                           <td width="93" height="40" align="right">*用户名：</td>
                           <td height="40" align="left"><input style="width:200px" id="user" name="user" type="text" onBlur="checkUser(this.value)">
			         <tr>
                           <td height="40" align="right">*密码：</td>
                           <td height="40" align="left"><input style="width:200px" id="pwd" name="pwd" type="password" onBlur="checkPwd(this.value)">
                     </tr>
                     <tr>
                           <td height="40" align="right">*确认密码：</td>
                           <td height="40" align="left"><input style="width:200px" id="repwd" name="repwd" type="password" onBlur="checkRepwd(this.value)">
                     </tr>
                <tr id="tr_email" style="display:none">
                  <td height="40" colspan="2" align="center"><div id="div_email" style="border:#FF6600 1px solid; color:#FF0000; width:90%; height:29px; padding-top:8px; background-image:url(images/div_bg.jpg)"></div></td>
                </tr>
                <tr>
                  <td height="40" align="right">*E-mail地址：</td>
                  <td height="40" align="left"><input style="width:200px" id="email" name="email" type="text" size="35" onBlur="checkEmail(this.value)">
                </tr>
                <tr>
                  <td height="40" align="right">*所在地：</td>
                  <td height="40" align="left">
                  <select style="width:95px" name="province" id="province"  onfocus="getProvince()">
                  <option ></option>
                  </select>
                  -
                  <select style="width:95px" name="city" id="city" onfocus="getCity(this.value)">
                      </select></td>
                </tr>
                <tr id="tr_question" style="display:none">
                  <td height="40" colspan="2" align="center"><div id="div_question" style="border:#FF6600 1px solid; color:#FF0000; width:90%; height:29px; padding-top:8px; background-image:url(images/div_bg.jpg)"></div></td>
                </tr>
                <tr>
                  <td height="40" align="right" style="width:120px">*密码提示问题：</td>
                  <td height="40" align="left"><select style="width:200px" name="question" id="question" onfocus="getQuestions()">
                  <!--  <input style="width:200px" name="question" type="text" id="question" size="35" onBlur="checkQuestion(this.value,this.form.answer.value)">  -->
                </tr>
                <tr id="tr_answer" style="display:none">
                  <td height="40" colspan="2" align="center"><div id="div_answer" style="border:#FF6600 1px solid; color:#FF0000; width:90%; height:29px; padding-top:8px; background-image:url(images/div_bg.jpg)"></div></td>
                </tr>
                <tr>
                  <td height="40" align="right">*提示问题答案：</td>
                  <td height="40" align="left"><input style="width:200px" name="answer" type="text" id="answer" size="35" onBlur="checkQuestion(this.value)"></td>
                </tr>
		 
                </table>
                <div style="text-align:center;"><input align="middle" type="button" value="注册" style="width:100px;"  onclick="save()"></input></div>
                <div align="middle" id="checkinfo" width=100%  height=10px style="color:red;"></div>
			<br>
			</form>
		</div>
	</div>
</div>
<br>
<div class="footer">
	<p>Cicle </p>
	<p>Designed By George  @ 2018</p>
</div>

<script src='JS/particles.js' type="text/javascript"></script>
<script src='JS/background.js' type="text/javascript"></script>
<script src='JS/jquery.min.js' type="text/javascript"></script>
<script src='JS/layer/layer.js' type="text/javascript"></script>
<script src='JS/index.js' type="text/javascript"></script>
<script>
	$('.imgcode').hover(function(){
		layer.tips("看不清？点击更换", '.verify', {
        		time: 6000,
        		tips: [2, "#3c3c3c"]
    		})
	},function(){
		layer.closeAll('tips');
	}).click(function(){
		$(this).attr('src','http://zrong.me/home/index/imgcode?id=' + Math.random());
	})

	$(".login-btn").click(function(){
		var email = $("#email").val();
		var password = $("#password").val();
		var verify = $("#verify").val();
		// $.ajax({
		// url: 'http://www.zrong.me/home/index/userLogin',
		// type: 'post',
		// jsonp: 'jsonpcallback',
  //       jsonpCallback: "flightHandler",
		// async: false,
		// data: {
		// 	'email':email,
		// 	'password':password,
		// 	'verify':verify
		// },
		// success: function(data){
		// 	info = data.status;
		// 	layer.msg(info);
		// }
		// })

	})
	$("#remember-me").click(function(){
		var n = document.getElementById("remember-me").checked;
		if(n){
			$(".zt").show();
		}else{
			$(".zt").hide();
		}
	})
</script>
</body>
</html>
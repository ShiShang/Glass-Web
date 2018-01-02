<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>登录 - 知乎 </title>
	<meta author="George.Shi">
	<link rel="stylesheet" type="text/css" href="CSS/register-login.css">

<script type="text/javascript" src="JS/AjaxRequest.js"></script>	
<script language="javascript"  src="JS/glassFunctions.js"></script>	

<script language="javascript" >
function login()
{
	var username=form.user.value;
	var pwd=form.pwd.value;
	
	if(username==""|| pwd==""){alert("用户名和密码不能为空！");return;}
	else
		{
		 var params="username="+username+"&password="+pwd;
		 var loader=new net.AjaxRequest("UserServlet?action=login&cache="+new Date().getTime(),deal_login,onerror,"POST",params);
		}
}

function deal_login()
{
	var msg=this.req.responseText;
	alert(msg);
	if(msg.indexOf("成功"))
		{
		    window.location.href="Home.jsp";
		}
	else
		{
		    return;
		}
}
	

</script>

<div id="box"></div>
<div class="cent-box register-box">
	<div class="cent-box-header">
		<h1 class="main-title hide">扯犊子</h1>
		<h2 class="sub-title">生活热爱分享 </h2>
	</div>

	<div class="cont-main clearfix">
		<div class="index-tab">
		<div class="index-slide-nav">
				<a href="/Glass/login.jsp" class="active">登录</a>
				<a href="/Glass/register.jsp">注册</a>
								
			</div>
		</div>

		<div class="login form">
			 <div class="group"  style="width:380px">
			    <form name="form" active='#' method='post'>
                     <table   width="100%" height="100%">
                     <br>
                     <!-- 检查输入 并给出错误信息-->
                     <tr id="tr_user" style="display:none">
                         <td  id="div_user"  width=100%  height=10px style="border:#FF6600 1px solid; color:#FF0000;"></td>
                     </tr>
                     
                     <tr>
                           <td width="93" height="40" align="right">用户名：</td>
                           <td height="40" align="left"><input style="width:200px" name="user" type="text">
                     </tr>
			         <tr>
                           <td height="40" align="right">密码：</td>
                           <td height="40" align="left"><input style="width:200px" name="pwd" type="password">
                     </tr>
		             <tr>
			         
                     </tr>
                </table>
                <br>
                <div style="text-align:center;"><input align="middle" type="button" value="登录" style="width:100px;"  onclick="login()"></input></div>
                <br>
                <br>
			</form>
			
		</div>
	</div>
</div>

<div class="footer">
	<p>知乎 </p>
	<p>Designed By George  @ 2017</p>
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
});
$("#remember-me").click(function(){
	var n = document.getElementById("remember-me").checked;
	if(n){
		$(".zt").show();
	}else{
		$(".zt").hide();
	}
});
</script>
</body>
</html>
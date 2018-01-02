/**
 * 定义一些工具js函数
 */
document.write("<script language=javascript src='JS/AjaxRequest.js'></script>");

function c()
{
	alert("hello");
	return "hello";
}

function checklength(str,length)
{
	if(str.length<length)
		{
		  return false;
		}
	else
		{
		  return true;
		}
}

function checkpwd(str)
{
	var password=str;
	var Expression=/^[A-Za-z]{1}([A-Za-z0-9]$/;
	var objExp=new RegExp(Expression);
	if(objExp.test(password)==true)
		{
		return true;
		}
	else
		{
		return false;
		}
}

function checkeEmail(str)
{
	var emailAddress=str;
	var Expression=/\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/;
	var objExp=new RegExp(Expression);
	if(objExp.test(emailAddress)!=true)
		{
		return false;
		}
	else
		{
		return true;
		}
}

function logout()
{
	var loader=new net.AjaxRequest("UserServlet?action=exit", onload, onerror, "GET", "");
	alert("退出成功！");
	location.reload();
}



function GetQueryString(name)
{
     var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
     var r = window.location.search.substr(1).match(reg);
     if(r!=null)return  unescape(r[2]); return null;
}

function islogin()
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

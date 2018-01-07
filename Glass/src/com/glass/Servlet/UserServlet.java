package com.glass.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;

import com.glass.Dao.*;
import com.glass.Model.*;
import org.apache.log4j.Logger;
/**
 * Servlet implementation class UserServlet
 */
public class UserServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
	private UserDao dao=null;
	private User user=null;
	//日志打印
	public static Logger logger1 = Logger.getLogger(UserServlet.class);
	
    public UserServlet() {
        super();
        dao=new UserDao();
        user=new User();  
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String action=request.getParameter("action");
		
		if("checkUser".equals(action))
		{
			try {
				this.checkUser(request,response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		else if("getProvince".equals(action))
		{
			this.getProvince(request, response);
		}
		else if("getCity".equals(action))
		{
			this.getCity(request, response);
		}
		else if("getQuestion".equals(action))
		{
			this.getQuestion(request, response);
		}
		else if ("save".equals(action))
		{
			this.save(request,response);
		}
		else if("login".equals(action))
		{
			try {
				this.login(request,response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		else if ("selprofile".equals(action))
		{
			try {
				this.selprofile(request,response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if("exit".equals(action))
		{
			this.exit(request,response);
		}
	}
	
	private void exit(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session=request.getSession();
		session.invalidate();
	}

	public void checkUser(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException
	{
		String username=request.getParameter("username");
		String result="";
		String sql="select username from tb_user where username=" +"'"+username+"'"+";";
		result=dao.checkUser(sql);
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		out.println(result);
		out.flush();
		out.close();
	}
	
	public void getProvince(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
        HashMap<String,String[]> map=dao.ProvinceCity();
		Iterator<String> it=map.keySet().iterator();
		String province="";
		while(it.hasNext())
		{
			province=province+it.next()+",";
		}
		province=province.substring(0, province.length()-1);
		response.setContentType("text/html");
		PrintWriter out=response.getWriter();
		out.println(province);
		out.flush();
		out.close();
	}
	
	public void getCity(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		request.setCharacterEncoding("utf-8");
		logger1.info("request:     "+request);
		HashMap<String,String[]> map=null;
		map=dao.ProvinceCity();
		logger1.info(map.toString());
	    String result="";
	    String selprovince=request.getParameter("selprovince");
	    String[] city=(String[]) map.get(selprovince);
	    logger1.info("province:"+selprovince+"city"+city);
	    for(int i=0;i<city.length;i++)
	    {
	    	result=result+city[i]+",";
	    	//System.out.println(result);
	    }
	    result=result.substring(0,result.length()-1);
	    PrintWriter out=response.getWriter();
	    response.setContentType("text/html");
	    out.println(result);
	    out.flush();
	    out.close();
	}
	public void getQuestion (HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String[] question=null;
	    question=dao.getquestion();
		String result="";
		for(int i=0;i<question.length;i++){
			result=result+question[i]+",";
		}
	    result=result.substring(0,result.length()-1);
	    PrintWriter out=response.getWriter();
	    response.setContentType("text/html");
	    out.println(result);
	    out.flush();
	    out.close();
	}
	
	public void save(HttpServletRequest request, HttpServletResponse response) throws IOException
	{
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String email=request.getParameter("email");
		String address=request.getParameter("address");
		String question=request.getParameter("question");
		String answer=request.getParameter("answer");
		
		String result="";
		String sql="insert into tb_user(username,password,email,question,answer,address)values("+"'"+username+"'"+","+"'"+password+"'"+","+"'"+email+"'"+","+"'"+question+"'"+","+"'"+answer+"'"+","+"'"+address+"'"+");";
		result=dao.save_user(sql);
		
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		out.println(result);
		out.flush();
		out.close();
	}
	
	public void login(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, ServletException
	{
			String username=request.getParameter("username");
			String password=request.getParameter("password");
			String result="";
	
	        String sql="select password from tb_user where username= "+"'"+username+"'";
			if(dao.checkepwd(sql,password)=="2")
			{    request.setAttribute("returnValue","你输入的密码不正确！");
			     request.getRequestDispatcher("userMessage.jsp").forward(request,response);
			}
			else if(dao.checkepwd(sql,password)=="1")
			{
				 request.setAttribute("returnValue","用户名不存在！");
			     request.getRequestDispatcher("userMessage.jsp").forward(request,response);
		    }
			else if(dao.checkepwd(sql,password)=="0")
			{
				
				 HttpSession session=request.getSession();
				 session.setAttribute("username", username);
				 request.setAttribute("returnValue","登录成功，去首页看看吧！");
				 request.getRequestDispatcher("userMessage.jsp").forward(request,response);
			}
	}
	
	public void selprofile(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, JSONException
	{
		String username=request.getParameter("username");
		String sql="select * from tb_user where username="+"'"+username+"'";
		JSONObject user=new JSONObject();
	    user=dao.userInfo(sql);
	    
	    PrintWriter out=response.getWriter();
	    response.setContentType("application/json");
	    out.println(user.toString());
	    out.flush();
	    out.close();
	}
}

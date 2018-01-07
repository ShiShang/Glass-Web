package com.glass.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONException;
import org.json.JSONObject;
import com.glass.Dao.*;
import com.glass.Model.Article;
/**
 * Servlet implementation class ArticleServlet
 */
public class ArticleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ArticleDao dao=null;
    ArrayList<Article> list=null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ArticleServlet() {
        super();
        dao=new ArticleDao();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
		doPost(request,response);
		
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    String action=request.getParameter("action");
	    if("save".equals(action))
	    {
	    	try {
				this.save(request,response);
			} catch (JSONException e) {
				e.printStackTrace();
			}
	    }
	    else if("getArticle".equals(action))
	    {
	    	try {
				this.getArticle(request,response);
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
	    else if("poll".equals(action))
	    {
	    	this.poll(request,response);
	    }
	    else if("hate".equals(action))
	    {
	    	this.hate(request,response);
	    }
	    else if("submit_comment".equals(action))
	    {
	    	this.submit_comment(request,response);
	    }
	    else if("getComment".equals(action))
	    {
	    	try {
				this.get_comment(request,response);
			} catch (SQLException | JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
	}

	private void get_comment(HttpServletRequest request,HttpServletResponse response) throws SQLException, JSONException, IOException {
		String article_id=request.getParameter("article_id");
		String sql="select * from tb_comment where article_id="+article_id+";";
		String result="";
		JSONObject jsonObject=dao.get_Comment(sql);

		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		out.print(jsonObject);
		out.flush();
		out.close();	
	}

	private void submit_comment(HttpServletRequest request,HttpServletResponse response) throws IOException {
		String result="";
		String article_id=request.getParameter("article_id");
		String username=request.getParameter("username");
		String content=request.getParameter("content");
		Timestamp start_time=new Timestamp(new Date().getTime());
		String sql="insert into tb_comment(article_id,real_name,start_time,content)values("+"'"+article_id+"',"+"'"+username+"',"+"'"+start_time+"',"+"'"+content+"');";
		//System.out.println(sql);
		
		result=dao.submit_comment(sql);
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		out.print(result);
		out.flush();
		out.close();
	}

	private void poll(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String article_id=request.getParameter("article_id");
		String sql="update tb_article set poll = (poll + 1) where a_id = "+"'"+article_id+"';";
		String result=dao.poll(sql);
		
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		out.print(result);
		out.flush();
		out.close();
	}
	
	private void hate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String article_id=request.getParameter("article_id");
		String sql="update tb_article set hate = (hate + 1) where a_id = "+"'"+article_id+"';";
		String result=dao.hate(sql);
		
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		out.print(result);
		out.flush();
		out.close();
	}

	private void getArticle(HttpServletRequest request,HttpServletResponse response) throws SQLException, JSONException, IOException 
	{
		String article_id=request.getParameter("article_id");
		String sql="select * from tb_article where a_id="+"'"+article_id+"';";
		JSONObject js=dao.article_detail(sql);
		
		PrintWriter out=response.getWriter();
		response.setContentType("application/json");
		//System.out.println(js.toString());
		out.print(js.toString());
		out.flush();
		out.close();
		
	}

	public void save(HttpServletRequest request,HttpServletResponse response) throws JSONException, ServletException, IOException
	{
		String author=request.getParameter("author");
		String email=request.getParameter("email");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		Timestamp start_time=new Timestamp(new Date().getTime());
		
		String sql="insert into tb_article(title,start_time,contents,author) values"+"("+"'"+title+"'"+","+"'"+start_time+"'"+","+"'"+content+"'"+","+"'"+author+"'"+")";
		String result="";
		int rs=dao.add_article(sql);
		JSONObject jsonObject = new JSONObject();
		if(rs==0)
		{
			jsonObject.put("success", "false");
			jsonObject.put("message", "系统异常");
		}
		else
		{
			jsonObject.put("success", "true");
			jsonObject.put("message", "文章保存成功！");
		}
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		out.print(jsonObject);
		out.flush();
		out.close();
		
	}
}

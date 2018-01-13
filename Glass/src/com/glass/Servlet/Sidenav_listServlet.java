package com.glass.Servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.glass.Dao.*;
import com.glass.Model.Article;
/**
 * Servlet implementation class ArticleServlet
 */
public class Sidenav_listServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ArticleDao dao=null;
    ArrayList<Article> list_time=null;
    ArrayList<Article> list_poll=null;

    public Sidenav_listServlet() {
        super();
        dao=new ArticleDao();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		String sql="select * from tb_article order by start_time DESC limit 5;";
	    String sql1="select * from tb_article order by poll DESC limit 5;";
	    String result="";
	    
		try{
			if(list_time != null ||list_poll != null)
			{
		    	list_time.clear();
			    list_poll.clear();
			}
	        list_time=dao.get_article(sql);
	        list_poll=dao.get_article(sql1);
			request.setAttribute("list_time", list_time);//获取文章列表
			request.setAttribute("list_poll", list_poll);
/*			System.out.println("size"+list_time.toString());*/
			System.out.println("size"+list_time.toString());
		}catch(Exception e){
        	e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
}
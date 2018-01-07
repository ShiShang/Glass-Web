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
public class Article_listServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private ArticleDao dao=null;
    ArrayList<Article> list=null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Article_listServlet() {
        super();
        dao=new ArticleDao();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//处理文章列列表
		String liststart=request.getParameter("liststart");
		String listend=request.getParameter("listend");
		if(liststart==null ||listend==null||liststart=="" ||listend=="" )
		{
			liststart="0";
			listend="10";
		}
		int start=Integer.parseInt(liststart);
		int end=Integer.parseInt(listend);
		String currentPage=(start%end==0)?((start/end+1)+""):((start/end+2)+"");
		String sql="select * from tb_article order by start_time DESC limit "+liststart+","+listend+";";
		
	    //处理分页
	    String sql1="select a_id from tb_article order by a_id DESC limit 1;";
	    String result="";
		try {
			result=dao.get_listnum(sql1);
			//System.out.println(result);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
		try{
			result=dao.get_listnum(sql1);
			if(list != null){
			list.clear();}
	      	list=dao.get_article(sql);
			request.setAttribute("list", list);//获取文章列表
			request.setAttribute("currentPage", currentPage); //获取当前页面
			request.setAttribute("listnum", result);//获取最大页面	
			//System.out.println("size"+list.size());
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
}
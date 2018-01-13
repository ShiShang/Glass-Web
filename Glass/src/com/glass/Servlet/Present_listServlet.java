package com.glass.Servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.glass.Dao.ArticleDao;
import com.glass.Dao.QuestionDao;


public class Present_listServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ArticleDao ar_dao=null;
	private QuestionDao qu_dao=null;

    public Present_listServlet() {
        super();
        ar_dao=new ArticleDao();
        qu_dao=new QuestionDao();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username=request.getParameter("username");
        String qu_sql="select * from tb_question where author="+"'"+username+"';";
        String ar_sql="select * from tb_article where author="+"'"+username+"';";
		ArrayList qu_list=null;
		ArrayList ar_list=null;
	
		try {
			qu_list = qu_dao.getMyQuestion(qu_sql);
			 ar_list=ar_dao.getMyArticle(ar_sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.getSession().setAttribute("qu_list", qu_list);
		request.getSession().setAttribute("ar_list", ar_list);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}
}

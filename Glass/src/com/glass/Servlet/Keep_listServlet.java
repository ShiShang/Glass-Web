package com.glass.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.glass.Dao.ArticleDao;
import com.glass.Dao.QuestionDao;
import com.glass.Model.Article;
import com.glass.Model.Question;

public class Keep_listServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ArticleDao ar_dao=null;
	private QuestionDao qu_dao=null;
       
    public Keep_listServlet() {
        super();
        ar_dao=new ArticleDao();
        qu_dao=new QuestionDao();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username=request.getParameter("username");
        String ar_sql="select * from tb_article where a_id in (select favorite_id from tb_favorite where username="+"'"+username+"'"+"and type='1');";
        String qu_sql="select * from tb_question where q_id in (select favorite_id from tb_favorite where username="+"'"+username+"'"+"and type='2');";
		ArrayList<Question> qu_list=null;
		ArrayList<Article> ar_list=null;
		
		try {
			ar_list=ar_dao.getArticleFavorite(ar_sql);
			qu_list = qu_dao.getQuestionFavorite(qu_sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		request.getSession().setAttribute("qu_list1", qu_list);
		request.getSession().setAttribute("ar_list1", ar_list);	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
}

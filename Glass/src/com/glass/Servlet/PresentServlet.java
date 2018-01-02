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

/**
 * Servlet implementation class PresentServlet
 */
public class PresentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ArticleDao ar_dao=null;
	private QuestionDao qu_dao=null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PresentServlet() {
        super();
        ar_dao=new ArticleDao();
        qu_dao=new QuestionDao();

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
		if("getMyArticle".equals(action))
		{
			try {
				this.getMyArticle(request,response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		else if("getMyQuestion".equals(action))
		{
			try {
				this.getMyQuestion(request,response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		else if("addFavorite".equals(action))
		{
			this.addFavorite(request,response);
		}
		else if("getFavorite".equals(action))
		{
			try {
				this.getFavorite(request,response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	private void getFavorite(HttpServletRequest request,HttpServletResponse response) throws SQLException, ServletException, IOException {
		String username=request.getParameter("username");
        String ar_sql="select * from tb_article where a_id in (select favorite_id from tb_favorite where username="+"'"+username+"'"+"and type='1');";
        String qu_sql="select * from tb_question where q_id in (select favorite_id from tb_favorite where username="+"'"+username+"'"+"and type='2');";
		ArrayList<Article> ar_list=ar_dao.getArticleFavorite(ar_sql);
		ArrayList<Question> qu_list=qu_dao.getQuestionFavorite(qu_sql);
		
		request.getSession().setAttribute("qu_list1", qu_list);
		request.getSession().setAttribute("ar_list1", ar_list);
		request.getRequestDispatcher("Keep.jsp").forward(request,response); 	
	}

	private void addFavorite(HttpServletRequest request,HttpServletResponse response) throws IOException {
		String type=request.getParameter("type");
		String username=request.getParameter("username");
		String result="";
		String favorite_id="";
		if("1".equals(type)){
			favorite_id=request.getParameter("article_id");
		}else{
			favorite_id=request.getParameter("question_id");
		}
		String sql="insert into tb_favorite(username,type,favorite_id)values"+"('"+username+"',"+"'"+type+"',"+"'"+favorite_id+"');";
		//System.out.println(sql);
		result=qu_dao.addFavorite(sql);
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		out.print(result);
		out.flush();
		out.close();		
		
	}

	private void getMyQuestion(HttpServletRequest request,HttpServletResponse response) throws SQLException, ServletException, IOException
	{
		String username=request.getParameter("username");
        String sql="select * from tb_question where author="+"'"+username+"';";
		ArrayList list=qu_dao.getMyQuestion(sql);
		
		request.getSession().setAttribute("qu_list", list);
		request.getRequestDispatcher("Present.jsp").forward(request,response); 
	}

	private void getMyArticle(HttpServletRequest request,HttpServletResponse response) throws SQLException, ServletException, IOException 
	{
		String username=request.getParameter("username");
        String sql="select * from tb_article where author="+"'"+username+"';";
		ArrayList list=ar_dao.getMyArticle(sql);
		request.getSession().setAttribute("ar_list", list);
		request.getRequestDispatcher("Present.jsp").forward(request,response); 
		
	}
	 

}

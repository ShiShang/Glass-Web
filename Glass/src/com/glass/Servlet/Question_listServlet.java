package com.glass.Servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.glass.Dao.QuestionDao;
import com.glass.Model.Question;

/**
 * Servlet implementation class QuestionServlet
 */
public class Question_listServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private QuestionDao dao=null;
    ArrayList<Question> list=null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Question_listServlet() {
        super();
        dao=new QuestionDao();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//处理问题列表
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
		String sql="select * from tb_question order by start_time DESC limit "+liststart+","+listend+";";
		
	    //处理分页
	    String sql1="select q_id from tb_question order by q_id DESC limit 1;";
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
	      	list=dao.get_question(sql);
			request.setAttribute("list1", list);//获取文章列表
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
	
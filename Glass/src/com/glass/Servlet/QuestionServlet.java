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

import com.glass.Dao.QuestionDao;
import com.glass.Model.Question;

/**
 * Servlet implementation class QuestionServlet
 */
public class QuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private QuestionDao dao=null;
    ArrayList<Question> list=null;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuestionServlet() {
        super();
        dao=new QuestionDao();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
	    else if("get_all".equals(action))
	    {
	    	try {
				this.get_question(request,response);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
	    else if("getQuestion".equals(action))
	    {
	    	try {
				this.getQuestion(request,response);
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
	    else if ("submit_answer".equals(action))
	    {
	    	this.submit_answer(request,response);
	    }
	    else if("getAnswer".equals(action))
	    {
	    	try {
				this.getAnswer(request,response);
			} catch (JSONException | SQLException e) {
				e.printStackTrace();
			}
	    }
	    
	}
    
	private void getAnswer(HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException, SQLException
	{
		String question_id=request.getParameter("question_id");
		String sql="select * from tb_answer where question_id="+question_id+";";
		String result="";
		JSONObject jsonObject=dao.get_Answer(sql);
		//System.out.println(jsonObject);
		
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		out.print(jsonObject);
		out.flush();
		out.close();	
		
	}

	private void submit_answer(HttpServletRequest request,HttpServletResponse response) throws IOException {
		String result="";
		String question_id=request.getParameter("question_id");
		String username=request.getParameter("username");
		String content=request.getParameter("content");
		Timestamp start_time=new Timestamp(new Date().getTime());
		String sql="insert into tb_answer(question_id,real_name,start_time,content)values("+"'"+question_id+"',"+"'"+username+"',"+"'"+start_time+"',"+"'"+content+"');";
		//System.out.println(sql);
		
		result=dao.submit_answer(sql);
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		out.print(result);
		out.flush();
		out.close();
		
	}

	private void poll(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String question_id=request.getParameter("question_id");
		String sql="update tb_question set poll = (poll + 1) where q_id = "+"'"+question_id+"';";
		String result=dao.poll(sql);
		
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		out.print(result);
		out.flush();
		out.close();
	}
	
	private void hate(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String question_id=request.getParameter("question_id");
		String sql="update tb_question set hate = (hate + 1) where q_id = "+"'"+question_id+"';";
		String result=dao.hate(sql);
		
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		out.print(result);
		out.flush();
		out.close();
	}

	private void getQuestion(HttpServletRequest request,HttpServletResponse response) throws SQLException, JSONException, IOException 
	{
		String question_id=request.getParameter("question_id");
		String sql="select * from tb_question where q_id="+"'"+question_id+"';";
		JSONObject js=dao.question_detail(sql);
		
		PrintWriter out=response.getWriter();
		response.setContentType("application/json");
		//System.out.println(js.toString());
		out.print(js.toString());
		out.flush();
		out.close();
		
	}

	private void get_question(HttpServletRequest request,HttpServletResponse response) throws SQLException {
		String sql="select * from tb_question order by start_time DESC limit 15";
		try{
			if(list != null){
			list.clear();}
	      	list=dao.get_question(sql);
			request.getSession().setAttribute("list1", list);
			//System.out.println("size"+list.size());
			request.getRequestDispatcher("Question.jsp").forward(request,response); 
		}catch(Exception e){e.printStackTrace();}
	}

	public void save(HttpServletRequest request,HttpServletResponse response) throws JSONException, ServletException, IOException
	{
		String author=request.getParameter("author");
		String email=request.getParameter("email");
		String title=request.getParameter("title");
		String content=request.getParameter("content");
		Timestamp start_time=new Timestamp(new Date().getTime());
		
		String sql="insert into tb_question(title,start_time,contents,author) values"+"("+"'"+title+"'"+","+"'"+start_time+"'"+","+"'"+content+"'"+","+"'"+author+"'"+")";
		System.out.print(sql);
		String result="";
		int rs=dao.add_question(sql);
		JSONObject jsonObject = new JSONObject();
		if(rs==0)
		{
			jsonObject.put("success", "false");
			jsonObject.put("message", "系统异常");
		}
		else
		{
			jsonObject.put("success", "true");
			jsonObject.put("message", "问题发布成功！");
		}
		PrintWriter out=response.getWriter();
		response.setContentType("text/html");
		out.print(jsonObject);
		out.flush();
		out.close();
		
	}
}

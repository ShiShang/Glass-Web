package com.glass.Dao;

import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import com.glass.Model.Article;
import com.glass.Model.Question;
import com.glass.Tools.ConnDB;

public class QuestionDao {
	private ConnDB conn=null;
	private ArrayList< Question>  question_list=null;
	
	public QuestionDao()
	{
		conn=new ConnDB();
		question_list=new ArrayList();
	}
	
	public int add_question(String sql) throws JSONException
	{
		int rs=conn.executeUpdate(sql);
		if(rs==0)
		{
			conn.close();
			return 0;
		}
		else
		{
			conn.close();
			return 1;
		}
  
    }
	
	public ArrayList<Question> get_question(String sql) throws SQLException
	{
		ResultSet rs=conn.executeQuery(sql);
		ResultSetMetaData md = rs.getMetaData();//获取键名
		int columnCount = md.getColumnCount();//获取行的数量
		for(int i=1;i<columnCount;i++){
		while(rs.next())
		{
		    Question question=new Question();
		    question.setId(rs.getInt("q_id"));
		    question.setTitle(rs.getString("title"));
		    String startTime=rs.getString("start_time");
		    question.setStart_time(startTime.substring(0,startTime.length()-2));
		    question.setModify_time(rs.getString("modify_time"));
		    question.setContents(rs.getString("contents"));
		    question.setAuthor(rs.getString("author"));
		    question.setPoll(rs.getInt("poll"));
		    question.setHate(rs.getInt("hate"));
		    question_list.add(question);
		}
		}
		conn.close();
		return question_list;
	}
	
	public JSONObject question_detail(String sql) throws SQLException, JSONException
	{
		JSONObject js=new JSONObject();
		ResultSet rs=conn.executeQuery(sql);
		Map<String,String> map=new HashMap();
		
	    if(rs.next())
	    {
	    	map.put("title",rs.getString("title"));
	    	map.put("start_time",rs.getString("start_time"));
	    	map.put("contents",rs.getString("contents"));
	    	map.put("author",rs.getString("author"));
	    	map.put("poll",rs.getInt("poll")+"");
	    	map.put("hate",rs.getInt("hate")+"");
	    	
	    	js.put("success","true");
	    	js.put("message",map);
	    }
	    else
	    {
	    	js.put("success","false");
	    	js.put("message","系统异常");
	    }
	    conn.close();
	    return js;
	}
	
	public String poll(String sql)
	{
		String result="";
		int rs=conn.executeUpdate(sql);
		if(rs==0)
		{
			result="点赞失败！";
		}else
		{
			result="点赞成功！";
		}
		conn.close();
		return result;
	}

	public String hate(String sql)
	{
		String result="";
		int rs=conn.executeUpdate(sql);
		if(rs==0)
		{
			result="点踩失败！";
		}else
		{
			result="点踩成功！";
		}
		conn.close();
		return result;
	}

	public String submit_answer(String sql) {
		String result="";
		int rs=conn.executeUpdate(sql);
		if(rs==0)
		{
			result="添加回答失败！";
		}else
		{
			result="添加回答成功！";
		}
		conn.close();
		return result;
	}

	public JSONObject get_Answer(String sql) throws JSONException, SQLException
	{
		JSONObject js=new JSONObject();
		ResultSet rs=conn.executeQuery(sql);
		ResultSetMetaData md = rs.getMetaData();//获取键名
		int columnCount = md.getColumnCount();//获取行的数量
		ArrayList list=new ArrayList();
		for(int i=1;i<columnCount;i++)
		{
	     	if(rs.next())
	            {
	    		Map<String,String> map=new HashMap();
	         	map.put("real_name",rs.getString("real_name"));
	         	String start_time=rs.getString("start_time");
	        	map.put("start_time",start_time.substring(0,start_time.length()-2));
	    	    map.put("content",rs.getString("content"));
	    	    list.add(map);
	            }
	   }
		conn.close();
		js.put("success","true");
    	js.put("message",list);
    	return js;
	}
	public ArrayList<Question> getMyQuestion(String sql) throws SQLException {
        ArrayList<Question> list=new ArrayList();
        Question question=new Question();
        ResultSet rs=conn.executeQuery(sql);
        ResultSetMetaData md = rs.getMetaData();//获取键名
		int columnCount = md.getColumnCount();//获取行的数量
		
		for(int i=1;i<columnCount;i++)
		{
	     	if(rs.next())
	            {
	     		    question.setTitle(rs.getString("title"));
	     		    question.setStart_time(rs.getString("start_time"));
	     		    question.setId(rs.getInt("q_id"));
	    		    list.add(question);
	            }
	   }
		conn.close();
		return list;	
	}

	public String addFavorite(String sql) 
	{
		int rs=conn.executeUpdate(sql);
		String result="";
		if(rs==0)
		{
			result="收藏失败！";
		}else
		{
			result="收藏成功！";
		}
		conn.close();
		return result;
	}

	public ArrayList getQuestionFavorite(String sql) throws SQLException {
		ArrayList<Question> list=new ArrayList();
        Question question=new Question();
        ResultSet rs=conn.executeQuery(sql);
        ResultSetMetaData md = rs.getMetaData();//获取键名
		int columnCount = md.getColumnCount();//获取行的数量
		
		for(int i=1;i<columnCount;i++)
		{
	     	if(rs.next())
	            {
	     		    question.setTitle(rs.getString("title"));
	     		    question.setAuthor(rs.getString("author"));
	     		    question.setId(rs.getInt("q_id"));
	    		    list.add(question);
	            }
	   }
		conn.close();
		return list;	
	}
	
	public String get_listnum(String sql) throws SQLException {
		ResultSet rs=conn.executeQuery(sql);
		String result="";
		if(rs.next())
		{
			result=rs.getInt("q_id")+"";
		}else{
			result="没有获取到问题！";
		}
		conn.close();
		return result;	
	}
}

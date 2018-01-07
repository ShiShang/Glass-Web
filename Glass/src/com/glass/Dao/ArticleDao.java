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
import com.glass.Tools.ConnDB;

public class ArticleDao {

	private ConnDB conn=null;
	private ArrayList<Article> article_list=null;
	
	public ArticleDao()
	{
		conn=new ConnDB();
		article_list=new ArrayList();
	}
	
	public int add_article(String sql) throws JSONException
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
	
	public ArrayList<Article> get_article(String sql) throws SQLException
	{
		ResultSet rs=conn.executeQuery(sql);
		ResultSetMetaData md = rs.getMetaData();//获取键名
		int columnCount = md.getColumnCount();//获取行的数量
		for(int i=1;i<columnCount;i++){
		while(rs.next())
		{
		    Article article=new Article();
		    article.setId(rs.getInt("a_id"));
		    article.setTitle(rs.getString("title"));
		    String startTime=rs.getString("start_time");
		    article.setStart_time(startTime.substring(0,startTime.length()-2));
		    article.setModify_time(rs.getString("modify_time"));
		    article.setContents(rs.getString("contents"));
		    article.setAuthor(rs.getString("author"));
		    article.setPoll(rs.getInt("poll"));
		    article.setHate(rs.getInt("hate"));
		    article_list.add(article);
		}
		}
		conn.close();
		return article_list;
	}
	
	public JSONObject article_detail(String sql) throws SQLException, JSONException
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

	public String submit_comment(String sql) {
		String result="";
		int rs=conn.executeUpdate(sql);
		if(rs==0)
		{
			result="添加评论失败！";
		}else
		{
			result="添加评论成功！";
		}
		conn.close();
		return result;
		
	}

	public JSONObject get_Comment(String sql) throws SQLException, JSONException {
		
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

	public ArrayList<Article> getMyArticle(String sql) throws SQLException {
        ArrayList<Article> list=new ArrayList();
        ResultSet rs=conn.executeQuery(sql);
        ResultSetMetaData md = rs.getMetaData();//获取键名
		int columnCount = md.getColumnCount();//获取行的数量
		
		for(int i=1;i<columnCount;i++)
		{
	     	if(rs.next())
	            {
	                Article article=new Article();
	    		    article.setTitle(rs.getString("title"));
	    		    article.setStart_time(rs.getString("start_time"));
	    		    article.setId(rs.getInt("a_id"));
	    		    list.add(article);
	            }
	   }
		conn.close();
		return list;	
	}

	public ArrayList<Article> getArticleFavorite(String sql) throws SQLException {
		ArrayList<Article> list=new ArrayList();
        ResultSet rs=conn.executeQuery(sql);
        ResultSetMetaData md = rs.getMetaData();//获取键名
		int columnCount = md.getColumnCount();//获取行的数量
		
		for(int i=1;i<columnCount;i++)
		{
	     	if(rs.next())
	            {
	                Article article=new Article();
	    		    article.setTitle(rs.getString("title"));
	    		    article.setAuthor(rs.getString("author"));
	    		    article.setId(rs.getInt("a_id"));
	    		    list.add(article);
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
			result=rs.getInt("a_id")+"";
		}else{
			result="没有获取到文章！";
		}
		conn.close();
		return result;	
	}

}

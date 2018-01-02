package com.glass.Dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import com.glass.Tools.*;

public class UserDao {
	
	private ConnDB conn=null;
	private HashMap<String,String[]> map=new HashMap();
	private String[] question={"中学的名字？","大学的名字？","心上人的名字？"};
	
	public UserDao()
	{
		conn=new ConnDB();
	}
	
	public String checkUser(String sql) throws SQLException
	{
		ResultSet rs=conn.executeQuery(sql);
		String result="";
		try{
		if(rs.next())
		{
			result="对不起，您所输入的用户名： < "+rs.getString(1)+" > 已经被注册，请重新输入哦！";
			conn.close();
			return result;
		}
		else
		{
			result="1";
		}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		conn.close();
		return result;
	}
	
	public String checkepwd(String sql,String pwd) throws SQLException
	{
		ResultSet rs=conn.executeQuery(sql);
		if(rs.next())
		{
			if(rs.getString(1).equals(pwd))
			{
				conn.close();
			    return "0"; //登录成功
			}
			else{
				conn.close();
				return "2";//密码错误
			}

		}else
		{
			conn.close();
			return "1";//用户不存在
		}
	}
	
	public HashMap<String, String[]> ProvinceCity()
	{
		String[] Shanghai_zone={"浦东","静安","黄埔","奉贤","嘉定","普陀","其他"};
		String[] Beijing_zone={"东城","西城","海淀","朝阳","丰台","石景山","顺义"};
		map.put("上海",Shanghai_zone);
		map.put("北京",Beijing_zone);
		System.out.println(map.entrySet().toString());
		return map;
	}
	 public String[] getquestion()
	 {
		 return question;
	 }
	 
	 public String save_user(String sql)
	 {
		 int rs=conn.executeUpdate(sql);
		 String result="";
		 if(rs==0)
		 {
			 result="注册失败，请检查用户信息！";
		 }else{
			 result="保存成功，快去试试吧！";
		 }
		 conn.close();
		return result ;
	 }
	 public JSONObject userInfo(String sql) throws SQLException, JSONException
	 {
		 ResultSet rs=conn.executeQuery(sql);
		 JSONObject jsonObject = new JSONObject();
		 if(rs.next())
		 {
			 Map<String,String> user_info=new HashMap();
			 user_info.put("username",rs.getString("username"));
			 user_info.put("password",rs.getString("password"));
			 user_info.put("email",rs.getString("email"));
			 user_info.put("follow",rs.getString("follow"));
			 user_info.put("address",rs.getString("address"));
			 user_info.put("profile",rs.getString("profile"));
			 jsonObject.put("success", "true");
			 jsonObject.put("message", user_info);
		 }
		 else
		 {
			 jsonObject.put("success", "true");
			 jsonObject.put("message","系统异常");
		 }
		 conn.close();
		 return jsonObject;
	 }
	 
}

package com.glass.Model;

import java.io.Serializable;

public class Question implements Serializable{
    
	private int id=0;
	private int poll=0;
	private int hate=0;
	private int answer=0;
	private String title="";
	private String start_time="";
	private String modify_time="";
	private String contents="";
	private String author="";
	
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id=id;
	}
	public int getPoll()
	{
		return poll;
	}
	public void setPoll(int poll)
	{
		this.poll=poll;
	}
	public int getHate()
	{
		return hate;
	}
	public void setHate(int hate)
	{
		this.hate=hate;
	}
	public int getAnswer()
	{
		return answer;
	}
	public void setAnswer(int answer)
	{
		this.answer=answer;
	}
	public String getTitle()
	{
		return title;
	}
	public void setTitle(String title)
	{
		this.title=title;
	}
	public String getAuthor()
	{
		return author;
	}
	public void setAuthor(String author)
	{
		this.author=author;
	}
	public String getStart_time()
	{
		return start_time;
	}
	public void setStart_time(String start_time)
	{
		this.start_time=start_time;
	}
	public String getModify_time()
	{
		return modify_time;
	}
	public void setModify_time(String modify_time)
	{
		this.modify_time=modify_time;
	}
	public String getContents()
	{
		return contents;
	}
	public void setContents(String contents)
	{
		this.contents=contents;
	}
}

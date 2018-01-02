package com.glass.Model;

public class User {
	
	public int id=1;
	public String username="";
	public String password="";
	public String email="";
	public int follow=0;
	public String question="";
	public String answer="";
	public String address="";
	public String profile="";
	
	public int getId()
	{
		return id;
	}
	public void setId(int id)
	{
		this.id=id;
	}
	public int getFollow()
	{
		return follow;
	}
	public void setFollow(int follow)
	{
		this.follow=follow;
	}
	public String getUsername()
	{
		return username;
	}
    public void setUsername(String username)
    {
    	this.username=username;
    }
    public String getPassword()
	{
		return password;
	}
    public void setPassword(String password)
    {
    	this.password=password;
    }
    public String Email()
	{
		return email;
	}
    public void setEmail(String email)
    {
    	this.email=email;
    }
    public String Question()
	{
		return question;
	}
    public void setQuestion(String question)
    {
    	this.question=question;
    }
    public String getAnswer()
	{
		return answer;
	}
    public void setAnswer(String answer)
    {
    	this.answer=answer;
    }
    public String getAddress()
	{
		return address;
	}
    public void setAddress(String address)
    {
    	this.address=address;
    }
    public String getProfile()
	{
		return profile;
	}
    public void setAProfile(String profile)
    {
    	this.profile=profile;
    }
    public String getUserInfo()
    {
    	return "username:"+username+"password:"+password+"email:"+email+"follow:"+follow+"question:"+question+"answer:"+answer+"address:"+address+"priofile:"+profile;
    }

}

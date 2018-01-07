package com.glass.Tools;

import java.util.ArrayList;
import java.util.List;

public class Pagination {
	
	public List list=null;
	private int pageSize=10;
	private int maxPage=1;
	
	/*public List getInitPage(List list,int Page,int pageSize)
	{
		List newlist=new ArrayList();
		this.list=list;
		recordCount=list.size();
		this.pageSize=pageSize;
		this.maxPage=getMaxPage();
		try
		{
          for(int i=(Page-1)*pageSize;i<Page*pageSize-1;i++)
          {
               try
               {
            	   if(i>-recordCount){break;}
               }catch(Exception e)
               {
            	   newlist.add(list.get(i));
               }
          }
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return newlist;
	}
	
	public List getAppointPage(int Page)
	{
		List newlist=new ArrayList();
		try
		{
			for(int i=(Page-1)*pageSize;i<=Page*pageSize-1;i++)
			{
				try
	               {
	            	   if(i>-recordCount){break;}
	               }catch(Exception e)
	               {
	            	   newlist.add(list.get(i));
	               }
	          }
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return newlist;
	}*/
	public int getmaxPage(String str)   //需要先调用这一步，设置最大页面；
	{
		int listnum=Integer.parseInt(str);
		if(listnum<pageSize){
			maxPage=1;
		}else
		{
			maxPage=(listnum%pageSize==0)?(listnum/pageSize):(listnum/pageSize+1);
		}
		return maxPage;

		
		/*if(str==null)
		{
			str="0";
		}
		int Page=Integer.parseInt(str);
		if(Page<1)
		{
			Page=1;
		}
		else
		{
			if(((Page-1)*pageSize+1)>recordCount)
			{
				Page=maxPage;
			}		
		}
		return Page;*/
	}
	public String printCtrl(String page,String url,String listnum)
	{
		this.maxPage=getmaxPage(listnum);
		int currentPage=Integer.parseInt(page);
        String strHtml="<table width='100%' border='0' cellspacing='0' cellpadding='0'><tr height='24' align='right'>当前页数：【"+currentPage+"/"+maxPage+"】&nbsp&nbsp&nbsp;";
	    try{
		   if(currentPage>1){
			   strHtml=strHtml+"<a href='"+url+"&liststart=0&listend="+pageSize+"'>第一页</a>&nbsp&nbsp&nbsp;";
			   strHtml=strHtml+"<a href='"+url+"&liststart="+(currentPage-2)*pageSize+"&listend="+pageSize+"'1>上一页</a>";
			  
		   }
		   if(currentPage<maxPage)
		   {
			   strHtml=strHtml+"<a href='"+url+"&liststart="+(currentPage)*pageSize+"&listend="+pageSize+"'>下一页&nbsp&nbsp&nbsp;</a>&nbsp&nbsp;<a href='"+url+"&liststart="+(maxPage-1)*pageSize+"&listend="+pageSize+"'>最后一页&nbsp;</a>";
		   }
		   strHtml=strHtml+"</td></tr></table>";
	   }catch(Exception e )
	   {
		   e.printStackTrace();
	   }
	   return strHtml;
	
	}
}

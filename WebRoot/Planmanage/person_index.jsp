<%@ page language="java" pageEncoding="gb2312"%>
<%@ page import="java.util.*"%>
<jsp:directive.page import="com.hiernate.util.*,com.hiernate.persistence.*;"/>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
	<html:base />
	<title>部门计划管理页面</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
 <link href="../CSS/style.css" rel="stylesheet" type="text/css">
 </head>
<body background="../Images/main_center.jpg">
  <table width="801" height="305" border="0" cellpadding="0" cellspacing="0" background="../Images/main_center.JPG">
  <tr>
    <td height="488" valign="top"><table width="100%" height="84%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td valign="top"><table width="100%" height="119" border="0" cellpadding="-2" cellspacing="-2" background="../images/bbs/bbs_01.gif">
          <tr valign="top">
            <td width="100%" height="43" background="../Images/main_top.JPG"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
			   <tr>
            <td width="5%"><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../Images/isexists.gif" width="16" height="16"></td>
           <td width="23%" align="left"><br>&nbsp;<b>个人计划</b></td>
          <td width="72%" valign="bottom">&nbsp;</td>
      </tr>
   
            </table></td>
          </tr>
          <tr valign="top">
          </tr>
        </table>
        <table width="91%" height="40%" border="0" align="center" cellpadding="0" cellspacing="0">
           <tr><td height="32"><table width="99%" height="32" border="0" cellpadding="0" cellspacing="0">
		   <tr>
            <td background="../Images/tiao.jpg"><table width="99%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td width="4%" valign="bottom">&nbsp;</td>
                <td width="72%" valign="bottom">&nbsp;</td>
                <td width="7%" valign="bottom"><div align="right"><img src="../Images/add.gif" width="20" height="18" /></div></td>
                <td width="17%" valign="bottom" class="STYLE2">&nbsp;<a href="#" onClick="Javascript:window.open('person_add.jsp','','width=560,height=360');return false">添加个人计划</a>
               </tr>
            </table></td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td valign="top">
		 <%
		 String currPage = request.getParameter("currPage");
         int iCurrPage = 1 ;
         int pages = 1 ;
         int allRecCount = 0 ;
         int recPerPage = 5 ;
         allRecCount = HibernateUtil.findPersonCount();       //查询出总的记录数
         pages = (allRecCount - 1)/recPerPage + 1 ;           //计算出总的页数
         if(pages == 0){                                      //对页数进行有效性处理,使页数的最小值是1
      	      pages = 1;
           }
        if(currPage != null && !currPage.equalsIgnoreCase("")){
        	iCurrPage = Integer.parseInt(currPage);
        	}
        List listPerson =HibernateUtil.findperson((iCurrPage - 1) * recPerPage, recPerPage);
		          if(listPerson.isEmpty()){
		               out.println("暂无信息");}
			
		%>
		<table width="728" height="55" border="0" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td><div align="center" class="STYLE2">个人姓名</div></td>
            <td><div align="center" class="STYLE2">计划主题</div></td>
            <td><div align="center" class="STYLE2">计划内容</div></td>
            <td><div align="center" class="STYLE2">发表日期</div></td>
            <td><div align="center" class="STYLE2">删除</div></td>
          </tr>
		  <%
		   if(!listPerson.isEmpty()&&listPerson.size()>0){
			for(int i=0;i<listPerson.size();i++){
			  Person person = (Person)listPerson.get(i);
		  %>
          <tr>
            <td height="23" class="STYLE2"><div align="center"><%=person.getName1()%>&nbsp;</div></td>
            <td height="23" class="STYLE2"><div align="center">
			<%if(person.getTitle().length()>6){%>
			<a href="#" onClick="Javascript:window.open('person_xianshi.jsp?currPage=<%=iCurrPage%>&&ID=<%=person.getId()%>','','width=456,height=459');return false"><%=person.getTitle().substring(0,6)+"...."%></a>
			<%}else{%>
			<a href="#" onClick="Javascript:window.open('person_xianshi.jsp?currPage=<%=iCurrPage%>&&ID=<%=person.getId()%>','','width=456,height=459');return false"><%=person.getTitle()%></a>
			<%}%>
		    &nbsp;
			</div></td>
            <td height="23" class="STYLE2"><div align="center">
			<%if(person.getContent().length()>8){%>
			<%=person.getContent().substring(0,8)+"...."%>
			<%}else{%>
			<%=person.getContent()%>&nbsp;
			<%}%>
			</div></td>
            <td height="23" class="STYLE2"><div align="center"><%=person.getTime1()%>&nbsp;</div></td>
            <td height="23"><div align="center">
             <%  String purview = (String)application.getAttribute("Purview");
                        if(!purview.equalsIgnoreCase("系统")){
                     	 %>
                     	  <a href="personodel.jsp">
                     	 <img src="../Images/del.gif" width="16" height="16" border="0"></td>
                    	  <%} %>
                    	   <%if(purview.equalsIgnoreCase("系统")){ %>
            <a href="person_del.jsp?currPage=<%=iCurrPage%>&&id=<%=person.getId()%>&link=<%=listPerson.size()%>" onClick="return confirm('是否确认删除?')"><img src="../Images/del.gif" width="16" height="16" border="0"></a>
          </tr>
		  <%}}}%>
        </table>
		<table width="728" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td height="25" class="STYLE2"><div align="right" class="STYLE2">
               
                <%
               
                if(recPerPage < allRecCount){
                String href = "&nbsp;&nbsp;<a href='person_index.jsp?currPage=";
                StringBuffer sbf = new StringBuffer();                  //制作分页条
                if(iCurrPage > 1){                                      //构造上一页
              	sbf.append(href+(iCurrPage - 1)+"'>上一页</a>");
                   }
                for(int i = 1 ; i <= pages ; i ++){
              	if(i == iCurrPage){
              		sbf.append(href+i+"'>["+i+"]</a>");                 //追加串
              	  }
              	else{
              		sbf.append(href+i+"'>"+i+"</a>");
              	 }
                }
               if(iCurrPage < pages){                                    //构造下一页
              	sbf.append(href+(iCurrPage + 1)+"'>下一页</a>");
                } %>
                <%out.print("当前页数:["+iCurrPage+"/"+pages+"]");%>
                <%=sbf.toString()%>
                <%}%>
                </div>
           </td>
      </tr>
    </table></td>
  </tr>
</table>
</body>





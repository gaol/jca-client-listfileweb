<%@ page import="org.jboss.jca.sample.listfiles.*" %>
<html>
<body>
<h2>Hello JCA!</h2>
<form action="index.jsp">
Directory: <input type="text" name="dir" />&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" value="List Files"/>
</form>
<br />
<%
         String dir = request.getParameter("dir");
         String files = "";
         if (dir != null && dir.length() != 0){
             String jndiName = "java:/eis/ListFilesConnectionFactory";
             javax.naming.InitialContext ctx = null;
             try
             {
                ctx = new javax.naming.InitialContext();
                Object obj = ctx.lookup(jndiName);
                if(obj != null){
                   java.lang.reflect.Method method = obj.getClass().getMethod("getConnection", new Class<?>[0]);
                   Object connObj = method.invoke(obj, new Object[0]);
                   method = connObj.getClass().getMethod("listFiles",new Class<?>[]{String.class});
                   files = method.invoke(connObj,new Object[]{dir}).toString();
                }
             }
             catch (Exception e)
             {
                e.printStackTrace();
             }
             finally
             {
                try
                {
                   ctx.close();
                }
                catch (Exception e)
                {
                   e.printStackTrace();
                }
             }

%>
<div>Files under directory <%= dir %> : <br /> <%= files %></div>
<%
         }
%>
</body>
</html>

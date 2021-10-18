<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "java.sql.*" %>
 
 <%!
public Connection getConnection(String path) throws SQLException {
String driver = "sun.jdbc.odbc.JdbcOdbcDriver";
String filePath=path+"\\datos.mdb";
String userName="",password="";
String fullConnectionString = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=" + filePath;

    Connection conn = null;
try{
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
 conn = DriverManager.getConnection(fullConnectionString,userName,password);

}
 catch (Exception e) {
System.out.println("Error: " + e);
 }
    return conn;
}
%>
<%
    response.setStatus(200);
    response.setContentType("text/html");
    response.setHeader("Content-disposition", "attachment; filename=libros.html");

    try{

        ServletContext context = request.getServletContext();
        String path = context.getRealPath("/data");
        Connection conexion = getConnection(path);
        if (!conexion.isClosed()){
 
        Statement st = conexion.createStatement();
        ResultSet rs = st.executeQuery("select * from libros" );

      // Se imprimen los resultados
      out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td>Titulo</td><td>Autor</td><td>Año</td><td>Editorial</td></tr>");
      int i=1;
      while (rs.next())
      {
         out.println("<tr>");
         out.println("<td>"+ i +"</td>");
         out.println("<td>"+rs.getString("isbn")+"</td>");
         out.println("<td>"+rs.getString("titulo")+"</td>");
         out.println("<td>"+rs.getString("autor")+"</td>");
         out.println("<td>"+rs.getString("anio")+"</td>");
         out.println("<td>"+rs.getString("editorial")+"</td>");
         out.println("</tr>");
         i++;
      }
      out.println("</table>");
     
      // cierre de la conexion
      conexion.close();
}

    }finally{
        out.close();
    }

%>

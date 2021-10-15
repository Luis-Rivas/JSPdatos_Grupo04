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
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-disposition", "attachment; filename=libros.xls");

    try{
        
        /*out.println("Hola\t");
        out.println("Soy Luis");*/

        ServletContext context = request.getServletContext();
        String path = context.getRealPath("/data");
        Connection conexion = getConnection(path);
        if (!conexion.isClosed()){
 
        Statement st = conexion.createStatement();
        ResultSet rs = st.executeQuery("select * from libros" );

      // Se imprimen los resultados
        out.println("N  \tISBN  \tNOMBRE");
        int i=1;
      while (rs.next()){
          
         out.println(i+"    \t"+rs.getString("isbn")+"  \t"+rs.getString("titulo"));

         i++;
      }
      // cierre de la conexion
      conexion.close();
}

    }finally{
        out.close();
    }

%>
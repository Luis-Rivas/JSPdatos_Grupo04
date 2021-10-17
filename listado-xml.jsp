<%@page import = "java.sql.*" %><%
    response.setStatus(200);
    response.setContentType("application/xml");
    response.setHeader("Content-disposition", "attachment;filename=libros.xml");
    try{
        ServletContext context = request.getServletContext();
        String path = context.getRealPath("/data");
        Connection conexion = getConnection(path);
        if (!conexion.isClosed()){
        Statement st = conexion.createStatement();
        ResultSet rs = st.executeQuery("select * from libros" );
        out.println("<?xml version="+"\"1.0\""+" encoding="+"\"UTF-8\""+"?>");
        int i=1;
        out.println("<libros>");
      while (rs.next()){
          out.println("<libro>");
          out.println("<numero>"+i+"</numero>");
          out.println("<isbn>"+rs.getString("isbn")+"</isbn>");
          out.println("<nombre>"+rs.getString("titulo")+"</nombre>");
          out.println("</libro>");
         i++;
      }
      out.println("</libros>");
      // cierre de la conexion
      conexion.close();
}

    }finally{
        out.close();
    }
%>
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
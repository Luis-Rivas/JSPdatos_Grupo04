<%@page import = "java.sql.*" %><%
    response.setStatus(200);
    response.setContentType("application/vnd.ms-excel");
    response.setHeader("Content-disposition", "attachment; filename=libros.xls");

    try{
        ServletContext context = request.getServletContext();
        String path = context.getRealPath("/data");
        Connection conexion = getConnection(path);
        if (!conexion.isClosed()){
 
        Statement st = conexion.createStatement();
        ResultSet rs = st.executeQuery("select * from libros" );
      // Se imprimen los resultados
        out.println("N  \tISBN  \tNOMBRE  \tAUTOR   \tAÑO   \tEDITORIAL");
        int i=1;
      while (rs.next()){  
        out.println(i+"\t"+rs.getString("isbn")+"\t"+rs.getString("titulo")+"\t"+rs.getString("autor")+"\t"+rs.getString("anio")+"\t"+rs.getString("editorial"));
        i++;
      }
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>
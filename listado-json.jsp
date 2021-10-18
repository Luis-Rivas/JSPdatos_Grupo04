<%@page import = "java.sql.*"%><%
    response.setStatus(200);
    response.setContentType("application/json");
    response.setHeader("Content-disposition", "attachment; filename=libros.json");

    try{
        
        ServletContext context = request.getServletContext();
        String path = context.getRealPath("/data");
        Connection conexion = getConnection(path);
        if (!conexion.isClosed()){
 
        Statement st = conexion.createStatement();
        ResultSet rs = st.executeQuery("select * from libros" );
        
        out.println("{\n\"libros\":{\n\"libro\":[");
        int i=1;
      while (rs.next()){
         if(i>1){
             out.println(",");
         }
         out.println("{");
         out.println("\"numero\":"+"\""+i+"\",");
         out.println("\"isbn\":"+"\""+rs.getString("isbn")+"\",");
         out.println("\"nombre\":"+"\""+rs.getString("titulo")+"\",");
         out.println("\"autor\":"+"\""+rs.getString("autor")+"\",");
         out.println("\"año\":"+"\""+rs.getString("anio")+"\",");
         out.println("\"editorial\":"+"\""+rs.getString("editorial")+"\"");
         out.print("}");
         i++;
      }
      out.println("]\n}\n}");
      // cierre de la conexion
      conexion.close();
}

    }finally{
        out.close();
    }

%>
<%!public Connection getConnection(String path) throws SQLException {
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
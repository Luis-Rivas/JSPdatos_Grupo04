<%@page contentType="text/html" pageEncoding="iso-8859-1" import="java.sql.*,net.ucanaccess.jdbc.*" %>
 <html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Actualizar, Eliminar, Crear registros.</title>
 </head>
 <body>

<H1>MANTENIMIENTO DE LIBROS</H1>
<form action="matto.jsp" method="post" name="Actualizar">
 <table>
 <tr>
 <td>ISBN<input type="text" name="isbn" value="" size="40"/></td>
 </tr>
 <tr>
 <td>Titulo<input type="text" name="titulo" value="" size="50"/></td>
 </tr>
 <tr>
   <td>Autor<input type="text" name="autor" value="" size="50"/></td>
</tr>
 <tr>
 <td>Anio<input type="text" name="anio" value="" size="30"/></td>
 </tr>
 <%
 ServletContext contexto = request.getServletContext();
 String patho = contexto.getRealPath("/data");
 Connection conexione = getConnection(patho);
    if (!conexione.isClosed()){
 out.write("OK");
       Statement st1 = conexione.createStatement();
       ResultSet edi = st1.executeQuery("select * from editorial" );
 
       out.println("<td> Editoriales");
       out.println("<select name=\"item\">");
          while (edi.next())
       {
          out.println("<option>"+edi.getString("nombre")+"</option>");  
       }
       out.println("</select>");
       out.println("</td>");
       // cierre de la conexion
       conexione.close();
 }
 %>

 <tr>
   <td> Action <input type="radio" name="Action" value="Actualizar" /> Actualizar
 <input type="radio" name="Action" value="Eliminar" /> Eliminar
 <input type="radio" name="Action" value="Crear" checked /> Crear
  </td>
 <td><input type="SUBMIT" value="ACEPTAR" />
</td>
 </tr>
 </form>

 </tr>
 </table>
 </form>
<br><br>
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
ServletContext context = request.getServletContext();
String path = context.getRealPath("/data");
Connection conexion = getConnection(path);
   if (!conexion.isClosed()){
out.write("OK");
 
      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery("select * from libros" );

      // Ponemos los resultados en un table de html
      out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td>Titulo</td><td>Autor</td><td>Accion</td><td>Anio</td><td>Editorial</td></tr>");
      int i=1;
      while (rs.next())
      {
         out.println("<tr>");
         out.println("<td>"+ i +"</td>");
         out.println("<td>"+rs.getString("isbn")+"</td>");
         out.println("<td>"+rs.getString("titulo")+"</td>");
         out.println("<td>"+rs.getString("autor")+"</td>");
         out.println("<td>"+"Actualizar<br>Eliminar"+"</td>");
         out.println("<td>"+rs.getString("anio")+"</td>");
         out.println("<td>"+rs.getString("editorial")+"</td>");         
         out.println("</tr>");
         i++;
      }
      out.println("</table>");

      // cierre de la conexion
      conexion.close();
}
%>
<br>
<a href="listado-csv.jsp" download="libros.csv">Descargar listado excel</a>
<a href="listado-txt.jsp" download="libros.txt">Descargar listado txt</a>
<a href="listado-xml.jsp" download="libros.xml">Descargar listado xml</a>
<a href="listado-html.jsp" download="libros.html">Descargar listado en formato html</a>
<a href="listado-json.jsp" download="libros.json">Descargar listado json</a>
 </body>
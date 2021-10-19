<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*,net.ucanaccess.jdbc.*" %>
 <html>
 <head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <title>Actualizar, Eliminar, Crear registros.</title>
 <link rel="stylesheet" type="text/css" href="estilo.css">
 </head>
 <body>

<H1>MANTENIMIENTO DE LIBROS</H1>
<form action="matto.jsp" class="formagre" id="formCrear" method="post" name="Actualizar">
 <table class="table__agregar">
 <tr>
 <%
 //Fragmento de codigo para obtener los parametros del url generado en la etiqueta actualizar de la tabla de libros
String ls_isbnActualizar = request.getParameter("isbnActualizar");
String ls_actionActualizar= request.getParameter("actionActualizar");
String autofocus="";
if(ls_isbnActualizar==null){
   ls_isbnActualizar="";
}else{
   autofocus="autofocus";
}

out.println("<td>ISBN:<input type=\"text\" name=\"isbn\" id=\"isbn\" value=\""+ls_isbnActualizar+"\" size=\"40\" onclick=\"cambioColor(isbn)\" /></td>");
out.println("<tr><td>Titulo<input type=\"text\" name=\"titulo\" id=\"titulo\" value=\"\" size=\"50\" "+autofocus+"/></td></tr>");

 //<td>Titulo<input type="text" name="titulo" value="" size="50"/></td>
 %>
 </tr>
 <tr>
   <td>Autor<input type="text" name="autor" id="autor" value="" size="50"/></td>
</tr>
 <tr>
 <td>Anio<input type="text" name="anio" id="anio" value="" size="30"/></td>
 </tr>
 <!--Agrega el listbox con las editoriales al formulario del crud de libros-->
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
   <td> Action<%
   //codigo que selecciona el radioButton actualizar si se carga la página desde el boton actualizar de la tabla de libros
   if(!(ls_actionActualizar==null)){
      out.println("<input type=\"radio\" name=\"Action\" value=\"Actualizar\" id=\"actualizar\" checked/> Actualizar");
      out.println("<input type=\"radio\" name=\"Action\" value=\"Crear\" id=\"crear\" /> Crear");
   }else{
      out.println("<input type=\"radio\" name=\"Action\" value=\"Actualizar\" id=\"actualizar\"/> Actualizar");
      out.println("<input type=\"radio\" name=\"Action\" value=\"Crear\" id=\"crear\" checked/> Crear");
   }
   out.println("<input type=\"radio\" name=\"Action\" value=\"Eliminar\"/> Eliminar");
   %>
  </td>
 <td><input type="SUBMIT" value="ACEPTAR" />
</td>
 </tr>
 </tr>
 </table>
 </form>
<br><br>

<script>

   function cambioColor(input){
      input.style.borderColor="";
   }
</script>

<script type="text/javascript">
   document.addEventListener("DOMContentLoaded", function() {
       document.getElementById("formCrear").addEventListener('submit', validarFormulario); 
     });
     
     function validarFormulario(evento) {
       evento.preventDefault();
       var isbn = document.getElementById('isbn');
       if(isbn.value.length == 0) {
         alert('No has escrito nada en el ISBN');
         isbn.style.borderColor="red";

         return;
       }
       var valoresAceptados = /^[0-9]+$/;
       if(isbn.value.match(valoresAceptados)==null) {
         alert('El ISBN debe ser un numero');
         isbn.style.borderColor="red";
         return;
       }
       var titulo = document.getElementById('titulo');
       if (titulo.value.length == 0) {
         alert('No has ingresado el titulo');
         titulo.style.borderColor="red";
         return;
       }
       var autor = document.getElementById('autor');
       if (autor.value.length == 0) {
         alert('No has ingresado el autor');
         autor.style.borderColor="red";
         return;
       }
       var anio = document.getElementById('anio');
       if (anio.value.match(valoresAceptados)==null) {
         alert('Ingresa correctamente el año');
         anio.style.borderColor="red";
         return;
       }

       this.submit();
     }
   </script>

<!--Agregando el formulario de busqueda-->
<form name="formbusca" class="formbus" action="libros.jsp" method="get">
<p>
   <label>BUSCAR LIBRO</label>
</p>
 
Titulo a buscar: <input type="text" name="titulo" placeholder="ingrese un titulo" id="txtBuscarTitulo" onInput="validarInput()"/> 
ISBN :<input type="text" name="isbn" placeholder="ingrese isbn" id="txtBuscarIsbn" onInput="validarInput()"/> 
Autor:<input type= "text" name="autor" id="txtBuscarAutor" placeholder="ingrese el autor" onInput="validarInput()"/>
<div>
<input type="SUBMIT" name="buscar" value="BUSCAR" id="btnBuscar" disabled/>
<input type="SUBMIT" name="todos" value="Ver Todos" id="mostrar todos" onclick="mostrarTodos()" /><!--Boton para mostrar todos los libros-->
</div>
</form>
<!--Script para validar que los campos de busqueda no estés todos vacíos-->
<script>     
   function validarInput() {
      console.log("change");
      const mensajeIsbn = document.getElementById("txtBuscarIsbn");
      const mensajeTitulo = document.getElementById("txtBuscarTitulo");
      const mensajeAutor = document.getElementById("txtBuscarAutor");
      const boton = document.getElementById("btnBuscar");
      console.log(boton)
          
      if ((mensajeTitulo.value.trim() !== "")||(mensajeIsbn.value.trim() !=="")||(mensajeAutor.value.trim()!=="")) {
         console.log("Se muestra")
         boton.removeAttribute('disabled')
      }else{
         boton.setAttribute('disabled', "true");
      }
   }
   function mostrarTodos(){
      const mensajeIsbn = document.getElementById("txtBuscarIsbn");
      const mensajeTitulo = document.getElementById("txtBuscarTitulo");
      const mensajeAutor = document.getElementById("txtBuscarAutor");
      mensajeAutor.value=null;
      mensajeIsbn.value=null;
      mensajeTitulo.value=null;
   } 
</script>
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
//obtener los datos del formulario de busqueda
String ls_isbn = request.getParameter("isbn");
String ls_titulo =request.getParameter("titulo");
String ls_autor = request.getParameter("autor");
String ls_consulta= request.getParameter("consulta");
//Conexión a la base
ServletContext context = request.getServletContext();
String path = context.getRealPath("/data");
Connection conexion = getConnection(path);
   if (!conexion.isClosed()){
out.write("OK");


String rs_isbn="";
String urlEliminar="";

if(!(ls_titulo==null) || !(ls_isbn==null) || !(ls_autor==null)){

   if((ls_isbn=="")||(ls_isbn==null)){
   ls_isbn="%";
   }
   String ls_ordenarBusqueda= request.getParameter("ordenarBusqueda");
   String ls_ordenadoBusqueda= request.getParameter("ordenadoBusqueda");
   String consultaOrdenar;
   String ordenadoB=ls_ordenadoBusqueda;
   //Creando la cadena string que se enviará para la consulta de busqueda
   String consulta = "select * from libros where isbn like'"+ls_isbn+"' and titulo like'%"+ls_titulo+"%' and autor like '%"+ls_autor+"%'";

   if(!(ls_consulta==null))
   {
      consulta=ls_consulta;
   }
            //condicional para ordenar ascendente/descendente
            if(!(ls_ordenarBusqueda==null)){
         if(ordenadoB.equals("desc1")){
            consulta+=" order by titulo desc";
            ordenadoB = "asc1";
         }else{
         consulta += " order by titulo asc";
         ordenadoB="desc1";
         }
      }else{
         consulta += ";";
      }

   Statement st = conexion.createStatement();
   ResultSet rs = st.executeQuery(consulta);

   // Ponemos los resultados en un table de html
   String urlTitulo1="<a href=./libros.jsp?titulo="+ls_titulo+"&isbn="+ls_isbn+"&autor="+ls_autor+"&buscar=BUSCAR&ordenarBusqueda="+ordenadoB+"&ordenadoBusqueda="+ordenadoB+">Titulo</a>";
   out.println("<table border=\"1\"><tr><td>Num.</td><td>ISBN</td><td>"+urlTitulo1+"</td><td>Autor</td><td>Anio</td><td>Editorial</td><td>Acción</td></tr>");
   //out.println("<table border=\"1\" class=\"table__a\"><tr><td>Num.</td><td>ISBN</td><td>Titulo</td><td>Autor</td><td>Año</td><td>Editorial</td><td>Acción</td></tr>");
   int i=1;
   while(rs.next()){
      rs_isbn = rs.getString("isbn");
      urlEliminar = "?isbn="+rs_isbn+"&Action=Eliminar";
      out.println("<tr class=\"tr_especial\">");
      out.println("<td class=\"td_especial\">"+ i +"</td>");
      out.println("<td class=\"td_especial\">"+rs_isbn+"</td>");
      out.println("<td class=\"td_especial\">"+rs.getString("titulo")+"</td>");
      out.println("<td class=\"td_especial\">"+rs.getString("autor")+"</td>");
      out.println("<td class=\"td_especial\">"+rs.getString("anio")+"</td>");
      out.println("<td class=\"td_especial\">"+rs.getString("editorial")+"</td>");
      out.println("<td class=\"td_especial\">"+"<a href=\"./libros.jsp?isbnActualizar="+rs_isbn+"&actionActualizar=y\">Actualizar</a><br><a href=\"./matto.jsp"+urlEliminar+"\">Eliminar</a>"+"</td>");
      out.println("</tr class=\"tr_especial\">>");
      i++;
   }
   out.println("</table>");
   // cierre de la conexion
   conexion.close();

}else{

      String ls_ordenar=request.getParameter("ordenar");
      String ls_ordenado=request.getParameter("ordenado");
      String ordenado=ls_ordenado;
      String consulta = "select * from libros";
      //Condicional para ordenar ascendente/descendente
      if(!(ls_ordenar==null)){
         if(ordenado.equals("desc")){
            consulta="select * from libros order by titulo desc";
            ordenado = "asc";
         }else{
         consulta = "select * from libros order by titulo";
         ordenado="desc";
         }
      }else{
         consulta = "select * from libros";
      }
      String urlTitulo="<a href=./libros.jsp?ordenar=si&ordenado="+ordenado+">Titulo"+ordenado+"</a>";
      Statement st = conexion.createStatement();
      ResultSet rs = st.executeQuery(consulta);

      // Ponemos los resultados en un table de html
      out.println("<table border=\"1\" class=\"table__a\"><tr><td>Num.</td><td>ISBN</td><td>"+urlTitulo+"</td><td>Autor</td><td>Año</td><td>Editorial</td><td>Acción</td></tr>");
      int i=1;
      while(rs.next()){

      rs_isbn = rs.getString("isbn");
      urlEliminar = "?isbn="+rs_isbn+"&Action=Eliminar";

         out.println("<tr class=\"tr_especial\">");
         out.println("<td class=\"td_especial\">"+ i +"</td>");
         out.println("<td class=\"td_especial\">"+rs_isbn+"</td>");
         out.println("<td class=\"td_especial\">"+rs.getString("titulo")+"</td>");
         out.println("<td class=\"td_especial\">"+rs.getString("autor")+"</td>");
         out.println("<td class=\"td_especial\">"+rs.getString("anio")+"</td>");
         out.println("<td class=\"td_especial\">"+rs.getString("editorial")+"</td>");
         out.println("<td class=\"td_especial\">"+"<a href=\"./libros.jsp?isbnActualizar="+rs_isbn+"&actionActualizar=y\">Actualizar</a><br><a href=\"./matto.jsp"+urlEliminar+"\">Eliminar</a>"+"</td>");
         out.println("</tr class=\"tr_especial\">>");
         i++;
      }
      out.println("</table>");

      // cierre de la conexion
      conexion.close();
   }
}
%>
<br>
<div class="links">
<a href="listado-csv.jsp" download="libros.csv">Descargar listado excel |</a>
<a href="listado-txt.jsp" download="libros.txt">Descargar listado txt |</a>
<a href="listado-xml.jsp" download="libros.xml">Descargar listado xml |</a>
<a href="listado-html.jsp" download="libros.html">Descargar listado en formato html |</a>
<a href="listado-json.jsp" download="libros.json">Descargar listado json |</a>
</div>
 </body>
<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: guillermorodriguez
  Date: 20/11/23
  Time: 14:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

    <%
        int idSocio = 0;
        boolean valido = true;

        try {

            // Validacion

            Objects.requireNonNull(request.getParameter("id"));

            if (request.getParameter("id").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");

            idSocio = Integer.parseInt(request.getParameter("id"));

        }catch (Exception e){

            e.printStackTrace();
            valido = false;
        }

        if(valido){

            Connection conn = null;
            Statement s = null;

            try {

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "user");

                String sql = "SELECT * FROM socio WHERE socioID=" + idSocio;

                s = conn.createStatement();

                ResultSet resultado = s.executeQuery(sql);

                String id = "";
                String nombre = "";
                String estatura = "";
                String edad = "";
                String localidad = "";

                while (resultado.next()){

                    id = resultado.getString("SocioID");
                    nombre = resultado.getString("nombre");
                    estatura = resultado.getString("estatura");
                    edad = resultado.getString("edad");
                    localidad = resultado.getString("localidad");

                }

                out.println("ID: " + id + "<br>" +
                            "Nombre: " + nombre + "<br>" +
                            "Estatura: " + estatura + "<br>" +
                            "Edad: " + edad + "<br>" +
                            "Localidad: " + localidad + "<br>");

            }catch (Exception e){

                e.printStackTrace();

            }finally {

                try {

                    conn.close();

                }catch (Exception e){}

                try {

                    s.close();

                }catch (Exception e){}

            }

        } else{

            out.println("Error de validacion");
        }
    %>

    <a href="index.jsp">Inicio</a>

</body>
</html>

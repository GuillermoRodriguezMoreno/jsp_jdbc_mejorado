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
    <h1>Detalles socio</h1>
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
            PreparedStatement ps = null;

            try {

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "user");

                String sql = "SELECT * FROM socio WHERE socioID=?";

                ps = conn.prepareStatement(sql);
                ps.setInt(1, idSocio);

                ResultSet resultado = ps.executeQuery(); // No hay que pasar como parametro el sql!!!!

                String id = "";
                String nombre = "";
                String estatura = "";
                String edad = "";
                String localidad = "";
                boolean encontrado = true;

                if (resultado.next()){

                    id = resultado.getString("SocioID"); // Deberia ser getInt si necesito usar el valor
                    nombre = resultado.getString("nombre");
                    estatura = resultado.getString("estatura");
                    edad = resultado.getString("edad");
                    localidad = resultado.getString("localidad");

                }else{

                    encontrado = false;
                }

                if (encontrado){
                    %>
                        <p>SocioID: <%= id %></p>
                        <p>Nombre: <%= nombre %></p>
                        <p>Estatura: <%= estatura %></p>
                        <p>Edad: <%= edad %></p>
                        <p>Localidad: <%= localidad %></p>
                    <%

                } else {

                    %>
                        <p>Socio no encontrado</p>
                    <%
                }

            }catch (Exception e){

                e.printStackTrace();

            }finally {

                try {

                    conn.close();

                }catch (Exception e){}

                try {

                    ps.close();

                }catch (Exception e){}

            }

        } else{

            out.println("Error de validacion");
        }
    %>

    <a href="index.jsp">Inicio</a>

</body>
</html>

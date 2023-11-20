<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %><%--
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
            PreparedStatement ps = null;

            try {

                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "user");

                String sql = "SELECT * FROM socio WHERE idSocio=" + idSocio;

                ResultSet resultado = ps.executeQuery(sql);



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

</body>
</html>

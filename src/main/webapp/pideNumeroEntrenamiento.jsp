<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: guillermorodriguez
  Date: 29/11/23
  Time: 8:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="estilos.css" />
</head>
<body>

    <%
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","root", "user");
        Statement s = conexion.createStatement();

        ResultSet listado = s.executeQuery ("SELECT * FROM entrenamiento");
        %>
        <table>
        <tr><th>Código</th><th>Tipo</th><th>Ubicacion</th><th>Fecha</th></tr>
    <%
        while (listado.next()) {
        out.println("<tr><td>");
        out.println(listado.getString("entrenamientoID") + "</td>");
        out.println("<td>" + listado.getString("tipo") + "</td>");
        out.println("<td>" + listado.getString("ubicacion") + "</td>");
        out.println("<td>" + listado.getString("fecha") + "</td>");
    %>
        <td>
        <form method="get" action="borraEntrenamiento.jsp">
        <input type="hidden" name="codigo" value="<%=listado.getString("entrenamientoID") %>"/>
        <input type="submit" value="borrar">
        </form>
        </td></tr>
    <%
        } // while
        conexion.close();
    %>
</body>
</html>

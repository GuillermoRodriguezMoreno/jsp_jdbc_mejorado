<%--
  Created by IntelliJ IDEA.
  User: guillermorodriguez
  Date: 27/11/23
  Time: 13:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%

    String error = (String) session.getAttribute("error");
    if(error != null){

%>
<span style="color: red; font-weight: bold"><%=error%></span>
<%
    }

    session.removeAttribute("error");
%>
<h2>Introduzca los datos del nuevo socio:</h2>
<form method="post" action="grabaEntrenamiento.jsp">
    Tipo <select name="tipo">
                 <option>fisico</option>
                 <option>tecnico</option>
         </select>
    <br>
    Ubicacion <input type="text" name="ubicacion"/></br>
    fecha <input type="date" name="fecha"/></br>
    <input type="submit" value="Aceptar">
</form>

</body>
</html>

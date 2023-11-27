<%@ page import="java.util.Date" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: guillermorodriguez
  Date: 27/11/23
  Time: 13:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    String tipo = null;
    String ubicacion = null;
    Date fecha = null; // simpleDateFormat
    String flag = "";
    String error = "";
    // Formateo fecha
    String pattern = "yyyy-MM-dd";
    SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);

    try {

        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        flag = "tipo";
        Objects.requireNonNull(request.getParameter("tipo"));
        //CONTRACT nonBlank..
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("tipo").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        // validacion enum
        // Traza
        tipo = request.getParameter("tipo");
        if(!request.getParameter("tipo").equals("fisico") && !request.getParameter("tipo").equals("tecnico")){

            throw new RuntimeException("Valor incorrecto, debe ser fisico o tecnico");
        }

        tipo = request.getParameter("tipo");

        flag = "ubicacion";
        Objects.requireNonNull(request.getParameter("ubicacion"));

        if (request.getParameter("ubicacion").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        ubicacion = request.getParameter("ubicacion");

        flag = "fecha";

        Objects.requireNonNull(request.getParameter("fecha"));

        if (request.getParameter("fecha").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");

        // parseo fecha
        String fechaSTR = request.getParameter("fecha"); // traza
        fecha = simpleDateFormat.parse(fechaSTR);


    } catch (NullPointerException ex) {

        error = "El campo " + flag + " no tiene valor";
        valida = false;

    }catch (NumberFormatException ex){

        error = "El campo " + flag + " no tiene el formato correcto";
        valida = false;

    }catch (RuntimeException ex){

        error = "El campo " + flag + ": " + ex.getMessage();
        valida = false;

    }catch (Exception ex){

        error =  "Error en el campo " + flag;
        valida = false;

    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "root", "user");


//>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
//       Statement s = conexion.createStatement();
//       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
//                          + ", '" + request.getParameter("nombre")
//                          + "', " + Integer.valueOf(request.getParameter("estatura"))
//                          + ", " + Integer.valueOf(request.getParameter("edad"))
//                          + ", '" + request.getParameter("localidad") + "')";
//       s.execute(insercion);
//<<<<<<

            String sql = "INSERT INTO entrenamiento VALUES ( " +
                    "?, " + //tipo
                    "?, " + //ubicacion
                    "?)"; //fecha

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setString(idx++, tipo);
            ps.setString(idx++, ubicacion);
            ps.setDate(idx, new java.sql.Date(fecha.getTime()));

            ps.executeUpdate();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }

    } else {
        out.println("Error de validación!");
        session.setAttribute("error", error);
        response.sendRedirect("formularioEntrenamiento.jsp");
    }
%>
</body>
</html>

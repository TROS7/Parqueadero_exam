<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Lista de Asignaturas</title>
</head>
<body>
<%
    // Variables de conexión a la base de datos
    String url = "jdbc:postgresql://localhost/Colegio";
    String user = "postgres";
    String password = "1234";
    String driver = "org.postgresql.Driver";

    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // Establecer conexión con la base de datos
        Class.forName(driver);
        conn = DriverManager.getConnection(url, user, password);

        // Consultar la base de datos para obtener la lista de asignaturas
        String sql = "SELECT * FROM asignaturas";
        stmt = conn.createStatement();
        rs = stmt.executeQuery(sql);

        // Mostrar la lista de asignaturas
        out.println("<h1>Lista de Asignaturas</h1>");
        out.println("<table border='1'>");
        out.println("<tr><th>Nombre</th><th>Descripción</th><th>Salón</th><th>Horario</th><th>Docente</th></tr>");
        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getString("nombre") + "</td>");
            out.println("<td>" + rs.getString("descripcion") + "</td>");
            out.println("<td>" + rs.getInt("salon") + "</td>");
            out.println("<td>" + rs.getString("horario") + "</td>");
            out.println("<td>" + rs.getString("docente") + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        // Cerrar recursos
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</body>
</html>
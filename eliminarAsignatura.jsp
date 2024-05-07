	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Eliminar Asignatura</title>
</head>
<body>
<%
    // Parámetro del ID de la asignatura a eliminar
    int idAsignatura = Integer.parseInt(request.getParameter("id"));

    // Variables de conexión a la base de datos
    String url = "jdbc:postgresql://localhost/Colegio";
    String user = "postgres";
    String password = "1234";
    String driver = "org.postgresql.Driver";

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        // Establecer conexión con la base de datos
        Class.forName(driver);
        conn = DriverManager.getConnection(url, user, password);

        // Eliminar la asignatura de la base de datos
        String sql = "DELETE FROM asignaturas WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, idAsignatura);
        int filasEliminadas = stmt.executeUpdate();

        if (filasEliminadas > 0) {
            out.println("<h1>Asignatura Eliminada Exitosamente</h1>");
        } else {
            out.println("<h1>Error al Eliminar la Asignatura</h1>");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        // Cerrar recursos
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</body>
</html>
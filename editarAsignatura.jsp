<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Asignatura</title>
</head>
<body>
<%
    // Parámetro del ID de la asignatura a editar
    int idAsignatura = Integer.parseInt(request.getParameter("id"));

    // Variables de conexión a la base de datos
    String url = "jdbc:postgresql://localhost/Colegio";
    String user = "postgres";
    String password = "1234";
    String driver = "org.postgresql.Driver";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Establecer conexión con la base de datos
        Class.forName(driver);
        conn = DriverManager.getConnection(url, user, password);

        // Consultar la base de datos para obtener los detalles de la asignatura
        String sql = "SELECT * FROM asignaturas WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, idAsignatura);
        rs = stmt.executeQuery();

        if (rs.next()) {
            // Mostrar el formulario para editar los detalles de la asignatura
%>
            <h1>Editar Asignatura</h1>
            <form action="procesarEditarAsignatura.jsp" method="post">
                <input type="hidden" name="id" value="<%= idAsignatura %>">
                <label for="nombre">Nombre de la Asignatura:</label>
                <input type="text" id="nombre" name="nombre" value="<%= rs.getString("nombre") %>" required><br>
                <label for="descripcion">Descripción:</label>
                <textarea id="descripcion" name="descripcion" rows="4" cols="50" required><%= rs.getString("descripcion") %></textarea><br>
                <label for="salon">Salón:</label>
                <input type="number" id="salon" name="salon" value="<%= rs.getInt("salon") %>" required><br>
                <label for="horario">Horario:</label>
                <input type="text" id="horario" name="horario" value="<%= rs.getString("horario") %>" required><br>
                <label for="docente">Docente Encargado:</label>
                <input type="text" id="docente" name="docente" value="<%= rs.getString("docente") %>" required><br>
                <input type="submit" value="Guardar Cambios">
            </form>
<%
        } else {
            out.println("<h1>Asignatura no encontrada</h1>");
        }
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
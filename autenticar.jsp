<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Autenticando...</title>
</head>
<body>
<%
    
    String usuario = request.getParameter("usuario");
    String contraseña = request.getParameter("contraseña");

    
    String url = "jdbc:postgresql://localhost/Colegio";
    String user = "postgres";
    String password = "1234";
    String driver = "org.postgresql.Driver";

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
       
        Class.forName(driver);
        conn = DriverManager.getConnection(url, user, password);

        
        String sql = "SELECT * FROM usuarios WHERE usuario = ? AND contraseña = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, usuario);
        stmt.setString(2, contraseña);
        rs = stmt.executeQuery();

        if (rs.next()) {
            
            int usuarioId = rs.getInt("id");
            String rol = obtenerRol(conn, usuarioId);

           
            if (rol.equals("rector")) {
                response.sendRedirect("administracion.jsp");
            } else if (rol.equals("alumno")) {
                response.sendRedirect("materias.jsp");
            } else {
                
                response.sendRedirect("error.jsp");
            }
        } else {
            
            response.sendRedirect("login.jsp?error=1");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    
    String obtenerRol(Connection conn, int usuarioId) throws SQLException {
        String rol = "";
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT rol FROM permisos WHERE usuario_id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, usuarioId);
        rs = stmt.executeQuery();
        if (rs.next()) {
            rol = rs.getString("rol");
        }
        return rol;
    }
%>
</body>
</html>
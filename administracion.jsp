<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Administración de Asignaturas</title>
</head>
<body>
    <h1>Administración de Asignaturas</h1>

    <!-- Formulario para agregar una nueva asignatura -->
    <h2>Agregar Nueva Asignatura</h2>
    <form action="procesarAsignatura.jsp" method="post">
        <label for="nombre">Nombre de la Asignatura:</label>
        <input type="text" id="nombre" name="nombre" required><br>
        <label for="descripcion">Descripción:</label>
        <textarea id="descripcion" name="descripcion" rows="4" cols="50" required></textarea><br>
        <label for="salon">Salón:</label>
        <input type="number" id="salon" name="salon" required><br>
        <label for="horario">Horario:</label>
        <input type="text" id="horario" name="horario" required><br>
        <label for="docente">Docente Encargado:</label>
        <input type="text" id="docente" name="docente" required><br>
        <input type="submit" value="Agregar Asignatura">
    </form>

    <!-- Lista de asignaturas existentes -->
    <h2>Lista de Asignaturas</h2>
    <table border="1">
        <tr>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Salón</th>
            <th>Horario</th>
            <th>Docente</th>
            <th>Acciones</th>
        </tr>
        <!-- Aquí puedes iterar sobre la lista de asignaturas desde la base de datos -->
        <%-- Por ejemplo:
        <%
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getString("nombre") + "</td>");
                out.println("<td>" + rs.getString("descripcion") + "</td>");
                out.println("<td>" + rs.getInt("salon") + "</td>");
                out.println("<td>" + rs.getString("horario") + "</td>");
                out.println("<td>" + rs.getString("docente") + "</td>");
                out.println("<td>");
                out.println("<a href='editarAsignatura.jsp?id=" + rs.getInt("id") + "'>Editar</a> ");
                out.println("<a href='eliminarAsignatura.jsp?id=" + rs.getInt("id") + "'>Eliminar</a>");
                out.println("</td>");
                out.println("</tr>");
            }
        %>
        --%>
    </table>
</body>
</html>
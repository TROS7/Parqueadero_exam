<?php

// Configuración
require_once 'config.php';

// Inicio de sesión
session_start();

// Comprobamos si el usuario está logueado
if (!isset($_SESSION['usuario'])) {
    header('Location: login.php');
    exit;
}

// Obtenemos el rol del usuario
$rol = $_SESSION['rol'];

// Creamos el encabezado de la página
echo '<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de entradas y salidas de parqueadero</title>
</head>
<body>';

// Si el usuario es administrador, mostramos el menú de opciones
if ($rol == 'admin') {
    echo '<nav>
        <a href="entradas.php">Entradas</a>
        <a href="salidas.php">Salidas</a>
        <a href="usuarios.php">Usuarios</a>
        <a href="logout.php">Cerrar sesión</a>
    </nav>';
}

// Mostramos el contenido de la página
if ($rol == 'admin') {
    // Mostramos el formulario para registrar una entrada
    echo '<h2>Registrar entrada</h2>
    <form action="entradas.php" method="post">
        <input type="text" name="placa" placeholder="Placa del vehículo">
        <input type="number" name="hora_entrada" placeholder="Hora de entrada">
        <input type="number" name="hora_salida" placeholder="Hora de salida">
        <input type="text" name="ubicacion" placeholder="Ubicación">
        <select name="tipo_vehiculo">
            <option value="carro">Carro</option>
            <option value="motocicleta">Motocicleta</option>
            <option value="cicla">Cicla</option>
        </select>
        <button type="submit">Registrar</button>
    </form>';
} else {
    // Mostramos un listado de las entradas
    echo '<h2>Entradas</h2>
    <table>
        <tr>
            <th>Placa</th>
            <th>Hora de entrada</th>
            <th>Hora de salida</th>
            <th>Ubicación</th>
            <th>Tipo de vehículo</th>
        </tr>';

    // Obtenemos las entradas de la base de datos
    $sql = "SELECT * FROM entradas";
    $resultado = mysqli_query($conexion, $sql);

    // Recorremos los resultados
    while ($entrada = mysqli_fetch_assoc($resultado)) {
        echo '<tr>
            <td>' . $entrada['placa'] . '</td>
            <td>' . $entrada['hora_entrada'] . '</td>
            <td>' . $entrada['hora_salida'] . '</td>
            <td>' . $entrada['ubicacion'] . '</td>
            <td>' . $entrada['tipo_vehiculo'] . '</td>
        </tr>';
    }

    echo '</table>';
    
}
// Fin de la página
echo '</body>
</html>';

// Cerramos la conexión a la base de datos
mysqli_close($conexion);

?>
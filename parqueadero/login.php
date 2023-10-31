<?php


// Configuración de la base de datos
$db_host = "localhost";
$db_name = "parqueadero";
$db_user = "admin";
$db_password = "contraseña";

// Configuración del usuario
$user_name = "admin";
$user_email = "admin@example.com";
$user_password = "contraseña";

// Configuración de la aplicación
$app_name = "Parqueadero";
$app_version = "1.0";


// Configuración
require_once 'config.php';

// Conectar a la base de datos
$conexion = new PDO("pgsql:host=localhost;dbname=DATA_PARQUEADERO", "admin", "contraseña");

// Crear la tabla de entradas
$sql = "CREATE TABLE entradas (
    id serial PRIMARY KEY,
    placa varchar(6) NOT NULL,
    hora_entrada timestamp NOT NULL,
    hora_salida timestamp,
    ubicacion varchar(255) NOT NULL,
    tipo_vehiculo varchar(255) NOT NULL
);";

$conexion->query($sql);

// Crear la tabla de usuarios
$sql = "CREATE TABLE usuarios (
    id serial PRIMARY KEY,
    nombre varchar(255) NOT NULL,
    apellidos varchar(255) NOT NULL,
    correo varchar(255) NOT NULL,
    contrasena varchar(255) NOT NULL,
    rol varchar(255) NOT NULL
);";

$conexion->query($sql);

// Cerrar la conexión a la base de datos
$conexion = null;

$db_host = $_ENV["db_host"];
$db_name = $_ENV["db_name"];
$db_user = $_ENV["db_user"];
$db_password = $_ENV["db_password"];


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
?>

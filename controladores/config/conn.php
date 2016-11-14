<?php
# Conexion db 
try {
    $conn = new PDO('mysql:host=' . $container->get('host') . ';dbname=' . $container->get('dbname') . ';charset=utf8', $container->get('user'), $container->get('pass'));
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
    echo $e->getMessage();
}
?>
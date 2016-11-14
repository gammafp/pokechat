<?php
use \Firebase\JWT\JWT;
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;


require './vendor/autoload.php';
require './config/config.php';

$app = new \Slim\App($config);
$container = $app->getContainer();

$app->add(function($req, $res, $next) {
	$response = $next($req, $res);
	return $response
		
		->withHeader('Access-Control-Allow-Origin', '*')

		->withHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Accept, Origin, Authorization')

		->withHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');

});


require './config/conn.php';

# Sección del chat 

## guardar mensajes nuevos
$app->post('/savechat', function (Request $request, Response $response) use ($conn) {    
    if(isset($request->getParsedBody()["nombre"], $request->getParsedBody()["mensaje"])) {
        $nombre = strip_tags($request->getParsedBody()["nombre"]);
        $mensaje = strip_tags($request->getParsedBody()["mensaje"]);
        $peticion = $conn->prepare("insert into MENSAJES (id_u, mensaje, fecha_creacion, fecha_creacion_unix) values ((select id from USUARIOS where user_name = :nombre), :mensaje, now(), UNIX_TIMESTAMP(now()))");
        $peticion->execute(array(
            ":nombre" => $nombre,
            ":mensaje" => $mensaje
        ));
    } else {
        echo "Error no pueden haber variables no vacias";
    }

});

## Obtener todos los mensajes y enviarlos por JSON

$app->get('/todoschat', function() use($conn) {
    # Esto es una vista
    $peticion = $conn->query("select * FROM todochat order by id_m desc limit 2");
    $salida = array();

    while($row = $peticion->fetch(PDO::FETCH_ASSOC)) {
        array_push($salida, array(
            "id_u" => $row['id_u'],
            "user_name" => $row['user_name'],
            "id_m" => $row['id_m'],
            "mensaje" => $row['mensaje'],
            "fecha_creacion" => $row['fecha_creacion'],
            "fecha_creacion_unix" => $row['fecha_creacion_unix']
        ));             
    }
    echo JSON_ENCODE($salida);
    
    // var_dump($cabecera);
});

## Obtiene solo el ultimo mensaje por medio de server sent events
// $app->get('/getultimochat', function($request, $response, $arguments) use ($conn) {
//     $previusID = 0;

//     while(true) {
//         $quer = $conn->prepare("select * from todochat where id_u > :ide");
//         $quer->execute(array(
//             ":ide" => $previusID
//         ));

//         while($row = $quer->fetch(PDO::FETCH_ASSOC)) {
//             $usa = array(
//                 "id_u" => $row['id_u'],
//                 "user_name" => $row['user_name'],
//                 "id_m" => $row['id_m'],
//                 "mensaje" => $row['mensaje'],
//                 "fecha_creacion" => $row['fecha_creacion'],
//                 "fecha_creacion_unix" => $row['fecha_creacion_unix']
//             );       
//              $previusID = $row['id'];
             
//         }
//          return $response
//             ->withHeader("Content-Type", "text/event-stream")
//             ->withHeader("Cache-Control", "no-cache")
//             ->write("data: ".JSON_ENCODE($usa)." \n\n");
        
//         ob_flush();
// 	    flush();
//         sleep(5);
//     }
// });

# Fin de la sección del chat

// Save data y load data
$app->post('/savedata', function (Request $request, Response $response) use ($conn) {
    $nombre = $request->getParsedBody()["nombre"];
    $savename = $request->getParsedBody()["save_name"];
    $savedata = $request->getParsedBody()["save_data"];

    $query = $conn->prepare("update USUARIOS set save_name = :savename, save_data = :savedata  where user_name = :username");
    $query->execute(array(
        ":username" => $nombre,
        ":savedata" => $savedata,
        ":savename" => $savename
    ));
    echo "correcto";
});

$app->get('/getsavedata', function (Request $request, Response $response) use ($conn) {
    $query = $conn->prepare("select save_name, save_data from USUARIOS where user_name = :nombre");
    $query->execute(array(
        ":nombre" => "gammafp"
    ));
    $salida = $query->fetch();
    $devolver = [
        "save_name" => $salida["save_name"], 
        "save_data" => $salida["save_data"]
    ];
    echo JSON_ENCODE($devolver);
    // echo var_dump($request->getParsedBody());
});


################## Sección de login y registro
// Login
$app->post("/login", function (Request $request, Response $response) use ($conn) { 
    $nombre = $request->getParsedBody()['user'];
    $pass = $request->getParsedBody()['password'];

    if(comprobarUserLogin($conn, $nombre, $pass)) {
        # Obtener el savedata

        $query = $conn->prepare("select save_name, save_data from USUARIOS where user_name = :nombre");
        $query->execute(array(
            ":nombre" => $nombre
        ));
        $salida = $query->fetch();
        $devolver = [
            "save_name" => $salida["save_name"], 
            "save_data" => $salida["save_data"]
        ];
  

        ## Salida con el token
        $token = generarToken($nombre);
        $salida = array(
            "error" => true,
            "msg" => 10,
            "debug" => "El usuario existe",
            "token" =>  $token,
            "save_name" => $devolver["save_name"],
            "save_data" => $devolver["save_data"]
            
        );
        echo JSON_ENCODE($salida);
    } else {
        if( existeUsuario($conn, "user_name", $nombre) ) {
            $salida = array(
                "error" => false,
                "msg" => 11,
                "debug" => "La contraseña o el nombre de usuario no cohinciden"
            );
            echo JSON_ENCODE($salida);
        } else {
             $salida = array(
                "error" => false,
                "msg" => 12,
                "debug" => "El usuario no existe y deberias registrarte"
            );
            echo JSON_ENCODE($salida);
            ###############################  HEMOS QUEDADO AQUÍ
        }
    }

});


// Registrar
$app->post('/registrar', function (Request $request, Response $response) use ($conn) {
    $nombre = $request->getParsedBody()['user'];
    $pass = $request->getParsedBody()['password'];

    if(existeUsuario($conn, "user_name", $nombre)) {
        $salida = array(
            "error" => false,
            "msg" => 1,
            "debug" => "el usuario ya existe."
        );
        echo JSON_ENCODE($salida);
    } else {

        if(!preg_match("/^\w+$/", $nombre)) {
            $salida = array(
                "error" => false,
                "msg" => 2,
                "debug" => "Caracteres raros insertados"
            );
            echo JSON_ENCODE($salida);
        } else {
            # Registrar
            $stmt = $conn->prepare("insert into USUARIOS (user_name, password, save_name, save_data) values (:nombre, :password, :saveName, :saveData)");
            $stmt->execute(array(
                ":nombre" => $nombre,
                ":password" => $pass,
                ":saveName" => "noob",
                ":saveData" => "noob"
            ));
            $token = generarToken($nombre);
            $salida = array(
                "error" => true,
                "msg" => 3,
                "debug" => "se ha registrado el usuario",
                "token" => $token
            );
            echo JSON_ENCODE($salida);
            # Crear el token y devolverlo para que pueda redireccionar la carallada esta
        }

    }

});





$app->post('/comprobaruser', function (Request $request, Response $response) use ($conn) { 
    if(existeUsuario($conn, "user_name", $request->getParsedBody()["nombre"])) {
        echo "1";
    } else {
        echo "0";
    }
});


## Funciones varias, esto hay que separarlo #############

// Comprobarsi el usuario existe
function existeUsuario($conn, $buscar, $user) {
    $salida = true;
    $stmt = $conn->query("select ".$buscar." from USUARIOS where ".$buscar." = '$user'");
    $stmt->setFetchMode(PDO::FETCH_ASSOC);
    if($stmt->rowCount() >= 1) {
        $salida = true;
    } else {
        $salida = false;
    }
    $stmt = null;
    return $salida;
}

function comprobarUserLogin($conn, $user, $pass) {
    $salida = true;
    $stmt = $conn->query("select user_name, password from USUARIOS where user_name = '$user' and password = '$pass'");
    $stmt->setFetchMode(PDO::FETCH_ASSOC);
    if($stmt->rowCount() >= 1) {
        $salida = true;
    } else {
        $salida = false;
    }
    $stmt = null;
    return $salida;
}

# generador de token y decodificador
function generarToken($nom) {
        $token = array(
            "nombre" => $nom,
            "iat"    => time(),
            "exp"    => time() + 5000
        );
        $jwt = JWT::encode($token, "cojones");
    return $jwt;
}

function decodificarToken($token) {
    $jwt = explode(" ", $token);
    $jwt = trim($jwt[1], '"');
    $jwt2 = JWT::decode($jwt, "cojones", array('HS256'));

    return $jwt2;
}

$app->run();


?>
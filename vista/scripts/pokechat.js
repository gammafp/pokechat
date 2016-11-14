(function() {
    var app = angular.module("miApp", ["ngMaterial", "ngRoute", "angular-jwt", "angular-storage"]);
    var baseUrl = "http://localhost";
    /* Apartado de configuracion */
    app.config(["$routeProvider", "$httpProvider", "jwtInterceptorProvider", "jwtOptionsProvider", function ($routeProvider, $httpProvider, jwtInterceptorProvider, jwtOptionsProvider) {
        // Hay que quitar la lista blanca ;-)
        jwtOptionsProvider.config({ whiteListedDomains: baseUrl });

        $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest';

        jwtInterceptorProvider.tokenGetter = function () {
            return localStorage.getItem('token');
        };

        $httpProvider.interceptors.push('jwtInterceptor');
    }]);

    app.run(["jwtHelper", "store", function (jwtHelper, store) {

        var token = store.get('token') || null;
        var bool = (token) ? jwtHelper.isTokenExpired(token) : false;

        if (token) {
            if (bool) {
                store.remove("token");
                window.location = baseUrl;
            } else {
                // console.log(jwtHelper.isTokenExpired(store.get("token")));
                var deco = jwtHelper.decodeToken(token);
                localStorage.setItem("nombre", deco.nombre);
            }
        }
    }]);


    /* Fin del apartado de configuracion*/




    app.controller("pokechat", pokechat);

    pokechat.$inject = ["$scope", "$http"];
    function pokechat($scope, $http) {
        $scope.soyYo = localStorage.getItem("nombre");
            $scope.chat = {
                mensaje: ""
            };

            $scope.todosChat = [ ];


            var datos = {
                "nombre": $scope.soyYo
            };

            $scope.listarMensajes = function() {
                $http({
                    method: 'get',
                    skipAuthorizacion: false,
                    url: baseUrl + "/controladores/todoschat"
                }).then(function (res) {
                    console.log(res.data);
                    $scope.todosChat = res.data;
                });
            }
            $scope.init = function() {
                $scope.listarMensajes();
                $scope.pidMessages = window.setInterval($scope.listarMensajes, 3000);
            }
            $scope.init();

            // function nuevosMensajes() {
            //     console.log("/* Nueva funcion de auto carga cargada */");
            //     var source = new EventSource("./controladores/getultimochat");
            //     source.onmessage = function(event) {
            //         var salida = JSON.parse(event.data);
            //         if(salida.id_m == $scope.todosChat[0].id_m) {
            //             console.log("uy son iguales");
            //         } else {
            //             console.log("entra en unsift " + salida.id_m);
            //             $scope.$apply(
            //                 function() {
            //                     $scope.todosChat.unshift(salida)
            //                 });
            //         }

            //     };
            // }
            // Esto agrega nuevos mensajes al chat
            $scope.nuevoMensaje = function (mensaje) {
                if (mensaje.mensaje == "") {
                    alert("Estas dejando un campo vacio a posta pillin.");
                } else {
                    datos.mensaje = mensaje.mensaje;
                    mensaje.mensaje = '';
                    $http({
                        method: 'post',
                        skipAuthorizacion: false,
                        url: baseUrl + "/controladores/savechat",
                        data: datos,
                        headers: { 'Content-Type': 'application/json' }
                    }).then(function (res) {
                        console.log(res.data);
                    });
                }

            }



    }
})();

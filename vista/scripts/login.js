(function() {
    var app = angular.module("miApp", ["ngMaterial", "ngMessages", "angular-jwt", "angular-storage", "ngRoute"]);
    var baseUrl = "http://localhost/";

    // Sección de configuraciones
    app.config(["$routeProvider", "$httpProvider", "jwtInterceptorProvider", "jwtOptionsProvider", function($routeProvider, $httpProvider, jwtInterceptorProvider, jwtOptionsProvider) {
        jwtOptionsProvider.config({
            whiteListedDomains: 'http://localhost'
        });
        $httpProvider.defaults.headers.common["X-Requested-With"] = 'XMLHttpRequest';
        jwtInterceptorProvider.tokenGetter = function() {
            return localStorage.getItem('token');
        };
        $httpProvider.interceptors.push('jwtInterceptor');
    }]);

    app.run(["$rootScope", "jwtHelper", "store", function($rootScope, jwtHelper, store) {

        var token = store.get('token') || null;
        var bool = (token) ? jwtHelper.isTokenExpired(token) : token;

        if (token) {
            if (bool) {
                store.remove("token");
            } else {
                window.location = baseUrl + "pokechat.html";
            }
        }
    }]);

    // esto comprobará si está todo correcto en el front-end
    app.factory("comprobarAuth", function() {
        return {
            comprobar: function(dato) {
                var patron = /^\w+$/;
                if (!patron.test(dato)) {
                    return false;

                } else {
                    return true;
                }
            }
        }
    });
    // Fin de la sección de configuraciones

    app.controller("login", login);

    login.$inject = ["$scope", "$http", "comprobarAuth", "store"];

    function login($scope, $http, comprobarAuth, store) {
        // Logica del login
        // Alerta login
        $scope.loginC = {
            mostrar: false,
            mensaje: "Todo correcto a jugar ;)"
        }

        $scope.alertaL = {
            mostrar: false,
            mensaje: "cojon"
        };

        // Alertas registro
        $scope.alertaR = {
            mostrar: false,
            mensaje: "Otro entrenador tiene ese nombre de usuario."
        };
        $scope.correctoR = {
            mostrar: false,
            mensaje: " Puedes usar ese nombre de usuario."
        }

        // Esto comprueba si el nombre existe

        // var nombrePillado = true;
        // $scope.comprobarNombre = function(nombre) {
        //
        //     // hacer ajax
        //     $http({
        //         method: 'POST',
        //         url: baseUrl+"controladores/comprobaruser",
        //         data: {nombre: nombre},
        //         headers: { 'Content-Type': 'application/json' }
        //     }).then(function(res) {
        //
        //         if(!!res.data) {
        //             // El usuario existe
        //             nombrePillado = false;
        //             $scope.correctoR.mostrar = false;
        //             $scope.alertaR.mostrar = true;
        //             $scope.alertaR.mensaje = "Otro entrenador tiene ese nombre de usuario.";
        //
        //         } else {
        //             // Todo correcto y el nombre no existe
        //             nombrePillado = true;
        //             $scope.alertaR.mostrar = false;
        //             $scope.correctoR.mostrar = true;
        //             $scope.correctoR.mensaje = " Puedes usar ese nombre de usuario."
        //         }
        //     });
        // }
        //
        //
        $scope.LoginFn = function(datos) {
            console.log(datos);
            var userCorrecto = false;
            var passwordCorrecto = false;


            if (comprobarAuth.comprobar(datos.user)) {
                userCorrecto = true;
            } else {
                userCorrecto = false;
                $scope.alertaL.mensaje = " No se admiten caracteres especiales ni espacios en el usuario.";
                $scope.alertaL.mostrar = "true";
            }

            if (comprobarAuth.comprobar(datos.password)) {
                passwordCorrecto = true;
            } else {
                userCorrecto = false;
                $scope.alertaL.mensaje = " No se admiten caracteres especiales ni espacios en la contraseña.";
                $scope.alertaL.mostrar = "true";
            }

            // si está todo correcto marcar true y enviar
            if (userCorrecto && passwordCorrecto) {

                // enviar
                $http({
                    method: 'POST',
                    skipAuthorizacion: true,
                    url: baseUrl + "controladores/login",
                    data: datos,
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(function(res) {
                    console.log(res.data);

                    if (res.data.error && res.data.msg == 10) {
                        store.set('token', res.data.token);
                        if (res.data.save_name != "noob") {

                            localStorage.setItem(res.data.save_name, res.data.save_data);

                        }


                        $scope.loginC.mensaje = "Todo correcto a jugar;)."
                        setTimeout(function() {
                            window.location.href = baseUrl + "pokechat.html";
                        }, 1000);
                    } else if (!res.data.error && res.data.msg == 11) {
                        $scope.alertaL.mostrar = true;
                        $scope.alertaL.mensaje = " La contraseña o el nombre de usuario no cohinciden.";
                    } else if (!res.data.error && res.data.msg == 12) {
                        $scope.alertaL.mostrar = true;
                        $scope.alertaL.mensaje = " El usuario no existe ¡Registrate para la aventura!.";
                    }

                });

            }


        }

        // El registro

        $scope.RegisterFn = function(datos) {
            var userCorrecto = false;
            var passwordCorrecto = false;

            if (comprobarAuth.comprobar(datos.user)) {
                userCorrecto = true;
            } else {
                userCorrecto = false;
                $scope.alertaR.mensaje = " No se admiten caracteres especiales ni espacios en el usuario.";
                $scope.alertaR.mostrar = "true";
            }

            if (comprobarAuth.comprobar(datos.password)) {
                passwordCorrecto = true;
            } else {
                userCorrecto = false;
                $scope.alertaR.mensaje = " No se admiten caracteres especiales ni espacios en la contraseña.";
                $scope.alertaR.mostrar = "true";

            }

            // si está todo correcto marcar true y enviar
            if (userCorrecto && passwordCorrecto) {
                // enviar
                // hacer ajax
                $http({
                    method: 'POST',
                    url: baseUrl + "controladores/registrar",
                    data: datos,
                    headers: {
                        'Content-Type': 'application/json'
                    }
                }).then(function(res) {
                    if (!res.data.error) {
                        // El usuario existe
                        $scope.correctoR.mostrar = false;
                        $scope.alertaR.mostrar = true;
                        $scope.alertaR.mensaje = " Otro entrenador tiene ese nombre de usuario.";

                    } else if (res.data.msg == 3 && res.data.error) {
                        // Todo correcto y el nombre no existe
                        $scope.alertaR.mostrar = false;
                        $scope.correctoR.mostrar = true;
                        $scope.correctoR.mensaje = " Ahora puedes empezar la aventura. ¡Serás redireccionado!";

                        store.set('token', res.data.token);

                        setTimeout(function() {
                            window.location.href = baseUrl + "pokechat.html";
                        }, 2000);
                    }

                });

            }
        }

        // Efecto del switch del boton login
        var suitch = true;
        $scope.tipoRegistro = "Registrate ;)";
        $scope.botonRegistro = function() {
            if (suitch) {
                suitch = false;
                $scope.mostrarLogin = {
                    'opacity': '.3'
                };
                // Para el boton desactivado
                $scope.desactivarBoton = "true";
                $scope.mostrarRegistro = {
                    'margin-top': '0px'
                };
                $scope.tipoRegistro = "Login";
            } else {
                suitch = true;
                $scope.mostrarLogin = {
                    'opacity': '1'
                };
                // para el boton activado
                $scope.desactivarBoton = "false";
                $scope.mostrarRegistro = {
                    'margin-top': '-200px'
                };
                $scope.tipoRegistro = "Registrate ;)";
            }

        }

    }
})();

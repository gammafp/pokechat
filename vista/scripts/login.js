(function() {
    var app = angular.module("miApp", ["ngMaterial"]);
    app.controller("login", login);

    login.$inject = ["$scope"];
    function login($scope) {
        var suitch = true;
        $scope.tipoRegistro = "Registrate ;)";
        $scope.botonRegistro = function() {
            if(suitch) {
                suitch = false;
                $scope.mostrarRegistro={'margin-top': '0px'};
                $scope.tipoRegistro = "Login";
            } else {
                suitch = true;
                $scope.mostrarRegistro={'margin-top': '-200px'};
                $scope.tipoRegistro = "Registrate ;)";
            }

        }

    }
})();

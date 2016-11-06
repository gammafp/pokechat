(function() {
    var app = angular.module("miApp", ["ngMaterial"]);
    app.controller("pokechat", pokechat);

    pokechat.$inject = ["$scope"];
    function pokechat($scope) {
        $scope.prueba = "Hola k ase";
    }
})();

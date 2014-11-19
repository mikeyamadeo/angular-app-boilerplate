(function() {
    'use strict';

    angular
        .module('app')
        .controller('appCtrl', ctrl);

    //don't forget to inject
    ctrl.$inject = [ ];

    function ctrl( ) {
        var vm = this;
        vm.message = "Be responsible for the existence of something awesome."

        ///////////////////////////////////////////////
        // Implementation should stay below the "fold"
    }



})();
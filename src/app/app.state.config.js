(function() {
    'use strict';

    angular
        .module('app')
        .config(routing);

    //don't forget to inject
    routing.$inject = ['$stateProvider', '$urlRouterProvider'];

    function routing($stateProvider, $urlRouterProvider) {

        $urlRouterProvider.otherwise('/quotes');

        $stateProvider

            .state('quotes', {
                url: '/quotes',
                templateUrl: 'app/quotes/quotes.html'
            });

        ///////////////////////////////////////////////
        // Implementation should stay below the "fold"
    }

})();
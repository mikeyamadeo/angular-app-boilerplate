(function() {
    'use strict';

    angular
        .module('app')
        .config(routing);

    routing.$inject = ['$stateProvider', '$urlRouterProvider'];

    function routing($stateProvider, $urlRouterProvider) {

        $stateProvider

            .state('profile', {

                url: '/',

                templateUrl: 'app/profile/profile.html',

                controller: 'baseCtrl'

            });

        $urlRouterProvider.otherwise('/');

    }

})();
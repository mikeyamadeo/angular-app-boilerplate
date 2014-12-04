describe('appCtrl', function() {
    var ctrl;

    beforeEach(module('app'));
    beforeEach(inject(function($controller) {
        ctrl = $controller('appCtrl', {});
    }));

    it('should instantiate properties', function() {
        expect(ctrl.message).not.toBeUndefined();
    });
});
(function () {
    var FUNCTION, Dummy;
    FUNCTION = CHITCHAT.builtins.Function = function (foo) {
        return function () {
            return foo;
        };
    };

    FUNCTION.prototype.implement = function (obj) {
        for (var k in obj) if (Object.prototype.hasOwnProperty.call(obj, k)) {
            this.prototype[ k ] = obj[ k ];
        } 
    };

    /*
    FUNCTION.prototype.doTimes = function () {};

    FUNCTION.prototype.bind = function () {};

    FUNCTION.prototype.curry = function () {};

    FUNCTION.prototype.curryRight = function () {};

    FUNCTION.prototype.compose = function () {};
    */

    FUNCTION.prototype['new'] = function () {
        var instance, result;

        Dummy.prototype = this.prototype; 
        instance = new Dummy();
        result = this.apply(instance, arguments);

        return result != null ? result : instance;
    };
}.call(this));
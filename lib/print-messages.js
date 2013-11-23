// Generated by CoffeeScript 1.6.3
(function() {
  var method, n, printMessages, _ref;

  require('colors');

  printMessages = {};

  printMessages.color = function(color) {
    return function() {
      var arg, n, _i, _len, _results;
      console.log('');
      _results = [];
      for (n = _i = 0, _len = arguments.length; _i < _len; n = ++_i) {
        arg = arguments[n];
        if ('string' === typeof arg) {
          _results.push(console.log(arg[!n ? color : 'white']));
        } else {
          _results.push(console.log(arg));
        }
      }
      return _results;
    };
  };

  _ref = {
    log: printMessages.color('cyan'),
    success: printMessages.color('green'),
    warn: printMessages.color('yellow'),
    error: printMessages.color('red'),
    node: function(msg, err, result) {
      if (err) {
        return this.warn(msg, err);
      } else {
        return this.success(msg, result);
      }
    },
    promise: function(msg, promise) {
      var _this = this;
      return promise.then(function(result) {
        return _this.success(msg, result);
      }, function(err) {
        return _this.error(msg, err);
      });
    }
  };
  for (n in _ref) {
    method = _ref[n];
    printMessages[n] = method;
  }

  module.exports = printMessages;

}).call(this);
var
  printMessages,
  _colorfulMessage,
  __slice = Array.prototype.slice
  _ = require('underscore');

require('colors');

// Options
printMessages = {

  // Print new line each log to separate
  blankLine: true,

  // Each part of the log is a new line for readability
  newLine: true,

  colors: {
    log: 'cyan',
    success: 'green',
    warn: 'yellow',
    error: 'red'
  }

};

// Base wrapper used for other functions
_colorfulMessage = function(color, methodName){
  printMessages[methodName] =  function(){
    var
      i,
      args = [], // to transpose our args ( one arg will be changed colors )
      _colored = false; // to change only one color then back to white

    if( printMessages.blankLine ) console.log('');

    _.each(arguments, function(arg){

      // we get at least 1 message of that color, even if it isn't the first
      if (!_colored && 'string' == typeof arg) {
        args.push(arg[color]);
        _colored = true;

      } else args.push(arg);

    });

    if ( printMessages.newLine )
      _.each(args,function(arg){ console.log(arg); });
    else
      console.log.apply(console, args);

  }

};

// Call this again with your own options if you want different colors
printMessages.init = function(colors){

  if ( !colors )
    colors = printMessages.colors;

  // We bind our basic colored functions before we get tricky
  _.each(colors, _colorfulMessage);
};

printMessages.init();

// See readme for examples with pictures
_.extend(printMessages, {

  node: function(msg, err, result){
    if ( err )
      printMessages.error(msg, err);
    else
      printMessages.success(msg, result);
  },

  crash: function(err){
    process.nextTick(function(){
      var reason = (err && err.message) || err || 'Unknown Error';
      printMessages.error.apply(null, [reason, err && err.stack].concat(__slice.call(arguments, 1)));
      if ( 'string' == typeof err )
        throw new Erorr(err);
      throw err;
    });
  },

  crash_cb: function(){
    var msgs = __slice(arguments);
    return function(err){
      printMessages.crash.apply(null, [err].concat(msgs));
    };
  },

  promise: function(msg, promise){
    return promise
      .then(function(result){
        printMessages.success(msg, result);
      }, function(err){
        printMessages.error(msg, err);
      });
  },


}); 

// More wrapped methods ( crash was done above, it needs different args )
_.each(['node', 'log', 'success', 'warn', 'error'], function(type){

  printMessages[type + '_cb'] = function(msg){

    // We generate a callback for them that will play their message
    return function(){

      // When it gets called back it finally writes a message
      return printMessages[type].apply(null, [message].concat(__slice(arguments)));
    }
  }

});

module.exports = printMessages;

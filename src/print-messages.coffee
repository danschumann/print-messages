require('colors')

printMessages = {}

# We have types like logs, errors, and warnings that are the same except for color
printMessages.color = (color) ->
  ->
    _color = color
    console.log ''
    for arg, n in arguments
      if 'string' is typeof arg 
        console.log arg[_color] # we get at least 1 message of that color, even if it isn't the first
        _color = 'white'
      else if arg
        console.log arg

printMessages[n] = method for n, method of {
  log: printMessages.color('cyan')
  success: printMessages.color('green')
  warn: printMessages.color('yellow')
  error: printMessages.color('red')

  # example: 
  # user.save (err, result) ->
  #   pm.node('This might have worked', arguments...)
  node: (msg, err, result) ->
    if err
      @error msg, err
    else
      @success msg, result

  # Pass directly to a promise.otherwise for logging only failing
  crash: (err, args...) ->
    process.nextTick =>
      reason = err?.msg ? err ? 'Unknown error'
      printMessages.error reason, err?.stack, args...
    if 'string' is typeof err
      throw new Error err
    throw err

  crash_cb: (msgs...) ->
    (err) -> printMessages.crash err, msgs...

  promise: (msg, promise) ->
    promise.then (result) =>
      printMessages.success msg, result
    , (err) =>
      printMessages.error   msg, err


  node_cb: (msg) ->
    -> printMessages.node msg, arguments...
  
  log_cb: (msg) ->
    -> printMessages.log msg, arguments...

  success_cb: (msg) ->
    -> printMessages.success msg, arguments...

  warn_cb: (msg) ->
    -> printMessages.warn msg, arguments...

  error_cb: (msg) ->
    -> printMessages.error msg, arguments...

}

module.exports = printMessages

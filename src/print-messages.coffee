require('colors')

printMessages = {}

# We have types like logs, errors, and warnings that are the same except for color
printMessages.color = (color) ->
  ->
    console.log ''
    for arg, n in arguments
      if 'string' is typeof arg 
        console.log arg[unless n then color else 'white']
      else
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
      @warn msg, err
    else
      @success msg, result

  promise: (msg, promise) ->
    promise.then (result) =>
      @success msg, result
    , (err) =>
      @error   msg, err
}
console.log printMessages

module.exports = printMessages

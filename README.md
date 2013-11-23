print-messages
==============

Because making `console.log` easier to read and write is a double edge sword of time saving.

    npm install print-messages
    
```js
pm = require('print-messages');
```

Besides normal stuff like colored `log`, `warn`, `success`, and `error` methods, we have 2 more

* `node`
* `promise`

------------------------

Node.js usually has callbacks like `function(err, result){ ...`
```js
user.save(function(er,res){
    // String will be green or red depending on er, res
    pm.node('user.save results...', er, res);
})
```

-----------------------------

Promises are becoming popular
```js
var promiser = require('when');
willSucceed = promiser.defer()

pm.promise('promise result is(green or red): ', willSucceed.promise);
willSucceed.resolve("resolve is green");

// or we could have done this
//willSucceed.reject("reject is red");
```

--------------------------

#Examples

####Basic log, warn, success, error
![example-image](https://rawgithub.com/danschumann/print-messages/master/example_images/basic_example.gif)
```js
pm.log('log me', 'log me long tim');
pm.warn('warn me', 'warn me long tim');
pm.success('success me', 'success me long tim');
pm.error('error me', 'error me long tim');
```

#### Node callbacks  
![example-image](https://rawgithub.com/danschumann/print-messages/master/example_images/node_example.gif)
```js
// Node callbacks are usually (err, res)
pm.node('some failing save message', 'That failed', null);
pm.node('some success message', null, {
  results: 'are cool'
});
```

#### Promises    
![example-image](https://rawgithub.com/danschumann/print-messages/master/example_images/promise_example.gif)
```js
promise = require('when');
    
willSucceed = promise.defer();
willFail = promise.defer();
    
pm.promise('This is for a promise', willSucceed.promise);
willSucceed.resolve('That works');

pm.promise('Whereas this is for a promise', willFail.promise);
willFail.reject('That fails');
```

------------------------------
Patch Notes
------------------------------

v0.2.0

Added `pm.node_cb` for `user.save(pm.node_cb('My message might be green or red'))`

v0.1.0

Added `pm.crash` and `pm.crash_cb`
for `promise.otherwise(pm.crash)` or `promise.otherwise(pm.crash_cb('with message'))`

Added `pm.error_cb`, `pm.success_cb`, `pm.warn_cb`, `pm.log_cb`
for `user.save().error(pm.error_cb('it failed)); // logs: 'it failed'.red, errors...`

print-messages
==============

We console a lot, this handles it all

    npm install print-messages
    
```js
pm = require('print-messages');
```

Besides normal stuff like colored `log`, `warn`, `success`, and `error` methods, we have 2 more

* `node`
* `promise`

```js
user.save(function(er,res){
    // String will be green or red depending on er, res
    pm.node('user did what?', er, res);
})
    
var promiser = require('when');
willSucceed = promiser.defer()
// At this point, we don't know what color it will be    
pm.promise('This could be red if we call .reject, or green if .resolve', willSucceed.promise);
willSucceed.resolve("it's green, hooray!");
```

##Examples

####Basic log, warn, success, error
```js
pm.log('log me', 'log me long tim');
pm.warn('warn me', 'warn me long tim');
pm.success('success me', 'success me long tim');
pm.error('error me', 'error me long tim');
```

#### Node callbacks  
```js
// Node callbacks are usually (err, res)
pm.node('some failing save message', 'That failed', null);
pm.node('some success message', null, {
  results: 'are cool'
});
```

#### Promises    
```js
promise = require('when');
    
willSucceed = promise.defer();
willFail = promise.defer();
    
pm.promise('This is for a promise', willSucceed.promise);
willSucceed.resolve('That works');

pm.promise('Whereas this is for a promise', willFail.promise);
willFail.reject('That fails');
```

![example-image](https://rawgithub.com/danschumann/print-messages/master/example_output.gif)

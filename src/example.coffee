fs      = require 'fs'
pm      = require './print-messages'
will    = require 'when'

pm.log 'log me', 'log me long tim'
pm.warn 'warn me', 'warn me long tim'
pm.success 'success me', 'success me long tim'
pm.error 'error me', 'error me long tim'

pm.node 'some failing save message', 'That failed', null
pm.node 'some success message', null, {results: 'are cool'}

willSucceed = will.defer()
pm.promise 'This is for a promise', willSucceed.promise
willSucceed.resolve('That works')

willFail = will.defer()
pm.promise 'Whereas this is for a promise', willFail.promise
willFail.reject('That fails')

`
// This crashes things like we want it to
//require('when/monitor/console'); // this is needed for when to not swallow errors
//willFail = will.defer();
//willFail.promise.otherwise(pm.crash_cb 'Crash on fail');
//willFail.reject('doh!');
`

willFail = will.defer()
willFail.promise.otherwise(pm.error_cb 'Hopefully it fails')
willFail.reject('it does')

willFail = will.defer()
willFail.promise.otherwise(pm.error)
willFail.reject('no message but log failures')

willSucceed = will.defer()
willSucceed.promise.then(pm.success_cb 'Hopefully it succeeds')
willSucceed.resolve('it does')

willFail = will.defer()
willFail.promise.then(pm.success)
willFail.resolve('no message but log successes')

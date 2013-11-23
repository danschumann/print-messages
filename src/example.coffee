fs      = require 'fs'
pm      = require './print-messages'
promise    = require 'when'

pm.log 'log me', 'log me long tim'
pm.warn 'warn me', 'warn me long tim'
pm.success 'success me', 'success me long tim'
pm.error 'error me', 'error me long tim'

pm.node 'some failing save message', 'That failed', null
pm.node 'some success message', null, {results: 'are cool'}

willSucceed = promise.defer()
pm.promise 'This is for a promise', willSucceed.promise
willSucceed.resolve('That works')

willFail = promise.defer()
pm.promise 'Whereas this is for a promise', willFail.promise
willFail.reject('That fails')

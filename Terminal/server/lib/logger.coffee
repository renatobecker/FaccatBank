methods = Meteor.methods

Meteor.methods = (obj) ->
	for fnName, fn of obj
		do (fnName, fn) ->
			obj[fnName] = ->
				console.log 'TERMINAL:', fnName, arguments
				fn.apply this, arguments

	methods obj

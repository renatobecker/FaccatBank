agencia = '1'

chamarOperador = (operador, nome, data) ->
	operadorInterno = Cluster.discoverConnection("operador-#{operador}")
	try
		if Match.test data, Object
			data.agencia = agencia

		return operadorInterno.call nome, data
	catch e
		throw e


# Interno - Agencias
Meteor.methods
	'agencia:cadastrar': (data) ->
		return chamarOperador 'interno', 'agencia:cadastrar', data

	'agencia:deletar': (data) ->
		return chamarOperador 'interno', 'agencia:deletar', data


# Interno - Clientes
Meteor.methods
	'conta:cadastrar': (data) ->
		return chamarOperador 'interno', 'conta:cadastrar', data

	'conta:deletar': (data) ->
		return chamarOperador 'interno', 'conta:deletar', data


# Interno - Contas
Meteor.methods
	'cliente:cadastrar': (data) ->
		return chamarOperador 'interno', 'cliente:cadastrar', data

	'cliente:deletar': (data) ->
		return chamarOperador 'interno', 'cliente:deletar', data


# Deposito
Meteor.methods
	'deposito': (data) ->
		return chamarOperador 'deposito', 'depositar', data

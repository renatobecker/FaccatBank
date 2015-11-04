Meteor.methods
	transferir: (data) ->
		check data, Object
		check data.de, Object
		check data.para, Object

		Validations.agencia data.de.agencia
		Validations.conta data.de.conta
		Verifications.deveExistirAgencia data.de.agencia
		Verifications.deveExistirConta data.de.conta

		Validations.agencia data.para.agencia
		Validations.conta data.para.conta
		Verifications.deveExistirAgencia data.para.agencia
		Verifications.deveExistirConta data.para.conta

		Validations.valor data.valor

		# Debito de
		transacoes.insert
			operacao: 'transferencia'
			tipo: 'debito'
			para: data.para
			agencia: data.de.agencia
			conta: data.de.conta
			operador: Meteor.userId()
			valor: data.valor

		contas.update
			_id: data.de.conta
			agencia: data.de.agencia
		,
			$inc:
				valor: -data.valor


		# Credito para
		transacoes.insert
			operacao: 'transferencia'
			tipo: 'credito'
			de: data.de
			agencia: data.para.agencia
			conta: data.para.conta
			operador: Meteor.userId()
			valor: data.valor

		contas.update
			_id: data.para.conta
			agencia: data.para.agencia
		,
			$inc:
				valor: data.valor

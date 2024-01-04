1.  Execute o MYSQL:
    Execute o arquivo "ld_smartbank > data.sql" no seu banco de dados.
    Certifique-se de que tudo foi criado, sem erros.

2.  API (para desenvolvedores):
    Caso queira inserir multas, a partir de outro script, basta utilizar o seguinte export com os parâmetros passados:
	> exports['ld_smartbank']:CreateFine(source, "NOME DO RESPONSÁVEL", parseInt(valor), motivo)
	
	------------------------------------------------------------------------------------------------------------------
	
	Caso queira adicionar registros ao EXTRATO, basta utilizar o seguinte export com os parâmetros passados:
	> exports['ld_smartbank']:RegisterNewEntry(source, tipo, quantidade, motivo)
	
	No segundo parâmetro, você pode utilizar 3 tipos:
	- WITHDRAW
	- DEPOSIT
	- TRANSFER

	Segue exemplo:
	> exports['ld_smartbank']:RegisterNewEntry(source, 'deposit', 1000, 'Pagamento de salário')
	
	------------------------------------------------------------------------------------------------------------------
	
	Caso queira alterar o PIX do jogador, é disponibilizado o método SERVER-SIDE:
	exports['ld_smartbank']:ChangePix(PIX_ANTIGO, PIX_NOVO)
	
	Segue exemplo:
	> exports['ld_smartbank']:ChangePix("pixTeste", "novoPix")

3.  Mensagens/Textos
    Todos os textos/mensagens se encontram em 'locales/pt-br.lua'

4.  Autenticação
    Basta colocar o token obtido pelo bot (no discord) no arquivo 'server/server_config.lua', na parte onde possui "exports LICENSE"

Obrigado pela compra!
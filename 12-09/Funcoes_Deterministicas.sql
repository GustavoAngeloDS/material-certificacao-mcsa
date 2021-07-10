-- As funções determinísticas são as quais retornam o mesmo resultado a partir de um determinado parãmetro de entrada
-- Basicamente: Ao receber o parâmetro de entrada, sempre que ela for executada trará o mesmo resultado.
-- Exemplos: Operações aritiméticas e operações de manipulação de strings

USE ESTUDOS
GO

-- SEMPRE QUE EU EXECUTAR A FUNÇÃO ABAIXO, A MESMA SEMPRE RETORNARÁ COMO RESULTADO: 'TESTE DE DETERMINISMO' DESDE QUE OS MESMOS PARÂMETROS SEJAM INFORMADOS
SELECT SUBSTRING('TESTE DE DETERMINISMO', 1, 21)

-- NESTE INSTANTE AO EXECUTAR A FUNÇÃO SUM EXISTEM 6 VEÍCULOS CADASTRADOS NA BASE DE DADOS, TOTALIZANDO UM VALOR DE 122200.00
-- A FUNÇÃO SUM SEMPRE RETORNARÁ O VALOR 122200.00 DESDE QUE OS MESMOS VEÍCULOS ESTEJAM CADASTRADOS E COM SEUS VALORES EQUALIZADOS COM O TESTE DE AGORA
-- OBSERVAR O TRECHO ABAIXO DA DOCUMENTAÇÃO DO SQL:
/*
As funções determinísticas sempre retornam o mesmo resultado quando são 
chamadas com o uso de um conjunto específico de valores de 
entrada E QUANDO RECEBEM O MESMO ESTADO DO BANCO DE DADOS.
*/
-- "E quando recebem o mesmo estado do banco de dados".
-- Uma alteração nos veículos cadastrados romperia a regra estipulada, fazendo com que o SUM devolvesse um valor diferente de 122200.00
-- A alteração na base não faria com que a função deixasse de ser determinística *
SELECT SUM(CARRO_VL_FIPE) FROM CARRO

-- IMPORTANTE:
-- TODAS AS FUNÇÕES AGREGADAS (SUM, AVG, MIN, MAX COUNT) SÃO DETERMINÍSTICAS
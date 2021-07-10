-- As fun��es determin�sticas s�o as quais retornam o mesmo resultado a partir de um determinado par�metro de entrada
-- Basicamente: Ao receber o par�metro de entrada, sempre que ela for executada trar� o mesmo resultado.
-- Exemplos: Opera��es aritim�ticas e opera��es de manipula��o de strings

USE ESTUDOS
GO

-- SEMPRE QUE EU EXECUTAR A FUN��O ABAIXO, A MESMA SEMPRE RETORNAR� COMO RESULTADO: 'TESTE DE DETERMINISMO' DESDE QUE OS MESMOS PAR�METROS SEJAM INFORMADOS
SELECT SUBSTRING('TESTE DE DETERMINISMO', 1, 21)

-- NESTE INSTANTE AO EXECUTAR A FUN��O SUM EXISTEM 6 VE�CULOS CADASTRADOS NA BASE DE DADOS, TOTALIZANDO UM VALOR DE 122200.00
-- A FUN��O SUM SEMPRE RETORNAR� O VALOR 122200.00 DESDE QUE OS MESMOS VE�CULOS ESTEJAM CADASTRADOS E COM SEUS VALORES EQUALIZADOS COM O TESTE DE AGORA
-- OBSERVAR O TRECHO ABAIXO DA DOCUMENTA��O DO SQL:
/*
As fun��es determin�sticas sempre retornam o mesmo resultado quando s�o 
chamadas com o uso de um conjunto espec�fico de valores de 
entrada E QUANDO RECEBEM O MESMO ESTADO DO BANCO DE DADOS.
*/
-- "E quando recebem o mesmo estado do banco de dados".
-- Uma altera��o nos ve�culos cadastrados romperia a regra estipulada, fazendo com que o SUM devolvesse um valor diferente de 122200.00
-- A altera��o na base n�o faria com que a fun��o deixasse de ser determin�stica *
SELECT SUM(CARRO_VL_FIPE) FROM CARRO

-- IMPORTANTE:
-- TODAS AS FUN��ES AGREGADAS (SUM, AVG, MIN, MAX COUNT) S�O DETERMIN�STICAS
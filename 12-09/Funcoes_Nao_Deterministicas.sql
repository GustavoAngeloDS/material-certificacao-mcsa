-- FUN��ES N�O DETERMINISTICAS
-- AS FUN��ES N�O DETERMINISTICAS PODEM RETORNAR VALORES DIFERENTES MESMO QUE O ESTADO DE BANCO DE DADOS SEJA IGUAL E QUE OS PAR�METROS INFORMADOS SEJAM IGUAIS.

USE ESTUDOS
GO

-- EXEMPLO 1: 
SELECT GETDATE()
-- INDEPENDENTEMENTE DE QUANTAS VEZES OU A QUE MOMENTO EU EXECUTE O COMANDO ACIMA, ELE SEMPRE ME TORNAR� UM VALOR DIFERENTE.
-- O ESTADO DO BANCO DE DADOS PODE PERMANECER O MESMO E OS PAR�METROS INFORMADOS S�O OS MESMOS (NENHUM), CONTUDO AINDA SIM O RETORNO � DIFERENTE.

-- A FUN��O CONVERT DEPENDENDO DO PAR�METRO INFORMADO, PODE N�O SER DETERMIN�STICA
-- PARA TAL COISA ACONTECER, O PAR�METRO INFORMADO PARA A CONVERS�O DEVE SER N�O DETERMINISTICO.W
SELECT CONVERT(VARCHAR(200), GETDATE(), 103)
-- SE A CONSULTAR FOR EXECUTADA TODO DIA, DA MESMA MANEIRA ELA SEMPRE RETORNAR� UM VALOR DIFERENTE DO ANTERIOR.

-- EXEMPLO 2:
-- O USO DA FUN��O RAND() SEM O PAR�METRO INFORMADO (SEED) GERA UM N�MERO FLOAT TOTALMENTE RANDOMICO. SENDO A FUN��O CONSIDERADA COMO N�O DETERMINISTA.
-- CONTUDO AO UTILIZAR QUALQUER VALOR SENDO O SEED, ELA SE TORNA UMA FUN��O DETERMIN�STICA (POIS O SEED FOI INFORMADO)
-- * SE QUALQUER UM PAR�METRO FOR INFORMADO PARA QUALQUER CHAMADA DO RAND, TODOS SE TORNAR�O DETERMIN�TAS (V�O RETORNAR O MESMO VALOR SEMPRE)
SELECT RAND()
-- SELECT RAND(100)
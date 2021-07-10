-- O EXEMPLO ABAIXO � FEITO ENTRE TRANSA��ES PARA FACILITAR A UTILIZA��O DELE

-- TABELAS TEMPORAIS
-- CRIAR UMA TABELA COMUM, ACRESCIDO DE ALGUNS TIPOS ESPECIFICOS:
-- OBRIGAT�RIO CRIAR 2 CAMPOS DATETIME2 (2). UM DELES VAI INDICAR QUANDO O VALOR FOI INSERIDO E OUTRO QUANDO ELE FOI EXCLUIDO/EDITADO
-- OS CAMPOS DEVEM CONTER AS INSTRU��ES: GENERATED ALWAYS AS ROW START -> INDICANDO QUE SER�O INICIADOS QUANDO A LINHA FOR INICIADA
-- E OUTRO: GENERATED ALWAYS AS ROW END -> INDICANDO SEMPRE QUE A LINHA FOR EXCLUIDA/ALTERADA
-- AS MARCA��ES DE VALIDADES DOS REGISTROS (DOS CAMPOS MENCIONADOS A CIMA) FICA POR CONTA DO SQL SERVER
-- AO CRIAR OS 2 CAMPOS DATETIME2, INCLUIR UMA INSTRU��O INDICANDO QUAIS S�O OS CAMPOS RESPONS�VEIS POR TAL REGISTRO TEMPORAL DE VALIDADE (CAMPOS DATETIME2)
-- USANDO O COMANDO: PERIOD FOR SYSTEM_TIME(NOME_CAMPO_1, NOME_CAMPO_2)
-- AO TERMINAR A RECLARA��O DA TABELA COLOCAR A SEGUINTE INSTRU��O AO FECHAR OS PARENTESES DO CREATE TABLE:
-- WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.NOMETABELAHistory)) O QUAL INDICA QUE A TABELA SER� VERSIONADA E INDICANDO O NOME DA TABELA A SER CRIADA
-- 

BEGIN TRANSACTION TR1
CREATE TABLE NOTA_FISCAL(
  NOTA_ID_NOTA  NUMERIC(18,0) NOT NULL PRIMARY KEY IDENTITY (1,1),
  NOTA_VL_NOTA  NUMERIC(17,2) NULL,
  NOTA_NR_VENDA NUMERIC(18,0) NOT NULL FOREIGN KEY (NOTA_NR_VENDA) REFERENCES VENDA(VENDA_NR_ID),
  NOTA_DT_NOTA  VARCHAR(8) NULL,
  VALIDO_DE     DATETIME2(2)  GENERATED ALWAYS AS ROW START,
  VALIDO_ATE    DATETIME2(2)  GENERATED ALWAYS AS ROW END,
  PERIOD FOR SYSTEM_TIME (VALIDO_DE, VALIDO_ATE)
) WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.NOTA_FISCALHISTORY))


INSERT INTO NOTA_FISCAL (NOTA_VL_NOTA, NOTA_NR_VENDA, NOTA_DT_NOTA)VALUES (12000.00, 4, CONVERT(VARCHAR(8), GETDATE(), 112))
INSERT INTO NOTA_FISCAL (NOTA_VL_NOTA, NOTA_NR_VENDA, NOTA_DT_NOTA)VALUES (88500.00, 6, CONVERT(VARCHAR(8), GETDATE(), 112))

UPDATE NOTA_FISCAL SET NOTA_DT_NOTA = '20200921' WHERE NOTA_NR_VENDA = 6
UPDATE NOTA_FISCAL SET NOTA_VL_NOTA = 88550.00 WHERE NOTA_NR_VENDA = 6

DELETE FROM NOTA_FISCAL WHERE NOTA_NR_VENDA = 4

SELECT * FROM NOTA_FISCAL

SELECT * FROM NOTA_FISCALHISTORY

-- PARA CONSULTAR OS DADOS DAS TABELAS:
-- VALORES ENTRE 2 DATAS
SELECT * FROM NOTA_FISCAL FOR SYSTEM_TIME BETWEEN '2020-09-20' AND '2020-09-21'

-- VALORES DE APENAS 1 DATA
SELECT * FROM NOTA_FISCAL FOR SYSTEM_TIME AS OF '2020-09-20 16:00:00'

-- TODOS OS VALORES
SELECT * FROM DBO.NOTA_FISCALHISTORY

/*

PARA EXCLUIR UMA TABELA QUE EST� SENDO VERSIONADA, PRIMEIRO PRECISAMOS DESATIVAR O VERSIONAMENTO.
ALTER TABLE TABELA SET (SYSTEM_VERSIONING = OFF)
DROP TABLE TABELA
DROP TABLE TABELAHistory

*/

ALTER TABLE NOTA_FISCAL SET (SYSTEM_VERSIONING = OFF)
DROP TABLE NOTA_FISCAL
DROP TABLE dbo.NOTA_FISCALHISTORY

ROLLBACK TRANSACTION TR1
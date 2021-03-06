USE ESTUDOS
GO

-- CTE (COMMON TABLE EXPRESSIONS)
-- A CTE ? UM RECURSO BEM IMPORTANTE E PR?TICO.
-- BASICAMENTE ELA CONSEGUE REALIZAR SUBQUERYS E SE PARECE COM UMA TABELA DERIVADA
-- CONTUDO NO QUE ELA DIFERENCIA ? A FLEXIBILIDADE E A POSSIBILIDADE DE SER CHAMADA NO C?DIGO DIVERSAS VEZES COMO SE FOSSE UMA TABELA F?SICA!
-- CONSEGUIMOS REALIZAR AQUI, UMA ESP?CIE DE VIEW, POIS PODEMOS MANIPULAR E UNIR DIVERSAS TABELAS DENTRO DE APENAS UMA CTE, PROPORCIONANDO 1 ?NICO RESULTSET
-- COM INFORMA??ES AGREGADAS DE OUTRAS TABELAS;

-- ? POSS?VEL USAR O CTE COMO FROM, BASE PARA INSERT, UPDATE OU DELETE, JOIN, CROSS OU OUTER APPLY.

-- SCHEMA B?SICO DO CTE:
/*
WITH NOME_CTE(ALIAS_CAMPOS_OPCIONAL) AS (
SELECT
  CAMPO1,
  CAMPO2
FROM
  TABELA 
WHERE
  X = X
)

SELECT * FROM NOME_CTE

*/
-- EXEMPLO 1 : TRAZER TODAS AS VENDAS E OS RESPECTIVOS NOMES DE CADA UM DIS COMPRADORES.
WITH VENDAS_E_CLIENTES AS (
SELECT
  VENDA_VL_TOTAL,
  CLIENTE_NM_NOME
FROM
  VENDA INNER JOIN CLIENTE ON (VENDA_NR_CLIENTE = CLIENTE_NR_ID)
)
SELECT * FROM VENDAS_E_CLIENTES

-- A DIFEREN?A ENTRE UMA TABELA TEMPOR?RIA
-- O CTE PODE SER USADO SOMENTE NO MOMENTO DE EXECU??O DA ROTINA, ENQUANTO A TABELA TEMPOR?RIA FICA DISPON?VEL A TODOS INSTANTE DA SESS?O.
-- O CTE AUTOMATICAMENTE CRIA OS CAMPOS COM OS MESMOS DATATYPES DOS CAMPOS ORIGINAIS, ENQUANTO NAS TABELAS TEMPOR?RIAS VOC? DEVERIA INSERIR MANUALMENTE.
-- CTE ? MAIS PERFORM?TICO AL?M DE PERMITIR RECURSIVIDADE, FUNCIONANDO COMO UMA ESP?CIE DE FUN??O!
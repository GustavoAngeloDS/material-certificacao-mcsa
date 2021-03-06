USE ESTUDOS
GO

-- FUN??ES DE DESLOCAMENTO / FUNCTIONS OFFSET
-- S?O FUN??ES QUE CONSEGUEM RETORNAR VALORES DE OUTRAS LINHAS (ANTERIOR/PR?XIMA, PRIMEIRA/ULTIMA)
-- AS FUN??ES S?O: LAG, LEAD, FIRST_VALUE, LAST_VALUE

SELECT
  CARRO_NR_ID AS ID,
  LAG(CARRO_NR_ID)         OVER (ORDER BY CARRO_NR_ID)AS ANTERIOR,
  LEAD(CARRO_NR_ID)        OVER (ORDER BY CARRO_NR_ID)AS PROXIMO,
  FIRST_VALUE(CARRO_NR_ID) OVER (ORDER BY CARRO_NR_ID)AS PRIMEIRO,
  LAST_VALUE(CARRO_NR_ID)  OVER (ORDER BY CARRO_NR_ID)AS ULTIMO
FROM
  CARRO
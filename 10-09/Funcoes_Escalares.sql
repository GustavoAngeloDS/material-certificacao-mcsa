/*

As fun��es de valores escalares s�o:
As fun��es que retornam apenas 1 resultset.

Exemplos de fun��es nativas: CONCAT, LTRIM, RTRIM, SUBSTRING, etc...
Ambas podem receber N par�metros de entrada, contudo s�o definidas como escalares porque retornam apenas 1 valor.

As fun��es tamb�m podem ser chamadas de UDF (User Defined Funcion) as quais n�o s�o nativas do SQL (s�o fun��es criadas)

SCHEMA DE CRIA��O DE UMA FUN��O: 

CREATE FUNCTION NOME_FUNCAO (
  @PARAMETRO DATATYPE
)
RETURNS DATATYPE DE RETORNO OU @TABELA DE RETORNO TABLE (
  CAMPO_TABELA DATATYPE
)
AS
BEGIN
  CORPO DA FUNCTION
  
  RETURN
END


*/

USE ESTUDOS

IF EXISTS(SELECT * FROM SYSOBJECTS WHERE sysobjects.name='FNC_CORVEICULO')
  DROP FUNCTION FNC_CORVEICULO
GO

CREATE FUNCTION FNC_CORVEICULO (
  @CARRO_NR_ID NUMERIC(18,0)
)
RETURNS VARCHAR(20) 
AS
BEGIN  
  DECLARE @COR_VEICULO VARCHAR(20)

  SELECT 
    @COR_VEICULO = CARRO_DS_COR
  FROM 
    CARRO
  WHERE 
    CARRO_NR_ID = @CARRO_NR_ID

  RETURN @COR_VEICULO
END
GO

SELECT DBO.FNC_CORVEICULO(3) AS 'COR'
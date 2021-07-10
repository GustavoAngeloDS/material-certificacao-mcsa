USE ESTUDOS
GO

-- FUN��ES E ARMAZENAMENTO RELACIONADOS A DATAS
-- O SQL POSSUI 6 TIPOS PARA GUARDAR DATAS
-- DATE           - ARMAZENA S� A DATA
-- TIME           - ARMAZENA S� A HORA
-- DATETIME       - ARMAZENA DATA E HORA
-- SMALLDATETIME  - ARMAZENA DATA E HORA RESUMIDOS
-- DATETIME2      - ARMAZENA DATA E HORA COM PRECIS�O
-- DATETIMEOFFSET - ARMAZENA DATA E HORA COM PRECIS�O E TAMB�M O FUSO HOR�RIO
/*

FUN��ES DE DATA E HORA:

GETDATE()           - RETORNA A DATA E HOR�RIO                             - RETORNO DEFAULT (DATETIME).
CURRENT_TIMESTAMP() - RETORNA A DATA E HOR�RIO                             - RETORNO DEFAULT (DATETIME).
SYSDATETIME()       - RETORNA A DATA E HOR�RIO PRECISOS                    - RETORNO DEFAULT (DATETIME2)
SYSDATETIMEOFFSET() - RETORNA A DATA, HOR�RIO E FUSO HOR�RIO               - RETORNO DEFAULT (DATETIMEOFFSET)
GETUTCDATE()        - RETORNA O DIA E HORA NO HOR�RIO MUNDIAL UTC          - RETORNO DEFAULT (DATETIME) 
SYSUTCDATETIME()    - RETORNA O DIA E HORA PRECISOS NO HOR�RIO MUNDIAL UTC - RETORNO DEFAULT (DATETIME2)   */

/*************************/
/* GETDATE()             */
/*************************/
SELECT 
  GETDATE()                         AS [GETDATE - NORMAL]        ,
  CAST(GETDATE() AS DATE)           AS [GETDATE - DATE]          ,
  CAST(GETDATE() AS TIME)           AS [GETDATE - TIME]          ,
  CAST(GETDATE() AS DATETIME)       AS [GETDATE - DATETIME]      ,
  CAST(GETDATE() AS SMALLDATETIME)  AS [GETDATE - SMALLDATETIME] ,
  CAST(GETDATE() AS DATETIME2)      AS [GETDATE - DATETIME2]     ,
  CAST(GETDATE() AS DATETIMEOFFSET) AS [GETDATE - DATETIMEOFFSET]

/*************************/
/* SYSDATETIMEOFFSET()   */
/*************************/
SELECT 
  SYSDATETIMEOFFSET()                         AS [SYSDATETIMEOFFSET - NORMAL]        ,
  CAST(SYSDATETIMEOFFSET() AS DATE)           AS [SYSDATETIMEOFFSET - DATE]          ,
  CAST(SYSDATETIMEOFFSET() AS TIME)           AS [SYSDATETIMEOFFSET - TIME]          ,
  CAST(SYSDATETIMEOFFSET() AS DATETIME)       AS [SYSDATETIMEOFFSET - DATETIME]      ,
  CAST(SYSDATETIMEOFFSET() AS SMALLDATETIME)  AS [SYSDATETIMEOFFSET - SMALLDATETIME] ,
  CAST(SYSDATETIMEOFFSET() AS DATETIME2)      AS [SYSDATETIMEOFFSET - DATETIME2]     ,
  CAST(SYSDATETIMEOFFSET() AS DATETIMEOFFSET) AS [SYSDATETIMEOFFSET - DATETIMEOFFSET]

/*************************/
/*   SYSUTCDATETIME()    */
/*************************/
SELECT 
  SYSUTCDATETIME()                         AS [SYSUTCDATETIME - NORMAL]        ,
  CAST(SYSUTCDATETIME() AS DATE)           AS [SYSUTCDATETIME - DATE]          ,
  CAST(SYSUTCDATETIME() AS TIME)           AS [SYSUTCDATETIME - TIME]          ,
  CAST(SYSUTCDATETIME() AS DATETIME)       AS [SYSUTCDATETIME - DATETIME]      ,
  CAST(SYSUTCDATETIME() AS SMALLDATETIME)  AS [SYSUTCDATETIME - SMALLDATETIME] ,
  CAST(SYSUTCDATETIME() AS DATETIME2)      AS [SYSUTCDATETIME - DATETIME2]     ,
  CAST(SYSUTCDATETIME() AS DATETIMEOFFSET) AS [SYSUTCDATETIME - DATETIMEOFFSET]

-- FUN��ES PARA MANIPULA��O DE DATAS

-- DATEPART()         - PEGA UMA DETERMINADA PARTE DA DATA (DIA, MES, ANO)
-- DATENAME()         - RETORNA O NOME DO MES OU DIA
-- DATEFROMPARTS()    - CONSEGUE COMPOR UMA DATA UTILIZANDO VALORES NUM�RICOS (PODE SE EXTENDER PARA OUTROS TIPOS DE DATA. EX DATETIME2FROMPARTES()).
-- EOMONTH()          - RETORNA O ULTIMO DIA DO M�S DA DATA INFORMADA
-- DATEADD()          - ACRESCENDA DIAS, MESES OU ANOS A DATA INFORMADA
-- DATEDIFF()         - CAPTURA A QUANTIDADE DE DIAS, MESES OU ANOS ENTRE AS DATAS INFORMADAS
-- SWITCHOFFSET()     - ALTERA O FUSO HOR�RIO DE UMA DETERMINADA DATA
-- TODATETIMEOFFSET() - INCLUI UM FUSO HOR�RIO EM UMA DATA QUE N�O POSSUI
-- AT TIME ZONE       - FUNCIONA APENAS PARA DATAS QUE POSSUEM FUSO HOR�RIO. ALTERA O FUSO HOR�RIO PARA UMA DETERMINADA REGI�O INFORMADA

-- EXEMPLO DATEPART()
DECLARE 
  @DATA_TESTE DATETIMEOFFSET = SYSDATETIMEOFFSET()

SELECT
  DATEPART(M, @DATA_TESTE) [MES ATUAL]

-- EXEMPLO DATENAME()
SELECT
  DATENAME(WEEKDAY, @DATA_TESTE) [DIA ATUAL]

-- EXEMPLO DATETIMEFROMPARTS()
SELECT
  DATETIMEFROMPARTS(2010, 01, 01, 12, 59 ,59, 0) [DATA MONTADA]

-- EXEMPLO EOMONTH()
SELECT
  EOMONTH(GETDATE()) [ULTIMO DIA MES ATUAL]

-- EXEMPLO DATEADD()
SELECT
  DATEADD(D, 10, GETDATE()) [+ 10 DIAS]

-- DATEDIFF()
SELECT
  DATEDIFF(Y, GETDATE(), DATEADD(Y, 122, GETDATE())) [DIF ANOS DATA ATUAL + 122]

-- SWITCHOFFSET()
SELECT
  SWITCHOFFSET(@DATA_TESTE, '-04:00') [FUSO HORARIO DATA ATUAL -4]

-- TODATETIMEOFFSET()
SELECT
  TODATETIMEOFFSET(GETDATE(), '-04:00') [INCLUINDO FUSO HORARIO EM DATA QUE N�O POSSUI]

-- AT TIME ZONE
SELECT
  GETDATE() AT TIME ZONE 'Central European Standard Time' [SETANDO TIME ZONE EUROPEU]
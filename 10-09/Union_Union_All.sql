-- UNION ? USADO PARA RETIRAR REGISTROS DUPLICADOS
-- UNION ALL ? USADO PARA UNIR AS CONSULTAS, SE FOR O CASO AT? MESMO REPETINDO OS VALORES DAS CONSULTAS CASO AMBAS RETORNEM O MESMO.

-- TANTO UNION QUANTO UNION ALL DEVEM SER USADOS PARA UNIR CONSULTAS QUE POSSUEM O MESMO DATATYPE E O MESMO NOME DO CAMPO (ALIAS TAMB?M SERVE)
SELECT CARRO_DS_MODELO AS MODELO, CARRO_DS_COR, CARRO_QT_PORTAS FROM CARRO WHERE CARRO_NR_ANO <= 2010
UNION 
SELECT CARRO_DS_MODELO AS MODELO, CARRO_DS_COR, CARRO_QT_PORTAS FROM CARRO WHERE CARRO_NR_ANO > 2010
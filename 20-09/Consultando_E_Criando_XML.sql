USE ESTUDOS
GO

/***************************************************************************/
/*                     CRIANDO XML COM QUERYS                              */
/***************************************************************************//*


XML É UM DATA TYPE NO SQL SERVER
A CLAUSULA "FOR XML" É ESPECIFICADA APÓS O FROM E É USADA PARA INDICAR QUE O ENSUMO GERADO VAI SER EM XML

EXISTEM 4 MÓDOS DE GERAR O XML UTILIZANDO O FOR XML:
RAW      = Gera uma linha única contendo todos os elementos (campos) para cada item retornado pelo select (PODE USAR ROOT E ELEMENTS)
	EXEMPLO: <row CARRO_NR_ID="1" CARRO_DS_MODELO="MEGANE" CARRO_NR_ANO="2008" CARRO_DS_COR="CINZA" CARRO_QT_PORTAS="4" CARRO_TP_ACESSORIO="1" CARRO_VL_FIPE="18900.00" CARRO_PC_DSCAVISTA="5.00" />
	
AUTO     =  Muito parecido com o RAW, contudo define o objeto "ROOT" sendo o nome da tabela (PODE USAR ROOT E ELEMENTS)
	EXEMPLO: <CARRO CARRO_NR_ID="1" CARRO_DS_MODELO="MEGANE" CARRO_NR_ANO="2008" CARRO_DS_COR="CINZA" CARRO_QT_PORTAS="4" CARRO_TP_ACESSORIO="1" CARRO_VL_FIPE="18900.00" CARRO_PC_DSCAVISTA="5.00" />

EXPLICIT = Permite o controle total do que vai ser criado no XMl e até mesmo as suas estruturas de hierarquia. Contudo sua manutenção se torna muito complexa pois exige hardcodes indicando as hierarquias e níveis.
	EXEMPLO:<Carro CarroNrId="1">
              <Carro CarroDsCor="CINZA" CarroDsModelo="MEGANE" CarroNrAno="2008" />
            </Carro>

PATH	 = É a opção mais completa e simples de ser usada. Separa os elementos de maneira automática. Cada registro da tabela se torna um objeto.
	EXEMPLO:<VEICULOS>
              <CARRO_NR_ID>1</CARRO_NR_ID>
              <CARRO_DS_MODELO>MEGANE</CARRO_DS_MODELO>
              <CARRO_NR_ANO>2008</CARRO_NR_ANO>
              <CARRO_DS_COR>CINZA</CARRO_DS_COR>
              <CARRO_QT_PORTAS>4</CARRO_QT_PORTAS>
              <CARRO_TP_ACESSORIO>1</CARRO_TP_ACESSORIO>
              <CARRO_VL_FIPE>18900.00</CARRO_VL_FIPE>
              <CARRO_PC_DSCAVISTA>5.00</CARRO_PC_DSCAVISTA>
            </VEICULOS>

*/

-- EXEMPLO 1 : RAW
SELECT
  *
FROM
  CARRO FOR XML RAW, ROOT('CARRO'), ELEMENTS

-- EXEMPLO 2 : AUTO
SELECT
  *
FROM
  CARRO FOR XML AUTO, ROOT('CARRO'), ELEMENTS

-- EXEMPLO 3 : EXPLICIT
SELECT
  1    AS Tag,
  NULL AS Parent,
  CARRO_NR_ID AS 'Carro!1!CarroNrId',
  NULL 'Carro!2!CarroDsCor',
  NULL 'Carro!2!CarroDsModelo',
  NULL 'Carro!2!CarroNrAno'
FROM
  CARRO 
UNION ALL
SELECT
  2 AS Tag,
  1 AS Parent,
  CARRO_NR_ID,
  CARRO_DS_COR   , 
  CARRO_DS_MODELO, 
  CARRO_NR_ANO   
FROM 
  CARRO
ORDER BY 
  [Carro!1!CarroNrId], 
  [Carro!2!CarroDsCor]
FOR XML EXPLICIT, ROOT('CARRO')

-- EXEMPLO 4 : PATH
SELECT 
  CARRO_NR_ID            AS '@CarroNrId',
  CARRO_DS_MODELO        AS 'Modelo',
  CARRO_NR_ANO           AS 'Ano',
  CARRO_DS_COR           AS 'Cor',
  CARRO_QT_PORTAS        AS 'Portas/Quantidade',
  CARRO_TP_ACESSORIO     AS 'Acessorio/TipoAcessorio',
  ACESSORIO_DS_DESCRICAO AS 'Acessorio/Descricao',
  CARRO_VL_FIPE          AS 'ValorFipe',
  CARRO_PC_DSCAVISTA     AS 'DescontoAVista'
FROM 
  CARRO INNER JOIN ACESSORIO ON (CARRO_TP_ACESSORIO = ACESSORIO_TP_ACESSORIO)
FOR XML PATH('CARRO'), ROOT ('VEICULOS')

/*
*********************************
*     ANOTAÇÕES IMPORTANTES!    *
*********************************
ROOT = DEFINE O ELEMENTO RAIZ DO XML
EXEMPLO: (CARRO)
		<CARRO>
		  <CARRO_NR_ID = 1>
		</CARRO>

@ = O @ NO ALIAS DO CAMPO NO MODO PATH SIGNIFICA QUE A INFORMAÇÃO FICARÁ NO TOPO DO OBJETO (NA DECLARAÇÃO)
EXEMPLO: (@CarroNrId)
		<VEICULOS>
		  <CARRO CarroNrId="1"> <--------------- AQUI
		    <Modelo>MEGANE</Modelo>
		    <Ano>2008</Ano>
		    <Cor>CINZA</Cor>
		    <Portas>
		      <Quantidade>4</Quantidade>
		    </Portas>
		    <Acessorio>
		      <TipoAcessorio>1</TipoAcessorio>
		      <Descricao>COMPLETO</Descricao>
		    </Acessorio>
		    <ValorFipe>18900.00</ValorFipe>
		    <DescontoAVista>5.00</DescontoAVista>
		  </CARRO>
		</VEICULOS>

/ = CRIA "CAMINHOS/SUBCAMINHOS" DENTRO DOS OBJETOS
EXEMPLO: ('Portas/Quantidade')
		<VEICULOS>
		  <CARRO CarroNrId="1">
		    <Modelo>MEGANE</Modelo>
		    <Ano>2008</Ano>
		    <Cor>CINZA</Cor>
		    <Portas> <<----------------- AQUI
		      <Quantidade>4</Quantidade> <<----- QUANTIDADE ESTÁ DENTRO DO CAMINHO "Portas"
		    </Portas>
		    <Acessorio>
		      <TipoAcessorio>1</TipoAcessorio>
		      <Descricao>COMPLETO</Descricao>
		    </Acessorio>
		    <ValorFipe>18900.00</ValorFipe>
		    <DescontoAVista>5.00</DescontoAVista>
		  </CARRO>
		</VEICULOS>
  */

/***************************************************************************/
/*                  LENDO O XML E RETORNANDO EM FORMA RELACIONAL           */
/***************************************************************************//*

PARA LER O XML 

sp_xml_preparedocument = realiza a transformação do objeto (transforma em uma arvore para ser lido pelo sql) - o openxml só funciona com ele feito dessa maneira.



*/

DECLARE @XML VARCHAR(MAX) = '
<?xml version="1.0" encoding="UTF-8"?>
<VEICULOS>
<CARRO>
  <CarroNrId>1</CarroNrId>
  <Modelo>MEGANE</Modelo>
  <Ano>2008</Ano>
  <Cor>CINZA</Cor>
  <QtPortas>4</QtPortas>
  <DescricaoAcessorio>COMPLETO</DescricaoAcessorio>
  <ValorFipe>18900.00</ValorFipe>
  <DescontoAVista>5.00</DescontoAVista>
</CARRO>
</VEICULOS>'

DECLARE @preppedXmlHandle INT

EXEC sp_xml_preparedocument @preppedXmlHandle OUTPUT, @XML; 
print @preppedXmlHandle
SELECT *
FROM OPENXML(@preppedXmlHandle, 'VEICULOS/CARRO', 2)
  WITH (
		CarroNrId NUMERIC(18,0),
		Modelo VARCHAR(200),
		Ano NUMERIC(4),
		Cor VARCHAR(20),
		QtPortas NUMERIC(1),
		DescricaoAcessorio VARCHAR(20),
		ValorFipe NUMERIC(17,2),
		DescontoAVista NUMERIC(5,2)
    )

EXEC sp_xml_removedocument @preppedXmlHandle
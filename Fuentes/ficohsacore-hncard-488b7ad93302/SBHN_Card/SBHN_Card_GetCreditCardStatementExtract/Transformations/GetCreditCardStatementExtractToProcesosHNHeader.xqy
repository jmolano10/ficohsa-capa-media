xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://tempuri.org/";
(:: import schema at "../Schemas/bfemEECCHistorico.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetCreditCardStatementExtractTypes.xsd" ::)

declare namespace bf. = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";

declare variable $getCreditCardStatementExtract as element() (:: schema-element(ns1:getCreditCardStatementExtract) ::) external;
declare variable $generateAccountStatement as xs:string external;
declare variable $codeCountry as xs:string external;
declare variable $productTypeValue as xs:string external;

declare function local:funcGetCreditCardStatementExtractToProcesosHNHeader($getCreditCardStatementExtract as element() (:: schema-element(ns1:getCreditCardStatementExtract) ::), 
                                                                           $generateAccountStatement as xs:string, 
                                                                           $codeCountry as xs:string, 
                                                                           $productTypeValue as xs:string) 
                                                                           as element() (:: schema-element(ns2:ObtenerEncabezadosV2) ::) {
    <ns2:ObtenerEncabezadosV2>
        <ns2:data>
            <bf.:Pais>{fn:data($codeCountry)}</bf.:Pais>
            <bf.:PeriodoFinal>{fn:concat(data($getCreditCardStatementExtract/Year),data($getCreditCardStatementExtract/Month))}</bf.:PeriodoFinal>
            <bf.:PeriodoInicial>{fn:concat(data($getCreditCardStatementExtract/Year),data($getCreditCardStatementExtract/Month))}</bf.:PeriodoInicial>
            <bf.:ProductoNumero>{data($getCreditCardStatementExtract/ProductValue)}</bf.:ProductoNumero>
            <bf.:ProductoTipo>{data($productTypeValue)}</bf.:ProductoTipo>
        </ns2:data>
    </ns2:ObtenerEncabezadosV2>
};

local:funcGetCreditCardStatementExtractToProcesosHNHeader($getCreditCardStatementExtract, $generateAccountStatement, $codeCountry, $productTypeValue)
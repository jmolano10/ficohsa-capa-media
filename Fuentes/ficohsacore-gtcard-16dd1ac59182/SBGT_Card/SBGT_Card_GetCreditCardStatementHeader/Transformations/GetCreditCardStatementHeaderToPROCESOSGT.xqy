xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://tempuri.org/";
(:: import schema at "../Schemas/bfemEECCHistorico.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetCreditCardStatementHeader.xsd" ::)

declare namespace bf="http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";

declare variable $country as xs:string external;
declare variable $GetCreditCardStatementHeader as element() (:: schema-element(ns1:getCreditCardStatementHeader) ::) external;

declare function local:funcGetCreditCardStatementHeaderToPROCESOSGT($country as xs:string, 
                                                          $GetCreditCardStatementHeader as element() (:: schema-element(ns1:getCreditCardStatementHeader) ::)) 
                                                          as element() (:: schema-element(ns2:ObtenerEncabezadosV2) ::) {
    <ns2:ObtenerEncabezadosV2>
        <ns2:data>
            <bf:Pais>{$country}</bf:Pais>
            <bf:PeriodoFinal>{fn:data($GetCreditCardStatementHeader/FinalDate)}</bf:PeriodoFinal>
            <bf:PeriodoInicial>{fn:data($GetCreditCardStatementHeader/InitialDate)}</bf:PeriodoInicial>
            <bf:ProductoNumero>{fn:data($GetCreditCardStatementHeader/ProductValue)}</bf:ProductoNumero>
            <bf:ProductoTipo>{fn:data($GetCreditCardStatementHeader/ProductType)}</bf:ProductoTipo>
        </ns2:data>
    </ns2:ObtenerEncabezadosV2>
};

local:funcGetCreditCardStatementHeaderToPROCESOSGT($country, $GetCreditCardStatementHeader)
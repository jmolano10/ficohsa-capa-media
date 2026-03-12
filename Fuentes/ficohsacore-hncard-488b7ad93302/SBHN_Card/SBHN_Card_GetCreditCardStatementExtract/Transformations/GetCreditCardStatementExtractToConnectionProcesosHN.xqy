xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetCreditCardStatementExtractTypes.xsd" ::)
declare namespace ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConnectionProcesosHN";
(:: import schema at "../Schemas/ConnectionProcesosHN_sp.xsd" ::)

declare variable $getCreditCardStatementExtract as element() (:: schema-element(ns1:getCreditCardStatementExtract) ::) external;
declare variable $codeCountry as xs:string external;

declare function local:funcGetCreditCardStatementExtractToConnectionProcesosHN($getCreditCardStatementExtract as element() (:: schema-element(ns1:getCreditCardStatementExtract) ::), 
                                                                               $codeCountry as xs:string) 
                                                                               as element() (:: schema-element(ns0:InputParameters) ::) {
    <ns0:InputParameters>
       <ns0:Pais>{fn:data($codeCountry)}</ns0:Pais>
        <ns0:NumCard>{fn:data($getCreditCardStatementExtract/ProductValue)}</ns0:NumCard>
        <ns0:Mes>{fn:data($getCreditCardStatementExtract/Month)}</ns0:Mes>
        <ns0:Anio>{(data($getCreditCardStatementExtract/Year))}</ns0:Anio>
    </ns0:InputParameters>
};

local:funcGetCreditCardStatementExtractToConnectionProcesosHN($getCreditCardStatementExtract, $codeCountry)
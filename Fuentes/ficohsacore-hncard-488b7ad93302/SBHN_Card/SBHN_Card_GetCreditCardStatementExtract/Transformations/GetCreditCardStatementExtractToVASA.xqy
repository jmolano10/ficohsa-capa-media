xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://tempuri.org/";
(:: import schema at "../Resources/ConsultarReportes_1.wsdl" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetCreditCardStatementExtractTypes.xsd" ::)

declare variable $getCreditCardStatementExtract as element() (:: schema-element(ns1:getCreditCardStatementExtract) ::) external;
declare variable $countryCode as xs:string external;

declare function local:funcGetCreditCardStatementExtractToVASA($getCreditCardStatementExtract as element() (:: schema-element(ns1:getCreditCardStatementExtract) ::), 
                                                               $countryCode as xs:string) 
                                                               as element() (:: schema-element(ns2:ObtenerSerializado) ::) {
    <ns2:ObtenerSerializado>
        <ns2:data>
            <ns2:Extension>{fn:data($getCreditCardStatementExtract/FileExtension)}</ns2:Extension>
            <ns2:Pais>{fn:data($countryCode)}</ns2:Pais>
            <ns2:Periodo>{fn:concat(data($getCreditCardStatementExtract/Year),data($getCreditCardStatementExtract/Month))}</ns2:Periodo>
            <ns2:ProductoNumero>{fn:data($getCreditCardStatementExtract/ProductValue)}</ns2:ProductoNumero>
            <ns2:ProductoTipo>{fn:data($getCreditCardStatementExtract/ProductType)}</ns2:ProductoTipo>
        </ns2:data>
    </ns2:ObtenerSerializado>
};

local:funcGetCreditCardStatementExtractToVASA($getCreditCardStatementExtract, $countryCode)
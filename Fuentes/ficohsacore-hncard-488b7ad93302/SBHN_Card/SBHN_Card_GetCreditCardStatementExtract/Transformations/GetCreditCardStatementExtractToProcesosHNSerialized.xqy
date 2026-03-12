xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://tempuri.org/";
(:: import schema at "../Schemas/bfemEECCHistorico.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/GetCreditCardStatementExtractTypes.xsd" ::)
declare namespace bf. = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";


declare variable $getCreditCardStatementExtract as element() (:: schema-element(ns1:getCreditCardStatementExtract) ::) external;
declare variable $codeCountry as xs:string external;

declare function local:funcGetCreditCardStatementExtractToProcesosHNSerialized($getCreditCardStatementExtract as element() (:: schema-element(ns1:getCreditCardStatementExtract) ::), 
                                                                               $codeCountry as xs:string) 
                                                                               as element() (:: schema-element(ns2:ObtenerSerializado) ::) {
      <ns2:ObtenerSerializado>
        <ns2:data>
            <bf.:Extension>{fn:data($getCreditCardStatementExtract/FileExtension)}</bf.:Extension>
            <bf.:Pais>{fn:data($codeCountry)}</bf.:Pais>
            <bf.:Periodo>{fn:concat(data($getCreditCardStatementExtract/Year),data($getCreditCardStatementExtract/Month))}</bf.:Periodo>
            <bf.:ProductoNumero>{fn:data($getCreditCardStatementExtract/ProductValue)}</bf.:ProductoNumero>
            <bf.:ProductoTipo>{fn:data($getCreditCardStatementExtract/ProductType)}</bf.:ProductoTipo>
        </ns2:data>
    </ns2:ObtenerSerializado>
};

local:funcGetCreditCardStatementExtractToProcesosHNSerialized($getCreditCardStatementExtract, $codeCountry)
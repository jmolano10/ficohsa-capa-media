xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCreditCardData";
(:: import schema at "../../../../../ProviderServices/XSD/GetCreditCardData/GetCreditCardData_sp.xsd" ::)

declare variable $card as xs:string external;
declare variable $codigoPais as xs:string external;
declare variable $org as xs:string external;

declare function local:func($card as xs:string, 
                            $codigoPais as xs:string,
                            $org as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:Pais>{fn:data($codigoPais)}</ns1:Pais>
        {
          if(fn:data($org)!= '')then(
            <ns1:Org>{fn:data($org)}</ns1:Org>
          )else()
        }
        <ns1:NumTarjeta>{fn:data($card)}</ns1:NumTarjeta>
    </ns1:InputParameters>
};

local:func($card, $codigoPais, $org)
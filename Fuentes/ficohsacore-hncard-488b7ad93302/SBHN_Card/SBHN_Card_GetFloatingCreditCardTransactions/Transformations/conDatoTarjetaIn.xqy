xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
(:: import schema at "../Schemas/conDatoTarjeta_sp.xsd" ::)

declare variable $cardNumber as xs:string external;
declare variable $org as xs:string external;
declare variable $codigoPais as xs:string external;

declare function local:func($cardNumber as xs:string, 
                            $org as xs:string, 
                            $codigoPais as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
                            
     <ns1:InputParameters>
          <ns1:Pais>{ $codigoPais }</ns1:Pais>
          {
              if($org != "") then (
              <ns1:Org>{ $org }</ns1:Org>
              )else()
          }
          <ns1:NumTarjeta>{ $cardNumber }</ns1:NumTarjeta>
      </ns1:InputParameters>
};

local:func($cardNumber, $org, $codigoPais)
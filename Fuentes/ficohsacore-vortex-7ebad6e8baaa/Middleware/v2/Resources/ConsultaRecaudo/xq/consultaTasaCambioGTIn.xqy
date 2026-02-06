xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaTasaCambio/xsd/ConsultaTasaCambio_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaTasaCambio";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/consultaTasaCambioGTIn/";

declare function xf:consultaTasaCambioGTIn($from_currency as xs:string,
    $to_currency as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:FROM_CURRENCY>{ $from_currency }</ns0:FROM_CURRENCY>
            <ns0:TO_CURRENCY>{ $to_currency }</ns0:TO_CURRENCY>
        </ns0:InputParameters>
};

declare variable $from_currency as xs:string external;
declare variable $to_currency as xs:string external;

xf:consultaTasaCambioGTIn($from_currency,
    $to_currency)
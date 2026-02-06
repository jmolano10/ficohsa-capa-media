xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ConsultaTarjetaCreditoReciente/xsd/OSBCONTarjetaMasReciente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaTarjetaCreditoReciente";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/OSBCONTarjetaMasReciente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTarjetaCreditoReciente/xq/Tx_ConsultaTarjetaCreditoReciente_To_OSBCONTarjetaMasReciente/";

declare function xf:Tx_ConsultaTarjetaCreditoReciente_To_OSBCONTarjetaMasReciente($numCuenta as xs:string,
    $pais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:NumCuenta>{$numCuenta}</ns1:NumCuenta>
            <ns1:Pais>{ $pais }</ns1:Pais>
        </ns1:InputParameters>
};


declare variable $pais as xs:string external;
declare variable $numCuenta as xs:string external;

xf:Tx_ConsultaTarjetaCreditoReciente_To_OSBCONTarjetaMasReciente($numCuenta,
    $pais)
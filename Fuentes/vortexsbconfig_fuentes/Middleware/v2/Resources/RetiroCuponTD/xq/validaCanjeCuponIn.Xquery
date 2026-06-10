<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$retiroCuponTD" element="ns0:retiroCuponTD" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/OperacionesTarjetaDebito/ValidaCanjeCupon_db/xsd/validaCanjeCupon_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaCanjeCupon";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroCuponTD/xq/validaCanjeCuponIn/";

declare function xf:validaCanjeCuponIn($retiroCuponTD as element(ns0:retiroCuponTD),
    $user as xs:string,
    $pais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_OPERACION>{ data($retiroCuponTD/OPERATION) }</ns1:PV_OPERACION>
            <ns1:PN_MONTO>{ data($retiroCuponTD/TICKET_AMOUNT) }</ns1:PN_MONTO>
            <ns1:PV_MONEDA>{ data($retiroCuponTD/TICKET_CURRENCY) }</ns1:PV_MONEDA>
            <ns1:PV_USUARIO>{ $user }</ns1:PV_USUARIO>
            <ns1:PV_PAIS>{ $pais }</ns1:PV_PAIS>
            <ns1:PV_TICKET>{ data($retiroCuponTD/TICKET_NUMBER) }</ns1:PV_TICKET>
        </ns1:InputParameters>
};

declare variable $retiroCuponTD as element(ns0:retiroCuponTD) external;
declare variable $user as xs:string external;
declare variable $pais as xs:string external;

xf:validaCanjeCuponIn($retiroCuponTD,
    $user,
    $pais)]]></con:xquery>
    <con:dependency location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/OperacionesTarjetaDebito/ValidaCanjeCupon_db/xsd/validaCanjeCupon_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/OperacionesTarjetaDebito/ValidaCanjeCupon_db/xsd/validaCanjeCupon_sp"/>
    </con:dependency>
</con:xqueryEntry>
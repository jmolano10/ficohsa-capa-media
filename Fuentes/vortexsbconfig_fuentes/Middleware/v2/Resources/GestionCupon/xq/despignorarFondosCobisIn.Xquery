<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$gestionCupon" element="ns1:gestionCupon" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Cobis/RetiroSinTD/DespignoracionSaldo/xsd/DespignoracionSaldo_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/DespignoracionSaldo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionCupon/xq/despignorarFondosCobisIn/";

declare function xf:despignorarFondosCobisIn($gestionCupon as element(ns1:gestionCupon),
    $isCancel as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:i_DEBIT_ACCOUNT>{ data($gestionCupon/ACCOUNT_NUMBER) }</ns0:i_DEBIT_ACCOUNT>
            <ns0:i_AMOUNT>{ data($gestionCupon/AMOUNT) }</ns0:i_AMOUNT>
            <ns0:i_CURRENCY>{ data($gestionCupon/CURRENCY) }</ns0:i_CURRENCY>
            <ns0:i_CUPON>{ data($gestionCupon/TICKET_NUMBER) }</ns0:i_CUPON>
            <ns0:i_ONLYRELEASE>{ $isCancel }</ns0:i_ONLYRELEASE>
        </ns0:InputParameters>
};

declare variable $gestionCupon as element(ns1:gestionCupon) external;
declare variable $isCancel as xs:string external;

xf:despignorarFondosCobisIn($gestionCupon,
    $isCancel)]]></con:xquery>
    <con:dependency location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/Cobis/RetiroSinTD/DespignoracionSaldo/xsd/DespignoracionSaldo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/Cobis/RetiroSinTD/DespignoracionSaldo/xsd/DespignoracionSaldo_sp"/>
    </con:dependency>
</con:xqueryEntry>
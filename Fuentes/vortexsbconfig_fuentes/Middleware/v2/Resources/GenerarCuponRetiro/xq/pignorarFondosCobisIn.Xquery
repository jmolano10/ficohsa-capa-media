<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$generarCuponRetiro" element="ns1:generarCuponRetiro" location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/Cobis/RetiroSinTD/PignoracionSaldo/xsd/PignoracionSaldo_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroSinTarjetaDebitoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PignoracionSaldo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GenerarCuponRetiro/xq/pignorarFondosCobisIn/";

declare function xf:pignorarFondosCobisIn($generarCuponRetiro as element(ns1:generarCuponRetiro),
    $cuponRetiro as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:i_DEBIT_ACCOUNT>{ data($generarCuponRetiro/ACCOUNT_NUMBER) }</ns0:i_DEBIT_ACCOUNT>
            <ns0:i_AMOUNT>{ data($generarCuponRetiro/AMOUNT) }</ns0:i_AMOUNT>
            <ns0:i_CURRENCY>{ data($generarCuponRetiro/CURRENCY) }</ns0:i_CURRENCY>
            <ns0:i_CUPON>{ $cuponRetiro }</ns0:i_CUPON>
        </ns0:InputParameters>
};

declare variable $generarCuponRetiro as element(ns1:generarCuponRetiro) external;
declare variable $cuponRetiro as xs:string external;

xf:pignorarFondosCobisIn($generarCuponRetiro,
    $cuponRetiro)]]></con:xquery>
    <con:dependency location="../../RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroSinTarjetaDebito/xsd/retiroSinTarjetaDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/Cobis/RetiroSinTD/PignoracionSaldo/xsd/PignoracionSaldo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/Cobis/RetiroSinTD/PignoracionSaldo/xsd/PignoracionSaldo_sp"/>
    </con:dependency>
</con:xqueryEntry>
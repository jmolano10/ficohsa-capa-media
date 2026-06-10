<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaMontoTipoChequera/xsd/ORA_BANK_OSB_CON_MONTO_X_CHEQUERA.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaMontoTipoChequeraResponse" location="../xsd/consultaMontoTipoChequeraTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTipoChequeraTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMontoTipoChequera";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ABANKSPA/ConsultaMontoTipoChequera/xsd/consultaMontoTipoChequeraOut/";

declare function xf:consultaMontoTipoChequeraOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaMontoTipoChequeraResponse) {
        <ns0:consultaMontoTipoChequeraResponse>
            <CHARGE_CURRENCY>{ data($outputParameters/ns1:CHARGE_CURRENCY) }</CHARGE_CURRENCY>
            <CHARGE_AMOUNT>{ data($outputParameters/ns1:CHARGE_AMOUNT) }</CHARGE_AMOUNT>
        </ns0:consultaMontoTipoChequeraResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaMontoTipoChequeraOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaMontoTipoChequera/xsd/ORA_BANK_OSB_CON_MONTO_X_CHEQUERA.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaMontoTipoChequera/xsd/ORA_BANK_OSB_CON_MONTO_X_CHEQUERA"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaMontoTipoChequeraTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaMontoTipoChequera/xsd/consultaMontoTipoChequeraTypes"/>
    </con:dependency>
</con:xqueryEntry>
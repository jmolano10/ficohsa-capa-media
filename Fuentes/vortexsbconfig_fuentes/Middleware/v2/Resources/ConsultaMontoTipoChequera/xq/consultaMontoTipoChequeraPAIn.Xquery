<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMontoTipoChequera" element="ns1:consultaMontoTipoChequera" location="../xsd/consultaMontoTipoChequeraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ABKPA/consultaMontoTipoChequera/xsd/ORA_BANK_OSB_CON_MONTO_X_CHEQUERA.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMontoTipoChequera";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMontoTipoChequeraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ABANKSPA/ConsultaMontoTipoChequera/xsd/consultaMontoTipoChequeraIn/";

declare function xf:consultaMontoTipoChequeraIn($consultaMontoTipoChequera as element(ns1:consultaMontoTipoChequera))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:ACCOUNT_NUMBER>{ data($consultaMontoTipoChequera/ACCOUNT_NUMBER) }</ns2:ACCOUNT_NUMBER>
            <ns2:CHECKBOOK_TYPE>{ data($consultaMontoTipoChequera/CHECKBOOK_TYPE) }</ns2:CHECKBOOK_TYPE>
        </ns2:InputParameters>
};

declare variable $consultaMontoTipoChequera as element(ns1:consultaMontoTipoChequera) external;

xf:consultaMontoTipoChequeraIn($consultaMontoTipoChequera)]]></con:xquery>
    <con:dependency location="../xsd/consultaMontoTipoChequeraTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaMontoTipoChequera/xsd/consultaMontoTipoChequeraTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaMontoTipoChequera/xsd/ORA_BANK_OSB_CON_MONTO_X_CHEQUERA.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaMontoTipoChequera/xsd/ORA_BANK_OSB_CON_MONTO_X_CHEQUERA"/>
    </con:dependency>
</con:xqueryEntry>
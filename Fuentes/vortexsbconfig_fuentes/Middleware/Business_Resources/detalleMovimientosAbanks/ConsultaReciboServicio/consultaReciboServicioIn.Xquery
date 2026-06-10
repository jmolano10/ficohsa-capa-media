<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/ConsultaReciboServicio/xsd/ORA_BANK_OSB_K_CONSULTARECIBOSERVICIO_TOPLEVEL-24OSB_CON_RECIBO_SERVI.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTARECIBOSERVICIO/TOPLEVEL-24OSB_CON_RECIBO_SERVI/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/detalleMovimientosAbanks/ConsultaReciboServicio/consultaReciboServicioIn/";

declare function xf:consultaReciboServicioIn($ACCOUNT as xs:string,
    $TRANSACTION_REFERENCE as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:ACCOUNT_NUMBER>{ $ACCOUNT }</ns0:ACCOUNT_NUMBER>
            <ns0:TRANSACTION_REFERENCE>{ $TRANSACTION_REFERENCE }</ns0:TRANSACTION_REFERENCE>
        </ns0:InputParameters>
};

declare variable $ACCOUNT as xs:string external;
declare variable $TRANSACTION_REFERENCE as xs:string external;

xf:consultaReciboServicioIn($ACCOUNT,
    $TRANSACTION_REFERENCE)]]></con:xquery>
    <con:dependency location="../Resources/ConsultaReciboServicio/xsd/ORA_BANK_OSB_K_CONSULTARECIBOSERVICIO_TOPLEVEL-24OSB_CON_RECIBO_SERVI.xsd">
        <con:schema ref="Middleware/Business_Resources/detalleMovimientosAbanks/Resources/ConsultaReciboServicio/xsd/ORA_BANK_OSB_K_CONSULTARECIBOSERVICIO_TOPLEVEL-24OSB_CON_RECIBO_SERVI"/>
    </con:dependency>
</con:xqueryEntry>
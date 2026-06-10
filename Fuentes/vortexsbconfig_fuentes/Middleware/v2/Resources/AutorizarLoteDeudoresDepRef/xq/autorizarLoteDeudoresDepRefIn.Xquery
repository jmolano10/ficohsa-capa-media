<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autorizacionLote" element="ns0:autorizacionLote" location="../../DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/autorizarLoteDeudoresDepRef/xsd/autorizarLoteDeudoresDepRef_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/autorizarLoteDeudoresDepRef";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositosReferenciadosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarLoteDeudoresDepRef/xq/autorizarLoteDeudoresDepRefIn/";

declare function xf:autorizarLoteDeudoresDepRefIn($autorizacionLote as element(ns0:autorizacionLote))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_AUTORIZADOR>{ data($autorizacionLote/USER_ID) }</ns1:PV_AUTORIZADOR>
            <ns1:PV_CODIGOCLIENTE>{ data($autorizacionLote/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
            <ns1:PV_NUMEROCUENTA>{ data($autorizacionLote/ACCOUNT_NUMBER) }</ns1:PV_NUMEROCUENTA>
            <ns1:PN_IDLOTE>{ data($autorizacionLote/BANK_BATCH_ID) }</ns1:PN_IDLOTE>
        </ns1:InputParameters>
};

declare variable $autorizacionLote as element(ns0:autorizacionLote) external;

xf:autorizarLoteDeudoresDepRefIn($autorizacionLote)]]></con:xquery>
    <con:dependency location="../../DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/DepositosReferenciados/xsd/depositosReferenciadosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABK/autorizarLoteDeudoresDepRef/xsd/autorizarLoteDeudoresDepRef_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/autorizarLoteDeudoresDepRef/xsd/autorizarLoteDeudoresDepRef_sp"/>
    </con:dependency>
</con:xqueryEntry>
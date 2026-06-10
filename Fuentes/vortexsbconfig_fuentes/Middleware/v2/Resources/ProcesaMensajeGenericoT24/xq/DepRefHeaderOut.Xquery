<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ITB/validarDepositoRef/xsd/validarDepositoRef_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarDepositoRef";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/DepRefHeaderOut/";

declare function xf:DepRefHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $PV_CODMSJ in $outputParameters1/ns0:PV_CODMSJ
                return
                    <successIndicator>{ data($PV_CODMSJ) }</successIndicator>
            }
            {
				if (fn:string($outputParameters1/ns0:PV_CODMSJ/text()) != "SUCCESS") then (
                    <messages>{ fn:concat("1|",$outputParameters1/ns0:PV_MENSAJE/text()) }</messages>
                ) else ()
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:DepRefHeaderOut($outputParameters1)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ITB/validarDepositoRef/xsd/validarDepositoRef_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ITB/validarDepositoRef/xsd/validarDepositoRef_sp"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
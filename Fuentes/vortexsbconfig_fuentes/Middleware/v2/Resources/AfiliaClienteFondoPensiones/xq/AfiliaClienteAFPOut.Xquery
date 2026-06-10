<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKHN/FondoPensiones/AfiliaClienteAFP/xsd/AfiliaClienteAFP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/AfiliaClienteAFP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AfiliaClienteFondoPensiones/xq/AfiliaClienteAFPOutHeader/";

declare function xf:AfiliaClienteAFPOutHeader($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $PV_SUCCESSINDICATOR in $outputParameters/ns0:PV_SUCCESSINDICATOR
                return
                    <successIndicator>{ data($PV_SUCCESSINDICATOR) }</successIndicator>
            }
            {
                for $PV_MESSAGES in $outputParameters/ns0:PV_MESSAGES
                return
                    <messages>{ data($PV_MESSAGES) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:AfiliaClienteAFPOutHeader($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKHN/FondoPensiones/AfiliaClienteAFP/xsd/AfiliaClienteAFP_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKHN/FondoPensiones/AfiliaClienteAFP/xsd/AfiliaClienteAFP_sp"/>
    </con:dependency>
    <con:dependency location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
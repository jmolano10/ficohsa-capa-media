<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/consultaReciboDUA/xsd/ConsultaReciboDua_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaReciboDua";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaReciboDEI/xq/consultaReciboDEI_DuaHeaderOut/";

declare function xf:consultaReciboDEI_DuaHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $P_SUCCESS_INDICATOR in string($outputParameters/ns1:P_SUCCESS_INDICATOR/text())
                return
                if(upper-case($P_SUCCESS_INDICATOR) = "SUCCESS") then(
                	<successIndicator>Success</successIndicator>
                )else(
                	<successIndicator>{ $P_SUCCESS_INDICATOR }</successIndicator>,
                	<messages>{ data($outputParameters/ns1:P_MENSAJE_ERROR) }</messages>
                )
                    
            }
            
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaReciboDEI_DuaHeaderOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/DEI/consultaReciboDUA/xsd/ConsultaReciboDua_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DEI/consultaReciboDUA/xsd/ConsultaReciboDua_sp"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/PMSV/consultaTransaccionLote/xsd/consultaTransaccionLote_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTransaccionLote";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionLote/xq/consultaTransaccionLoteHeaderOut/";

declare function xf:consultaTransaccionLoteHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <successIndicator>
            	{
                    if (data($outputParameters/ns0:ERROR_CODE) = "SUCCESS") then
                        ("Success")
                    else 
                        data($outputParameters/ns0:ERROR_CODE)
                }
			</successIndicator>
            {
                for $ERROR_MESSAGE in $outputParameters/ns0:ERROR_MESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaTransaccionLoteHeaderOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/PMSV/consultaTransaccionLote/xsd/consultaTransaccionLote_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/PMSV/consultaTransaccionLote/xsd/consultaTransaccionLote_sp"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DEBITCARD/generaLotes/xsd/generaLotes_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:generaLotesTarjetasResponse" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/generaLotes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraLotesTarjetas/xq/generaLotesTarjetasOut/";

declare function xf:generaLotesTarjetasOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:generaLotesTarjetasResponse) {
        <ns1:generaLotesTarjetasResponse>
            {
                for $PV_BATCH_REFERENCE in $outputParameters/ns0:PV_BATCH_REFERENCE
                return
                    <BATCH_REFERENCE>{ data($PV_BATCH_REFERENCE) }</BATCH_REFERENCE>
            }
            <BATCH_DATE>{ data($outputParameters/ns0:PV_BATCH_DATE) }</BATCH_DATE>
        </ns1:generaLotesTarjetasResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:generaLotesTarjetasOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/DEBITCARD/generaLotes/xsd/generaLotes_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/DEBITCARD/generaLotes/xsd/generaLotes_sp"/>
    </con:dependency>
    <con:dependency location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes"/>
    </con:dependency>
</con:xqueryEntry>
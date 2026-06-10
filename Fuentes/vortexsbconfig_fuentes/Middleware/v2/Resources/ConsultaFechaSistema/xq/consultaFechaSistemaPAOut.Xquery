<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/consultaFechaSistema/xsd/consultaFechaSistema_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFechaSistemaResponse" location="../../../../Business_Resources/Core/consultaFechaSistema/consultaFechaSistemaTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFechaSistema";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFechaSistemaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFechaSistema/xq/consultaFechaSistemaPAOut/";

declare function xf:consultaFechaSistemaPAOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaFechaSistemaResponse) {
        <ns1:consultaFechaSistemaResponse>
            <ns1:consultaFechaSistemaResponseType>
                <ns1:consultaFechaSistemaResponseRecordType>
                    {
                        for $PV_WORKING_DATE in $outputParameters/ns0:PV_WORKING_DATE
                        return
                            <WORKING_DATE>{ data($PV_WORKING_DATE) }</WORKING_DATE>
                    }
                    {
                        for $PV_JULIAN_DATE in $outputParameters/ns0:PV_JULIAN_DATE
                        return
                            <JULIAN_DATE>{ data($PV_JULIAN_DATE) }</JULIAN_DATE>
                    }
                    {
                        for $PV_NEXT_WORKING_DATE in $outputParameters/ns0:PV_NEXT_WORKING_DATE
                        return
                            <NEXT_WORKING_DATE>{ data($PV_NEXT_WORKING_DATE) }</NEXT_WORKING_DATE>
                    }
                </ns1:consultaFechaSistemaResponseRecordType>
            </ns1:consultaFechaSistemaResponseType>
        </ns1:consultaFechaSistemaResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaFechaSistemaPAOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaFechaSistema/xsd/consultaFechaSistema_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaFechaSistema/xsd/consultaFechaSistema_sp"/>
    </con:dependency>
    <con:dependency location="../../../../Business_Resources/Core/consultaFechaSistema/consultaFechaSistemaTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/consultaFechaSistema/consultaFechaSistemaTypes"/>
    </con:dependency>
</con:xqueryEntry>
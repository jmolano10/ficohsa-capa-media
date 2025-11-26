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

xf:consultaFechaSistemaPAOut($outputParameters)
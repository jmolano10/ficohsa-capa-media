(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/listadoEntes/xsd/listadoEntesFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaFinancierasACHResponse" location="../../../../Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoEntesFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinancierasACH/xq/ConsultaFinancierasACH_FPCHNOut/";

declare function xf:ConsultaFinancierasACH_FPCHNOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaFinancierasACHResponse) {
        <ns0:consultaFinancierasACHResponse>
            <ns0:consultaFinancierasACHResponseType>
                {
                    for $T_ENTES_ITEM in $outputParameters1/ns1:T_ENTES/ns1:T_ENTES_ITEM
                    return
                        <ns0:consultaFinancierasACHResponseRecordType>
                            {
                                for $COD_ENTE in $T_ENTES_ITEM/ns1:COD_ENTE
                                return
                                    <DESTINATION_CODE>{ data($COD_ENTE) }</DESTINATION_CODE>
                            }
                            {
                                for $DES_ENTE in $T_ENTES_ITEM/ns1:DES_ENTE
                                return
                                    <DESTINATION_NAME>{ data($DES_ENTE) }</DESTINATION_NAME>
                            }
                        </ns0:consultaFinancierasACHResponseRecordType>
                }
            </ns0:consultaFinancierasACHResponseType>
        </ns0:consultaFinancierasACHResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:ConsultaFinancierasACH_FPCHNOut($outputParameters1)
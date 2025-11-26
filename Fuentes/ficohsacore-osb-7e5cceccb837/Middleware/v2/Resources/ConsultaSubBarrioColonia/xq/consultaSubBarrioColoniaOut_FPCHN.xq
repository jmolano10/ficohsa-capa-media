(:: pragma bea:global-element-parameter parameter="$consultaSubBarrioColonia1" element="ns0:consultaSubBarrioColonia" location="../xsd/consultaSubBarrioColoniaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/listadoColoniasCaserios/xsd/listadoColoniasCaseriosFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSubBarrioColoniaResponse" location="../xsd/consultaSubBarrioColoniaTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoColoniasCaseriosFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSubBarrioColoniaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSubBarrioColonia/xq/consultaSubBarrioColoniaOut_FPCHN/";

declare function xf:consultaSubBarrioColoniaOut_FPCHN($consultaSubBarrioColonia1 as element(ns0:consultaSubBarrioColonia),
    $outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaSubBarrioColoniaResponse) {
        <ns0:consultaSubBarrioColoniaResponse>
            <ns0:consultaSubBarrioColoniaResponseType>
                {
                    for $PT_PUEBLOS_ITEM in $outputParameters1/ns1:PT_PUEBLOS/ns1:PT_PUEBLOS_ITEM
                    return
                        <ns0:consultaSubBarrioColoniaResponseRecordType>
                            {
                                for $COD_PUEBLO in $PT_PUEBLOS_ITEM/ns1:COD_PUEBLO
                                return
                                    <SUB_DISTRICT_CODE>{ data($COD_PUEBLO) }</SUB_DISTRICT_CODE>
                            }
                            {
                                for $DES_PUEBLO in $PT_PUEBLOS_ITEM/ns1:DES_PUEBLO
                                return
                                    <SUB_DISTRICT_NAME>{ data($DES_PUEBLO) }</SUB_DISTRICT_NAME>
                            }
                            <DISTRICT_CODE>{ data($consultaSubBarrioColonia1/DISTRICT_CODE) }</DISTRICT_CODE>
                            <CITY_CODE>{ data($consultaSubBarrioColonia1/CITY_CODE) }</CITY_CODE>
                            <DEPT_CODE>{ data($consultaSubBarrioColonia1/DEPT_CODE) }</DEPT_CODE>
                            <COUNTRY_CODE>{ data($consultaSubBarrioColonia1/COUNTRY_CODE) }</COUNTRY_CODE>
                        </ns0:consultaSubBarrioColoniaResponseRecordType>
                }
            </ns0:consultaSubBarrioColoniaResponseType>
        </ns0:consultaSubBarrioColoniaResponse>
};

declare variable $consultaSubBarrioColonia1 as element(ns0:consultaSubBarrioColonia) external;
declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaSubBarrioColoniaOut_FPCHN($consultaSubBarrioColonia1,
    $outputParameters1)
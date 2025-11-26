(:: pragma bea:global-element-parameter parameter="$consultaBarrioColonia1" element="ns0:consultaBarrioColonia" location="../../../../Business_Resources/direcciones/ConsultaBarrioColonia/consultaBarrioColoniaTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/listadoCiudadesAldeas/xsd/listadoCiudadesAldeasFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaBarrioColoniaResponse" location="../../../../Business_Resources/direcciones/ConsultaBarrioColonia/consultaBarrioColoniaTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoCiudadesAldeasFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaBarrioColoniaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBarrioColonia/xq/consultaBarrioColoniaOut_FPCHN/";

declare function xf:consultaBarrioColoniaOut_FPCHN($consultaBarrioColonia1 as element(ns0:consultaBarrioColonia),
    $outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaBarrioColoniaResponse) {
        <ns0:consultaBarrioColoniaResponse>
            <ns0:consultaBarrioColoniaResponseType>
                {
                    for $PT_DISTRITOS_ITEM in $outputParameters1/ns1:PT_DISTRITOS/ns1:PT_DISTRITOS_ITEM
                    return
                        <ns0:consultaBarrioColoniaResponseRecordType>
                            {
                                for $COD_DISTRITO in $PT_DISTRITOS_ITEM/ns1:COD_DISTRITO
                                return
                                    <DISTRICT_CODE>{ data($COD_DISTRITO) }</DISTRICT_CODE>
                            }
                            {
                                for $DES_DISTRITO in $PT_DISTRITOS_ITEM/ns1:DES_DISTRITO
                                return
                                    <DISTRICT_NAME>{ data($DES_DISTRITO) }</DISTRICT_NAME>
                            }
                            <CITY_CODE>{ data($consultaBarrioColonia1/CITY_CODE) }</CITY_CODE>
                            <DEPT_CODE>{ data($consultaBarrioColonia1/DEPT_CODE) }</DEPT_CODE>
                            <COUNTRY_CODE>{ data($consultaBarrioColonia1/COUNTRY_CODE) }</COUNTRY_CODE>
                        </ns0:consultaBarrioColoniaResponseRecordType>
                }
            </ns0:consultaBarrioColoniaResponseType>
        </ns0:consultaBarrioColoniaResponse>
};

declare variable $consultaBarrioColonia1 as element(ns0:consultaBarrioColonia) external;
declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaBarrioColoniaOut_FPCHN($consultaBarrioColonia1,
    $outputParameters1)
(:: pragma bea:global-element-parameter parameter="$consultaSubBarrioColonia1" element="ns0:consultaSubBarrioColonia" location="../xsd/consultaSubBarrioColoniaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/FPC/listadoColoniasCaserios/xsd/listadoColoniasCaseriosFPC_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoColoniasCaseriosFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSubBarrioColoniaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSubBarrioColonia/xq/consultaSubBarrioColoniaIn_FPCHN/";

declare function xf:consultaSubBarrioColoniaIn_FPCHN($consultaSubBarrioColonia1 as element(ns0:consultaSubBarrioColonia))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PC_COD_PAIS>{ data($consultaSubBarrioColonia1/COUNTRY_CODE) }</ns1:PC_COD_PAIS>
            <ns1:PC_COD_PROVINCIA>{ data($consultaSubBarrioColonia1/DEPT_CODE) }</ns1:PC_COD_PROVINCIA>
            <ns1:PC_COD_CANTON>{ data($consultaSubBarrioColonia1/CITY_CODE) }</ns1:PC_COD_CANTON>
            {
                for $DISTRICT_CODE in $consultaSubBarrioColonia1/DISTRICT_CODE
                return
                    <ns1:PC_COD_DISTRITO>{ data($DISTRICT_CODE) }</ns1:PC_COD_DISTRITO>
            }
        </ns1:InputParameters>
};

declare variable $consultaSubBarrioColonia1 as element(ns0:consultaSubBarrioColonia) external;

xf:consultaSubBarrioColoniaIn_FPCHN($consultaSubBarrioColonia1)
(:: pragma bea:global-element-parameter parameter="$consultaBarrioColonia1" element="ns0:consultaBarrioColonia" location="../../../../Business_Resources/direcciones/ConsultaBarrioColonia/consultaBarrioColoniaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/FPC/listadoCiudadesAldeas/xsd/listadoCiudadesAldeasFPC_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoCiudadesAldeasFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaBarrioColoniaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBarrioColonia/xq/consultaBarrioColoniaIn_FPCHN/";

declare function xf:consultaBarrioColoniaIn_FPCHN($consultaBarrioColonia1 as element(ns0:consultaBarrioColonia))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PC_COD_PAIS>{ data($consultaBarrioColonia1/COUNTRY_CODE) }</ns1:PC_COD_PAIS>
            <ns1:PC_COD_PROVINCIA>{ data($consultaBarrioColonia1/DEPT_CODE) }</ns1:PC_COD_PROVINCIA>
            <ns1:PC_COD_CANTON>{ data($consultaBarrioColonia1/CITY_CODE) }</ns1:PC_COD_CANTON>
        </ns1:InputParameters>
};

declare variable $consultaBarrioColonia1 as element(ns0:consultaBarrioColonia) external;

xf:consultaBarrioColoniaIn_FPCHN($consultaBarrioColonia1)
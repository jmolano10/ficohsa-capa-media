(:: pragma bea:global-element-parameter parameter="$consultaMunicipios" element="ns1:consultaMunicipios" location="../../../../Business_Resources/direcciones/ConsultaMunicipios/consultaMunicipiosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/FPC/listadoMunicipios/xsd/listadoMunicipiosFPC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMunicipiosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoMunicipiosFPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMunicipios/xq/consultaMunicipiosFPCIn/";

declare function xf:consultaMunicipiosFPCIn($consultaMunicipios as element(ns1:consultaMunicipios))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PC_COD_PAIS>{ data($consultaMunicipios/COUNTRY_CODE) }</ns0:PC_COD_PAIS>
            {
                for $DEPT_CODE in $consultaMunicipios/DEPT_CODE
                return
                    <ns0:PC_COD_PROVINCIA>{ data($DEPT_CODE) }</ns0:PC_COD_PROVINCIA>
            }
        </ns0:InputParameters>
};

declare variable $consultaMunicipios as element(ns1:consultaMunicipios) external;

xf:consultaMunicipiosFPCIn($consultaMunicipios)
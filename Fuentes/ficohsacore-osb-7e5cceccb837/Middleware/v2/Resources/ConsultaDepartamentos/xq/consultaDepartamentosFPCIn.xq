(:: pragma bea:global-element-parameter parameter="$consultaDepartamentos" element="ns0:consultaDepartamentos" location="../../../../Business_Resources/direcciones/ConsultaDepartamentos/consultaDepartamentosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/FPC/listadoDepartamentos/xsd/listadoDepartamentosFPC_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoDepartamentosFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDepartamentosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDepartamentos/xq/consultaDepartamentosFPCIn/";

declare function xf:consultaDepartamentosFPCIn($consultaDepartamentos as element(ns0:consultaDepartamentos))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PC_COD_PAIS>{ data($consultaDepartamentos/COUNTRY_CODE) }</ns1:PC_COD_PAIS>
        </ns1:InputParameters>
};

declare variable $consultaDepartamentos as element(ns0:consultaDepartamentos) external;

xf:consultaDepartamentosFPCIn($consultaDepartamentos)
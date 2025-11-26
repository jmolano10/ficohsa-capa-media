(:: pragma bea:global-element-parameter parameter="$consultaClientePorNombre" element="ns1:consultaClientePorNombre" location="../xsd/consultaClientePorNombreTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ConsultaClientePorNombre/xsd/ConsultaClientePorNombre_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaClientePorNombre";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientePorNombreTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClientePorNombre/xq/consultaClientePorNombreIn/";

declare function xf:consultaClientePorNombreIn($consultaClientePorNombre as element(ns1:consultaClientePorNombre))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NOMBRE>{ data($consultaClientePorNombre/NAME) }</ns0:PV_NOMBRE>
            <ns0:PV_PAGINAR>{ data($consultaClientePorNombre/PAGING_INFO/PAGING) }</ns0:PV_PAGINAR>
            <ns0:PI_INICIO_PAGINAR>{ data($consultaClientePorNombre/PAGING_INFO/INITIAL_RECORD) }</ns0:PI_INICIO_PAGINAR>
            <ns0:PI_NUMERO_REGISTROS>{ data($consultaClientePorNombre/PAGING_INFO/RECORD_COUNT) }</ns0:PI_NUMERO_REGISTROS>
        </ns0:InputParameters>
};

declare variable $consultaClientePorNombre as element(ns1:consultaClientePorNombre) external;

xf:consultaClientePorNombreIn($consultaClientePorNombre)
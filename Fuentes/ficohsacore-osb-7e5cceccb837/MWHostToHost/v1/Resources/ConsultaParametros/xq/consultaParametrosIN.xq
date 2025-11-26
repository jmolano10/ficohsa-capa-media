(:: pragma bea:global-element-parameter parameter="$consultaParametrosRequest" element="ns0:consultaParametrosRequest" location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PWS/consultaParametros/xsd/consultaParametros_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaParametros";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ActualizaParametros/xq/actualizaParametrosIN/";

declare function xf:consultaParametrosIN($consultaParametrosRequest as element(ns0:consultaParametrosRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGOCLIENTE>{ data($consultaParametrosRequest/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
        </ns1:InputParameters>
};

declare variable $consultaParametrosRequest as element(ns0:consultaParametrosRequest) external;

xf:consultaParametrosIN($consultaParametrosRequest)

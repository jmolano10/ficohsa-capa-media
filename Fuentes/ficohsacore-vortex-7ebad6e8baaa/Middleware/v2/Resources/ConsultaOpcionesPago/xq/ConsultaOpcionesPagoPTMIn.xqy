xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaOpcionesPagoRequest1" element="ns0:consultaOpcionesPagoRequest" location="../../ConsultasCarteraCrediticia/xsd/consultasCarteraCrediticiaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ProcesosHN/conOpcionesPagoPTM/xsd/ConsultaOpcionesPagoPTM_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaOpcionesPagoPTM";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConsultasCarteraCrediticia";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOpcionesPago/xq/ConsultaOpcionesPagoPTMIn/";

declare function xf:ConsultaOpcionesPagoPTMIn($pais as xs:string,
    $consultaOpcionesPagoRequest1 as element(ns0:consultaOpcionesPagoRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_NUMERO_PRODUCTO>{ data($consultaOpcionesPagoRequest1/PRODUCT/PRODUCT_VALUE) }</ns1:P_NUMERO_PRODUCTO>
            <ns1:P_PAIS>{ $pais }</ns1:P_PAIS>
        </ns1:InputParameters>
};

declare variable $pais as xs:string external;
declare variable $consultaOpcionesPagoRequest1 as element(ns0:consultaOpcionesPagoRequest) external;

xf:ConsultaOpcionesPagoPTMIn($pais,
    $consultaOpcionesPagoRequest1)
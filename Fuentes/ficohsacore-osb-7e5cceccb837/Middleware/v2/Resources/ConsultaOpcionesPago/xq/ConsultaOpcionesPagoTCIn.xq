(:: pragma bea:global-element-parameter parameter="$consultaOpcionesPagoRequest1" element="ns1:consultaOpcionesPagoRequest" location="../../ConsultasCarteraCrediticia/xsd/consultasCarteraCrediticiaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ProcesosHN/conOpcionesPagoTC/xsd/ConsultaOpcionesPagoTC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ConsultasCarteraCrediticia";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaOpcionesPagoTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOpcionesPago/xq/ConsultaOpcionesPagoTCIn/";

declare function xf:ConsultaOpcionesPagoTCIn($pais as xs:string,
    $consultaOpcionesPagoRequest1 as element(ns1:consultaOpcionesPagoRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_NUMERO_CUENTA>{ data($consultaOpcionesPagoRequest1/PRODUCT/PRODUCT_VALUE) }</ns0:P_NUMERO_CUENTA>
            <ns0:P_PAIS>{ $pais }</ns0:P_PAIS>
        </ns0:InputParameters>
};

declare variable $pais as xs:string external;
declare variable $consultaOpcionesPagoRequest1 as element(ns1:consultaOpcionesPagoRequest) external;

xf:ConsultaOpcionesPagoTCIn($pais,
    $consultaOpcionesPagoRequest1)
(:: pragma bea:global-element-parameter parameter="$consultaTasaPromedioRequest" element="ns0:consultaTasaPromedioRequest" location="../xsd/consultaTasaPromedioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ConsultaTasaPromedio/xsd/fxConsultaDivisas_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/fxConsultaDivisas";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaPromedioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaPromedio/xq/consultaDivisasHNIn/";

declare function xf:consultaDivisasHNIn($consultaTasaPromedioRequest as element(ns0:consultaTasaPromedioRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ParamFecha>{ data($consultaTasaPromedioRequest/RATE_DATE) }</ns1:ParamFecha>
        </ns1:InputParameters>
};

declare variable $consultaTasaPromedioRequest as element(ns0:consultaTasaPromedioRequest) external;

xf:consultaDivisasHNIn($consultaTasaPromedioRequest)

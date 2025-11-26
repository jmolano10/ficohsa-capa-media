(:: pragma bea:global-element-parameter parameter="$transferenciaInternacionalH2HRequest" element="ns1:transferenciaInternacionalH2HRequest" location="../../xsd/transferenciaInternacionalH2HTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../../../Middleware/v2/BusinessServices/MDW/ConsultaCruceMoneda/xsd/Consulta_CruceMoneda_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/Consulta_CruceMoneda";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciaInternacionalH2HType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/TransferenciaInternacionalH2H/xq/Consultacrucemoneda/consultaCruceMonedaIN/";

declare function xf:consultaCruceMonedaIN($transferenciaInternacionalH2HRequest as element(ns1:transferenciaInternacionalH2HRequest),
    $codigopais as xs:string,
    $monto as xs:string,
    $tasa as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_PAIS>{ $codigopais }</ns0:PV_PAIS>
        </ns0:InputParameters>
};

declare variable $transferenciaInternacionalH2HRequest as element(ns1:transferenciaInternacionalH2HRequest) external;
declare variable $codigopais as xs:string external;
declare variable $monto as xs:string external;
declare variable $tasa as xs:string external;

xf:consultaCruceMonedaIN($transferenciaInternacionalH2HRequest,
    $codigopais,
    $monto,
    $tasa)

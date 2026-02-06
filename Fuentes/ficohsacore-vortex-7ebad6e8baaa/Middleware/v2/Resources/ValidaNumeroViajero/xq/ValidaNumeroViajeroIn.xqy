xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaNumeroViajero1" element="ns0:validaNumeroViajero" location="../xsd/validaNumeroViajeroTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ValidaNumeroViajero/xsd/validaNumeroViajero_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaNumeroViajeroTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaNumeroViajero";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaNumeroViajero/xq/ValidaNumeroViajeroIn/";

declare function xf:ValidaNumeroViajeroIn($validaNumeroViajero1 as element(ns0:validaNumeroViajero))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <PV_TYPE>{ data($validaNumeroViajero1/Type) }</PV_TYPE>
            <PV_NUMERO_VIAJERO>{ data($validaNumeroViajero1/FlyerNumber) }</PV_NUMERO_VIAJERO>
        </ns1:InputParameters>
};

declare variable $validaNumeroViajero1 as element(ns0:validaNumeroViajero) external;

xf:ValidaNumeroViajeroIn($validaNumeroViajero1)
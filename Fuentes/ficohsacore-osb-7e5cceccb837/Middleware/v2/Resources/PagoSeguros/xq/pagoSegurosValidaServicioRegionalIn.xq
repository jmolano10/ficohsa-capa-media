(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ValidaServicioRegional/xsd/ValidaServicioRegional_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoSeguros/xq/pagoSegurosValidaServicioRegionalIn/";

declare function xf:pagoSegurosValidaServicioRegionalIn($requestHeader1 as element(ns1:RequestHeader),
    $serviceId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_SERVICIO>{ $serviceId }</ns0:PV_SERVICIO>
            <ns0:PV_ORIGEN>{ data($requestHeader1/Region/SourceBank) }</ns0:PV_ORIGEN>
            {
                for $DestinationBank in $requestHeader1/Region/DestinationBank
                return
                    <ns0:PV_DESTINO>{ data($DestinationBank) }</ns0:PV_DESTINO>
            }
        </ns0:InputParameters>
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;
declare variable $serviceId as xs:string external;

xf:pagoSegurosValidaServicioRegionalIn($requestHeader1,
    $serviceId)
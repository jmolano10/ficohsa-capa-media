(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../ValidaServicioRegional/xsd/ValidaServicioRegional_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/validaServicioRegionalIn/";

declare function xf:validaServicioRegionalIn($pais as xs:string,
    $serviceId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_SERVICIO>{ $serviceId }</ns0:PV_SERVICIO>
            <ns0:PV_ORIGEN>{ $pais }</ns0:PV_ORIGEN>
            <ns0:PV_DESTINO>{$pais }</ns0:PV_DESTINO>
        </ns0:InputParameters>
};

declare variable $pais as xs:string external;
declare variable $serviceId as xs:string external;

xf:validaServicioRegionalIn($pais,
    $serviceId)
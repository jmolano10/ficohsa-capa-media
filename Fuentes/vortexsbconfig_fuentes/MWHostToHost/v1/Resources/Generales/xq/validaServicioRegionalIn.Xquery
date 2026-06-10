<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../EsquemasGenerales/headerElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MDW/validaServicioRegional/xsd/validaServicioRegional_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/Generales/xq/validaServicioRegionalIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional";

declare function xf:validaServicioRegionalIn($requestHeader as element(ns0:RequestHeader),
    $serviceId as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_SERVICIO>{ $serviceId }</ns1:PV_SERVICIO>
            <ns1:PV_ORIGEN>{ data($requestHeader/Region/SourceBank) }</ns1:PV_ORIGEN>
            {
                for $DestinationBank in $requestHeader/Region/DestinationBank
                return
                    <ns1:PV_DESTINO>{ data($DestinationBank) }</ns1:PV_DESTINO>
            }
        </ns1:InputParameters>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $serviceId as xs:string external;

xf:validaServicioRegionalIn($requestHeader,
    $serviceId)]]></con:xquery>
    <con:dependency location="../../EsquemasGenerales/headerElements.xsd">
        <con:schema ref="MWHostToHost/v1/Resources/EsquemasGenerales/headerElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MDW/validaServicioRegional/xsd/validaServicioRegional_sp.xsd">
        <con:schema ref="MWHostToHost/v1/BusinessServices/MDW/validaServicioRegional/xsd/validaServicioRegional_sp"/>
    </con:dependency>
</con:xqueryEntry>
<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuentaResponse1" element="ns1:ConsultaMovimientosCuentaResponse" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosCuenta/xq/ConsultaMovimientosCuentaHeaderOut/";

declare function xf:ConsultaMovimientosCuentaHeaderOut($consultaMovimientosCuentaResponse1 as element(ns1:ConsultaMovimientosCuentaResponse))
    as element(ns0:ResponseHeader) {
        &lt;ns0:ResponseHeader>
            {
                for $successIndicator in $consultaMovimientosCuentaResponse1/Status/successIndicator
                return
                    &lt;successIndicator>{ data($successIndicator) }&lt;/successIndicator>
            }
        &lt;/ns0:ResponseHeader>
};

declare variable $consultaMovimientosCuentaResponse1 as element(ns1:ConsultaMovimientosCuentaResponse) external;

xf:ConsultaMovimientosCuentaHeaderOut($consultaMovimientosCuentaResponse1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd">
        <con:schema ref="Middleware/Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
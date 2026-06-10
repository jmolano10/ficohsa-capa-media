<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$crearOrdenEmpaqueResponse" element="ns0:crearOrdenEmpaqueResponse" location="../../../BusinessServices/OrdenEmpaqueCloud/wsdl/ordenEmpaqueCloud.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ordenEmpaqueTDResponse" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_crearOrdenEmpaque";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OrdenEmpaqueTD/xq/ordenEmpaqueTDOut/";

declare function xf:ordenEmpaqueTDOut($crearOrdenEmpaqueResponse as element(ns0:crearOrdenEmpaqueResponse))
    as element(ns1:ordenEmpaqueTDResponse) {
        &lt;ns1:ordenEmpaqueTDResponse>
            {
                for $OrdenEmpaque in $crearOrdenEmpaqueResponse/ns0:result/ns0:OrdenEmpaque
                return
                    &lt;REFERENCE_NUMBER>{ data($OrdenEmpaque) }&lt;/REFERENCE_NUMBER>
            }
        &lt;/ns1:ordenEmpaqueTDResponse>
};

declare variable $crearOrdenEmpaqueResponse as element(ns0:crearOrdenEmpaqueResponse) external;

xf:ordenEmpaqueTDOut($crearOrdenEmpaqueResponse)</con:xquery>
    <con:dependency location="../../../BusinessServices/OrdenEmpaqueCloud/wsdl/ordenEmpaqueCloud.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/OrdenEmpaqueCloud/wsdl/ordenEmpaqueCloud"/>
    </con:dependency>
    <con:dependency location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/AperturaProductos/xsd/aperturaProductosTypes"/>
    </con:dependency>
</con:xqueryEntry>
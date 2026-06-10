<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizaSistemas1" element="ns0:actualizaSistemas" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opActualizacionClienteSolicitud" location="../../../BusinessServices/CTS/actualizaSistemaCobis/xsd/services.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace ns2 = "http://service.srvaplcobiscliente.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizacionClienteCobisIn/";

declare function xf:actualizacionClienteCobisIn($actualizaSistemas1 as element(ns0:actualizaSistemas))
    as element(ns2:opActualizacionClienteSolicitud) {
        &lt;ns2:opActualizacionClienteSolicitud>
            &lt;ns1:value>{ fn-bea:serialize($actualizaSistemas1) }&lt;/ns1:value>
        &lt;/ns2:opActualizacionClienteSolicitud>
};

declare variable $actualizaSistemas1 as element(ns0:actualizaSistemas) external;

xf:actualizacionClienteCobisIn($actualizaSistemas1)</con:xquery>
    <con:dependency location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesDatosClientes/xsd/operacionesDatosClientesTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/CTS/actualizaSistemaCobis/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/actualizaSistemaCobis/xsd/services"/>
    </con:dependency>
</con:xqueryEntry>
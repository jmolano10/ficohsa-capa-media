xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizaSistemas1" element="ns0:actualizaSistemas" location="../../OperacionesDatosClientes/xsd/operacionesDatosClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opActualizacionClienteSolicitud" location="../../../BusinessServices/CTS/actualizaSistemaCobis/xsd/services.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesDatosClientesTypes";
declare namespace ns2 = "http://service.srvaplcobiscliente.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaSistemas/xq/actualizacionClienteCobisIn/";

declare function xf:actualizacionClienteCobisIn($actualizaSistemas1 as element(ns0:actualizaSistemas))
    as element(ns2:opActualizacionClienteSolicitud) {
        <ns2:opActualizacionClienteSolicitud>
            <ns1:value>{ fn-bea:serialize($actualizaSistemas1) }</ns1:value>
        </ns2:opActualizacionClienteSolicitud>
};

declare variable $actualizaSistemas1 as element(ns0:actualizaSistemas) external;

xf:actualizacionClienteCobisIn($actualizaSistemas1)
xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$registrarTercerosResponse" element="ns0:registrarTercerosResponse" location="../../../BusinessServices/MTR/cargadorTerceros/wsdl/cargadorTercerosEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaProveedores/xq/cargaProveedoresPAHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://servicio.cargartercerospmsws.mtrpmsv.cidenet.com.co/";

declare function xf:cargaProveedoresPAHeaderOut($registrarTercerosResponse as element(ns0:registrarTercerosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $codigo in $registrarTercerosResponse/respuestaRegistroTerceros/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensaje in $registrarTercerosResponse/respuestaRegistroTerceros/mensaje
                return
                    <messages>{ data($mensaje) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $registrarTercerosResponse as element(ns0:registrarTercerosResponse) external;

xf:cargaProveedoresPAHeaderOut($registrarTercerosResponse)
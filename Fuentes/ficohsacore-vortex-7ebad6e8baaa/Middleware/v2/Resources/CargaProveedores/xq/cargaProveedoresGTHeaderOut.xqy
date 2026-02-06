xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registrarTercerosResponse" element="ns1:registrarTercerosResponse" location="../../../BusinessServices/MTR/cargadorTerceros/wsdl/cargadorTercerosEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.cargartercerospmsws.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaProveedores/xq/cargaProveedoresGTHeaderOut/";

declare function xf:cargaProveedoresGTHeaderOut($registrarTercerosResponse as element(ns1:registrarTercerosResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
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
        </ns0:ResponseHeader>
};

declare variable $registrarTercerosResponse as element(ns1:registrarTercerosResponse) external;

xf:cargaProveedoresGTHeaderOut($registrarTercerosResponse)
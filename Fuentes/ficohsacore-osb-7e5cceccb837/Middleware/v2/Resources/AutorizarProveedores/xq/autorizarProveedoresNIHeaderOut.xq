(:: pragma bea:global-element-parameter parameter="$autorizarTercerosResponse" element="ns1:autorizarTercerosResponse" location="../../../BusinessServices/MTR/autorizadorTerceros/wsdl/autorizadorTercerosEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.autorizartercerosws.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarProveedores/xq/autorizarProveedoresNIHeaderOut/";

declare function xf:autorizarProveedoresNIHeaderOut($autorizarTercerosResponse as element(ns1:autorizarTercerosResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $codigo in $autorizarTercerosResponse/return/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensaje in $autorizarTercerosResponse/return/mensaje
                return
                    <messages>{ data($mensaje) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $autorizarTercerosResponse as element(ns1:autorizarTercerosResponse) external;

xf:autorizarProveedoresNIHeaderOut($autorizarTercerosResponse)
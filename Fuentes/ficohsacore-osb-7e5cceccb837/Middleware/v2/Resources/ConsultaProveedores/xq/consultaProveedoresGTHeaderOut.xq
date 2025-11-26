(:: pragma bea:global-element-parameter parameter="$consultarTercerosResponse" element="ns1:consultarTercerosResponse" location="../../../BusinessServices/MTR/consultorTerceros/wsdl/consultorTercerosEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.consultatercerospmsws.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProveedores/xq/consultaProveedoresGTHeaderOut/";

declare function xf:consultaProveedoresGTHeaderOut($consultarTercerosResponse as element(ns1:consultarTercerosResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $codigo in $consultarTercerosResponse/respuestaConsultaTerceros/codigo
                return
                    <successIndicator>{ data($codigo) }</successIndicator>
            }
            {
                for $mensaje in $consultarTercerosResponse/respuestaConsultaTerceros/mensaje
                return
                    <messages>{ data($mensaje) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $consultarTercerosResponse as element(ns1:consultarTercerosResponse) external;

xf:consultaProveedoresGTHeaderOut($consultarTercerosResponse)
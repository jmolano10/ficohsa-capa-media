xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultarTercerosResponse" element="ns0:consultarTercerosResponse" location="../../../BusinessServices/MTR/consultorTerceros/wsdl/consultorTercerosEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProveedores/xq/consultaProveedoresPAHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://servicio.consultatercerospmsws.mtrpmsv.cidenet.com.co/";

declare function xf:consultaProveedoresPAHeaderOut($consultarTercerosResponse as element(ns0:consultarTercerosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
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
        </ns1:ResponseHeader>
};

declare variable $consultarTercerosResponse as element(ns0:consultarTercerosResponse) external;

xf:consultaProveedoresPAHeaderOut($consultarTercerosResponse)
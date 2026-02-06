xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultarTercerosResponse" element="ns0:consultarTercerosResponse" location="../../../BusinessServices/MTR/consultorTerceros/wsdl/consultorTercerosEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:consultarProveedoresResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProveedores/xq/consultaProveedoresPAOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://servicio.consultatercerospmsws.mtrpmsv.cidenet.com.co/";

declare function xf:consultaProveedoresPAOut($consultarTercerosResponse as element(ns0:consultarTercerosResponse))
    as element(ns1:consultarProveedoresResponse) {
        <ns1:consultarProveedoresResponse>
            {
                for $codigoCliente in $consultarTercerosResponse/respuestaConsultaTerceros/codigoCliente
                return
                    <CUSTOMER_ID>{ data($codigoCliente) }</CUSTOMER_ID>
            }
            {
                for $terceros in $consultarTercerosResponse/respuestaConsultaTerceros/terceros
                return
                    <SUPPLIERS>
                        {
                            for $tercero in $terceros/tercero
                            return
                                <SUPPLIER>
                                    <ID>{ data($tercero/idTercero) }</ID>
                                    <NAME>{ data($tercero/nombreTercero) }</NAME>
                                    <LEGAL_ID>{ data($tercero/numeroIdentificacion) }</LEGAL_ID>
                                    <DESTINATION_BANK>{ data($tercero/bancoDestino) }</DESTINATION_BANK>
                                    {
                                        for $nombreBancoDestino in $tercero/nombreBancoDestino
                                        return
                                            <DESTINATION_BANK_DESC>{ data($nombreBancoDestino) }</DESTINATION_BANK_DESC>
                                    }
                                    <ACCOUNT_NUMBER>{ data($tercero/idProductoDestino) }</ACCOUNT_NUMBER>
                                    {
                                        for $idTpProductoDestino in $tercero/idTpProductoDestino
                                        return
                                            <ACCOUNT_TYPE>{ data($idTpProductoDestino) }</ACCOUNT_TYPE>
                                    }
                                </SUPPLIER>
                        }
                    </SUPPLIERS>
            }
        </ns1:consultarProveedoresResponse>
};

declare variable $consultarTercerosResponse as element(ns0:consultarTercerosResponse) external;

xf:consultaProveedoresPAOut($consultarTercerosResponse)
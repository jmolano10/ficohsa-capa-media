xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$autorizarLoteResponse" element="ns1:autorizarLoteResponse" location="../../../BusinessServices/MTR/autorizarLote/wsdl/autorizarLotesEndpoint.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:autorizarLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLotePAOut/";
declare namespace ns1 = "http://servicio.enviosolicitudcoretask.mtrpmsv.cidenet.com.co/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";

declare function xf:autorizarLotePAOut($autorizarLoteResponse as element(ns1:autorizarLoteResponse))
    as element(ns0:autorizarLoteResponse) {
        <ns0:autorizarLoteResponse>
            {
                for $lotes in $autorizarLoteResponse/respuestaAutorizacionLotes/detalleRespuesta/lotes
                return
                    <BATCHES>
                        {
                            for $lote in $lotes/lote
                            return
                                <BATCH>
                                    <BANK_BATCH_ID>{ data($lote/idLote) }</BANK_BATCH_ID>
                                    <STATUS>{ data($lote/estado) }</STATUS>
                                    <STATUS_DESC>{ data($lote/descripcionEstado) }</STATUS_DESC>
                                    {
                                        let $result :=
                                            for $errores in $lote/errores
                                            return
                                                <DETAIL_ERRORS>
                                                    <DETAIL_ERROR>
                                                        <ACCOUNT_NUMBER>{ data($errores/numeroCuenta) }</ACCOUNT_NUMBER>
                                                        <BATCH_AMOUNT>{ data($errores/monto) }</BATCH_AMOUNT>
                                                        <TAX_AMOUNT>{ data($errores/impuesto) }</TAX_AMOUNT>
                                                    </DETAIL_ERROR>
                                                </DETAIL_ERRORS>
                                        return
                                            $result[1]
                                    }
                                </BATCH>
                        }
                    </BATCHES>
            }
        </ns0:autorizarLoteResponse>
};

declare variable $autorizarLoteResponse as element(ns1:autorizarLoteResponse) external;

xf:autorizarLotePAOut($autorizarLoteResponse)
xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autorizarLote" element="ns1:autorizarLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:autorizarLote" location="../../../BusinessServices/MTR/autorizarLote/wsdl/autorizarLotesEndpoint.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://servicio.enviosolicitudcoretask.mtrpmsv.cidenet.com.co/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteNIIn/";

declare function xf:autorizarLoteNIIn($requestHeader as element(ns0:RequestHeader),
    $autorizarLote as element(ns1:autorizarLote))
    as element(ns2:autorizarLote) {
        <ns2:autorizarLote>
            <idBancoOrigen>{ data($requestHeader/Region/SourceBank) }</idBancoOrigen>
            <idCliente>{ data($autorizarLote/CUSTOMER_ID) }</idCliente>
            <idUsuario>{ data($autorizarLote/USER_ID) }</idUsuario>
            {
                let $BATCHES := $autorizarLote/BATCHES
                return
                    <lotes>
                        {
                            for $BATCH in $BATCHES/BATCH
                            return
                                <lote>
                                	{
                                		for $APPLICATION_DATE in $BATCH/APPLICATION_DATE
                                		return
                                			<fechaAplicacion>{ data($APPLICATION_DATE) }</fechaAplicacion>
                                	}                                    
                                    {
                                        for $UPLOAD_DATE in $BATCH/UPLOAD_DATE
                                        return
                                            <fechaAutorizacion>{  xs:date(data($UPLOAD_DATE)) cast as xs:dateTime }</fechaAutorizacion>
                                    }
                                    <idLote>{ data($BATCH/BANK_BATCH_ID) }</idLote>
                                </lote>
                        }
                    </lotes>
            }
        </ns2:autorizarLote>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $autorizarLote as element(ns1:autorizarLote) external;

xf:autorizarLoteNIIn($requestHeader,
    $autorizarLote)
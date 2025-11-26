xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autorizarLote" element="ns0:autorizarLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:autorizarLote" location="../../../BusinessServices/MTR/autorizarLote/wsdl/autorizarLotesEndpoint.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLotePAIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://servicio.enviosolicitudcoretask.mtrpmsv.cidenet.com.co/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";

declare function xf:autorizarLotePAIn($requestHeader as element(ns2:RequestHeader),
    $autorizarLote as element(ns0:autorizarLote))
    as element(ns1:autorizarLote) {
        <ns1:autorizarLote>
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
        </ns1:autorizarLote>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $autorizarLote as element(ns0:autorizarLote) external;

xf:autorizarLotePAIn($requestHeader,
    $autorizarLote)
(:: pragma bea:global-element-parameter parameter="$cancelarLote" element="ns1:cancelarLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:editarEstadoLote" location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://servicio.editarlotews.mtrpmsv.cidenet.com.co/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLote/xq/cancelarLoteNIIn/";

declare function xf:cancelarLoteNIIn($cancelarLote as element(ns1:cancelarLote),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns2:editarEstadoLote) {
        <ns2:editarEstadoLote>
            <idBancoOrigen>{ data($requestHeader/Region/SourceBank) }</idBancoOrigen>
            <idCliente>{ data($cancelarLote/CUSTOMER_ID) }</idCliente>
            <idLote>{ data($cancelarLote/BANK_BATCH_ID) }</idLote>
            {     
              	for $UPLOAD_DATE in $cancelarLote/UPLOAD_DATE
                return
              	<fecha>{xs:date($cancelarLote/UPLOAD_DATE)cast as xs:dateTime }</fecha>            
            }
            <idUsuario>{ data($cancelarLote/USER_ID) }</idUsuario>
            <estado>C</estado>
        </ns2:editarEstadoLote>
};

declare variable $cancelarLote as element(ns1:cancelarLote) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:cancelarLoteNIIn($cancelarLote,
    $requestHeader)
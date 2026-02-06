xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaEstadoLote" element="ns1:consultaEstadoLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultarLote" location="../../../BusinessServices/MTR/consultorLote/wsdl/consultorLoteEndpoint.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://servicio.consultalotews.mtrpmsv.cidenet.com.co/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteGTIn/";

declare function xf:consultaEstadoLoteGTIn($requestHeader as element(ns0:RequestHeader),
    $consultaEstadoLote as element(ns1:consultaEstadoLote))
    as element(ns2:consultarLote) {
        <ns2:consultarLote>
            <solicitudConsultaLote>
                {
              	for $UPLOAD_DATE in $consultaEstadoLote/UPLOAD_DATE
                return
              	<fechaRegistroLote>{xs:date($consultaEstadoLote/UPLOAD_DATE)cast as xs:dateTime }</fechaRegistroLote>
                }
                <idBancoOrigen>{ data($requestHeader/Region/SourceBank) }</idBancoOrigen>
                <idCliente>{ data($consultaEstadoLote/CUSTOMER_ID) }</idCliente>
                <idLote>{ data($consultaEstadoLote/BANK_BATCH_ID) }</idLote>
            </solicitudConsultaLote>
        </ns2:consultarLote>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaEstadoLote as element(ns1:consultaEstadoLote) external;

xf:consultaEstadoLoteGTIn($requestHeader,
    $consultaEstadoLote)
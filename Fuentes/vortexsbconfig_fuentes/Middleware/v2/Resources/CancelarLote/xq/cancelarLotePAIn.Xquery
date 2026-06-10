<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cancelarLote" element="ns1:cancelarLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:editarEstadoLote" location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://servicio.editarlotews.mtrpmsv.cidenet.com.co/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLote/xq/cancelarLotePAIn/";

declare function xf:cancelarLotePAIn($requestHeader as element(ns2:RequestHeader),
    $cancelarLote as element(ns1:cancelarLote))
    as element(ns0:editarEstadoLote) {
        <ns0:editarEstadoLote>
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
        </ns0:editarEstadoLote>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $cancelarLote as element(ns1:cancelarLote) external;

xf:cancelarLotePAIn($requestHeader,
    $cancelarLote)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint"/>
    </con:dependency>
</con:xqueryEntry>
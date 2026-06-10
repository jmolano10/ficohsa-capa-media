<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cancelarLote" element="ns1:cancelarLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:editarEstadoLote" location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl" ::)

declare namespace ns2 = "http://servicio.editarlotews.mtrpmsv.cidenet.com.co/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLote/xq/cancelarLoteGTIn/";

declare function xf:cancelarLoteGTIn($cancelarLote as element(ns1:cancelarLote),
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

xf:cancelarLoteGTIn($cancelarLote,
    $requestHeader)]]></con:xquery>
    <con:dependency location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/MTR/editorLote/wsdl/editorLoteEndpoint"/>
    </con:dependency>
</con:xqueryEntry>
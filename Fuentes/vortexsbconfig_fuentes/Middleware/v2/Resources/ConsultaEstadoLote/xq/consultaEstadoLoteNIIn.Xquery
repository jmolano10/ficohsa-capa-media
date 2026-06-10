<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaEstadoLote" element="ns1:consultaEstadoLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultarLote" location="../../../BusinessServices/MTR/consultorLote/wsdl/consultorLoteEndpoint.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://servicio.consultalotews.mtrpmsv.cidenet.com.co/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteNIIn/";

declare function xf:consultaEstadoLoteNIIn($requestHeader as element(ns0:RequestHeader),
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

xf:consultaEstadoLoteNIIn($requestHeader,
    $consultaEstadoLote)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MTR/consultorLote/wsdl/consultorLoteEndpoint.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/MTR/consultorLote/wsdl/consultorLoteEndpoint"/>
    </con:dependency>
</con:xqueryEntry>
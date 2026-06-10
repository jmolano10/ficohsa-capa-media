<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaEstadoLote" element="ns1:consultaEstadoLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultarLote" location="../../../BusinessServices/MTR/consultorLote/wsdl/consultorLoteEndpoint.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLotePAIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://servicio.consultalotews.mtrpmsv.cidenet.com.co/";

declare function xf:consultaEstadoLotePAIn($requestHeader as element(ns2:RequestHeader),
    $consultaEstadoLote as element(ns1:consultaEstadoLote))
    as element(ns0:consultarLote) {
        <ns0:consultarLote>
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
        </ns0:consultarLote>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaEstadoLote as element(ns1:consultaEstadoLote) external;

xf:consultaEstadoLotePAIn($requestHeader,
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
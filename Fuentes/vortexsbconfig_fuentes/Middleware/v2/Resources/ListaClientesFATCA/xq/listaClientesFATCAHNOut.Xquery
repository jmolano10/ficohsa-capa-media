<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaClientesFatcaResponse" element="ns0:ConsultaClientesFatcaResponse" location="../../../BusinessServices/T24/consultarListaFatca/xsd/XMLSchema_-131806455.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaListasClienteResponse" location="../../ConsultaListasCliente/xsd/sjConsultaListasCliente.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ListaClientesFATCA/xq/listaClientesFATCAHNOut/";

declare function xf:listaClientesFATCAHNOut($consultaClientesFatcaResponse as element(ns0:ConsultaClientesFatcaResponse))
    as element(ns1:sjConsultaListasClienteResponse) {
        <ns1:sjConsultaListasClienteResponse>
            <ns1:consultaListaClienteResponse>
                <ns1:successIndicator>{ fn:string($consultaClientesFatcaResponse/Status/successIndicator/text()) }</ns1:successIndicator>
                {
                    for $messages in $consultaClientesFatcaResponse/Status/messages
                    return
                        <ns1:messages>{ data($messages) }</ns1:messages>
                }
                <ns1:ASSOCIATION_NAME>FATCA</ns1:ASSOCIATION_NAME>
                <ns1:CUSTOMER_NAME>{ data($consultaClientesFatcaResponse/NOFILEFICOFATCALISTType[1]/gNOFILEFICOFATCALISTDetailType/mNOFILEFICOFATCALISTDetailType[1]/LISTAFATCA[1]) }</ns1:CUSTOMER_NAME>
            </ns1:consultaListaClienteResponse>
        </ns1:sjConsultaListasClienteResponse>
};

declare variable $consultaClientesFatcaResponse as element(ns0:ConsultaClientesFatcaResponse) external;

xf:listaClientesFATCAHNOut($consultaClientesFatcaResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/T24/consultarListaFatca/xsd/XMLSchema_-131806455.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/consultarListaFatca/xsd/XMLSchema_-131806455"/>
    </con:dependency>
    <con:dependency location="../../ConsultaListasCliente/xsd/sjConsultaListasCliente.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaListasCliente/xsd/sjConsultaListasCliente"/>
    </con:dependency>
</con:xqueryEntry>
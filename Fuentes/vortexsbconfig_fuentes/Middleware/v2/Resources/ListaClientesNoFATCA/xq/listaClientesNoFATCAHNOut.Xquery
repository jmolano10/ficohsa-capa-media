<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeclientesnoFATCAResponse" element="ns0:ConsultadeclientesnoFATCAResponse" location="../../../BusinessServices/T24/consultaClientesNoFATCA/xsd/XMLSchema_-531907416.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaListasClienteResponse" location="../../ConsultaListasCliente/xsd/sjConsultaListasCliente.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ListaClientesNoFATCA/xq/listaClientesNoFATCAHNOut/";

declare function xf:listaClientesNoFATCAHNOut($consultadeclientesnoFATCAResponse as element(ns0:ConsultadeclientesnoFATCAResponse),
    $successIndicator as xs:string)
    as element(ns1:sjConsultaListasClienteResponse) {
        <ns1:sjConsultaListasClienteResponse>
            <ns1:consultaListaClienteResponse>
                <ns1:successIndicator>{ $successIndicator }</ns1:successIndicator>
                <ns1:ASSOCIATION_NAME>NOFATCA</ns1:ASSOCIATION_NAME>
                {
                    for $NumeroCliente in $consultadeclientesnoFATCAResponse/WSFICONOFATCAType[1]/gWSFICONOFATCADetailType/mWSFICONOFATCADetailType[1]/NumeroCliente
                    return
                        <ns1:CUSTOMER_ID>{ data($NumeroCliente) }</ns1:CUSTOMER_ID>
                }
                {
                    for $NombreCliente in $consultadeclientesnoFATCAResponse/WSFICONOFATCAType[1]/gWSFICONOFATCADetailType/mWSFICONOFATCADetailType[1]/NombreCliente
                    return
                        <ns1:CUSTOMER_NAME>{ data($NombreCliente) }</ns1:CUSTOMER_NAME>
                }
            </ns1:consultaListaClienteResponse>
        </ns1:sjConsultaListasClienteResponse>
};

declare variable $consultadeclientesnoFATCAResponse as element(ns0:ConsultadeclientesnoFATCAResponse) external;
declare variable $successIndicator as xs:string external;

xf:listaClientesNoFATCAHNOut($consultadeclientesnoFATCAResponse,
    $successIndicator)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/T24/consultaClientesNoFATCA/xsd/XMLSchema_-531907416.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/consultaClientesNoFATCA/xsd/XMLSchema_-531907416"/>
    </con:dependency>
    <con:dependency location="../../ConsultaListasCliente/xsd/sjConsultaListasCliente.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaListasCliente/xsd/sjConsultaListasCliente"/>
    </con:dependency>
</con:xqueryEntry>
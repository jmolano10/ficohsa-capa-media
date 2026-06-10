<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaDetalleContratoRecaudosResponse" element="ns1:sjConsultaDetalleContratoRecaudosResponse" location="../../../BusinessServices/SJS/consultaDetalleContratoRecaudos/xsd/sjConsultaDetalleContratoRecaudosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaDetalleContratoRecaudosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleContratoRecaudos/xq/consultaDetalleContratoRecaudosHeaderOut/";

declare function xf:consultaDetalleContratoRecaudosHeaderOut($sjConsultaDetalleContratoRecaudosResponse as element(ns1:sjConsultaDetalleContratoRecaudosResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ data($sjConsultaDetalleContratoRecaudosResponse/RESPONSE_CODE) }</successIndicator>
            {
                for $RESPONSE_MESSAGE in $sjConsultaDetalleContratoRecaudosResponse/RESPONSE_MESSAGE
                return
                    <messages>{ data($RESPONSE_MESSAGE) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $sjConsultaDetalleContratoRecaudosResponse as element(ns1:sjConsultaDetalleContratoRecaudosResponse) external;

xf:consultaDetalleContratoRecaudosHeaderOut($sjConsultaDetalleContratoRecaudosResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/SJS/consultaDetalleContratoRecaudos/xsd/sjConsultaDetalleContratoRecaudosTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaDetalleContratoRecaudos/xsd/sjConsultaDetalleContratoRecaudosTypes"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
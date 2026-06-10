<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaDetallesCuenta/consultaDetallesCuentHeaderOut/";

declare function xf:consultaDetallesCuentHeaderOut($consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadedetallesdelacuentaResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $consultadedetallesdelacuentaResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadedetallesdelacuentaResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:consultaDetallesCuentHeaderOut($consultadedetallesdelacuentaResponse1)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_378991004.xsd">
        <con:schema ref="Middleware/Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
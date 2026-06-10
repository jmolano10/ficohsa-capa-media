<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMaestroSaldoCuentaResponse" element="ns0:ConsultaMaestroSaldoCuentaResponse" location="../../../BusinessServices/T24/ConsultaMaestroSaldoCuenta/xsd/services_1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xq/consultaMaestraSaldoCuentaHNHeaderOut/";

declare function xf:consultaMaestraSaldoCuentaHNHeaderOut($consultaMaestroSaldoCuentaResponse as element(ns0:ConsultaMaestroSaldoCuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultaMaestroSaldoCuentaResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $consultaMaestroSaldoCuentaResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultaMaestroSaldoCuentaResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultaMaestroSaldoCuentaResponse as element(ns0:ConsultaMaestroSaldoCuentaResponse) external;

xf:consultaMaestraSaldoCuentaHNHeaderOut($consultaMaestroSaldoCuentaResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/T24/ConsultaMaestroSaldoCuenta/xsd/services_1.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/ConsultaMaestroSaldoCuenta/xsd/services_1"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
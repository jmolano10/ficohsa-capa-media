<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadecertifdepositoResponse1" element="ns0:ConsultadecertifdepositoResponse" location="../Resources/XMLSchema_1178015080.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCertificadoDeposito/consultaCertificadoDeposito/consultaCertificadoDepositoHeaderOut/";

declare function xf:consultaCertificadoDepositoHeaderOut($consultadecertifdepositoResponse1 as element(ns0:ConsultadecertifdepositoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadecertifdepositoResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $consultadecertifdepositoResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadecertifdepositoResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadecertifdepositoResponse1 as element(ns0:ConsultadecertifdepositoResponse) external;

xf:consultaCertificadoDepositoHeaderOut($consultadecertifdepositoResponse1)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_1178015080.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaCertificadoDeposito/Resources/XMLSchema_1178015080"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
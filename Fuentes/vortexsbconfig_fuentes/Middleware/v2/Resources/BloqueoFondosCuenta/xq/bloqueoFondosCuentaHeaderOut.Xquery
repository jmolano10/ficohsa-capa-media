<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$bloqueodepasivosResponse" element="ns0:BloqueodepasivosResponse" location="../../../../Business_Resources/bloqueoPasivos/Resoruces/XMLSchema_524093592.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BloqueoFondosCuenta/xq/bloqueoFondosCuentaHeaderOut/";

declare function xf:bloqueoFondosCuentaHeaderOut($bloqueodepasivosResponse as element(ns0:BloqueodepasivosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $bloqueodepasivosResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $bloqueodepasivosResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
				let $messageStatus := string-join($bloqueodepasivosResponse/Status/messages, '. ')
				return
				if ($messageStatus != '') then (
					<messages>{ $messageStatus }</messages>
				) else ()
            }
        </ns1:ResponseHeader>
};

declare variable $bloqueodepasivosResponse as element(ns0:BloqueodepasivosResponse) external;

xf:bloqueoFondosCuentaHeaderOut($bloqueodepasivosResponse)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/bloqueoPasivos/Resoruces/XMLSchema_524093592.xsd">
        <con:schema ref="Middleware/Business_Resources/bloqueoPasivos/Resoruces/XMLSchema_524093592"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>
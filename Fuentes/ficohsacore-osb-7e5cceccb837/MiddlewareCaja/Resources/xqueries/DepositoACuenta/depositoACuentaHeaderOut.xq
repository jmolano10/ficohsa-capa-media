xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$depositoCombinadoResponse" element="ns1:DepositoCombinadoResponse" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoACuenta/depositoACuentaHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";

declare function xf:depositoACuentaHeaderOut($depositoCombinadoResponse as element(ns1:DepositoCombinadoResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                let $successIndicator := fn:string($depositoCombinadoResponse/Status/successIndicator/text())
                let $transactionId := fn:string($depositoCombinadoResponse/Status/transactionId/text())
                return
                if ($successIndicator = "Success") then (
                    <transactionId>{ data($transactionId) }</transactionId>
                ) else (
                )                    
            }            
            {
                for $successIndicator in $depositoCombinadoResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                let $successIndicator := fn:string($depositoCombinadoResponse/Status/successIndicator/text())
                let $BOOKINGDATE := fn:string($depositoCombinadoResponse/TELLERFINANCIALSERVICESType/BOOKINGDATE/text())
                let $messages := fn:string($depositoCombinadoResponse/Status/messages[1]/text())
                return
                if ($successIndicator = "Success") then (
                    <valueDate>{ data($BOOKINGDATE) }</valueDate>
                ) else (
                	<messages>{ $messages }</messages>
                )                    
            }
        </ns0:ResponseHeader>
};

declare variable $depositoCombinadoResponse as element(ns1:DepositoCombinadoResponse) external;

xf:depositoACuentaHeaderOut($depositoCombinadoResponse)
xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$depositoChequeCertificadoLCYResponse1" element="ns0:DepositoChequeCertificadoLCYResponse" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeCertificado/depositoChequeCertificadoLCYHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:depositoChequeCertificadoLCYHeaderOut($depositoChequeCertificadoLCYResponse1 as element(ns0:DepositoChequeCertificadoLCYResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $successIndicator := fn:string($depositoChequeCertificadoLCYResponse1/Status/successIndicator/text())
                let $transactionId := fn:string($depositoChequeCertificadoLCYResponse1/Status/transactionId/text())
                return
                    if ($successIndicator = "Success") then (
                    	<transactionId>{ data($transactionId) }</transactionId>
                    ) else ()
            }
            {
                for $successIndicator in $depositoChequeCertificadoLCYResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $depositoChequeCertificadoLCYResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $successIndicator := fn:string($depositoChequeCertificadoLCYResponse1/Status/successIndicator/text())
                let $VALUEDATE2 := fn:string($depositoChequeCertificadoLCYResponse1/TELLERType/VALUEDATE2/text())
                return
                	if ($successIndicator = "Success") then (
                	    <valueDate>{ data($VALUEDATE2) }</valueDate>
                	) else ()
            }
        </ns1:ResponseHeader>
};

declare variable $depositoChequeCertificadoLCYResponse1 as element(ns0:DepositoChequeCertificadoLCYResponse) external;

xf:depositoChequeCertificadoLCYHeaderOut($depositoChequeCertificadoLCYResponse1)
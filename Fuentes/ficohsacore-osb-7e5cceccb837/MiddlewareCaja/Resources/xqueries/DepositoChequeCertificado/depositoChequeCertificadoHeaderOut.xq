(:: pragma bea:global-element-parameter parameter="$depositodechequecertificadoResponse1" element="ns0:DepositodechequecertificadoResponse" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeCertificado/depositoChequeCertificadoHeaderOut/";

declare function xf:depositoChequeCertificadoHeaderOut($depositodechequecertificadoResponse1 as element(ns0:DepositodechequecertificadoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $successIndicator := fn:string($depositodechequecertificadoResponse1/Status/successIndicator/text())
                let $transactionId := fn:string($depositodechequecertificadoResponse1/Status/transactionId/text())
                return
                    if ($successIndicator = "Success") then (
                    	<transactionId>{ data($transactionId) }</transactionId>
                    ) else ()
            }
            {
                for $successIndicator in $depositodechequecertificadoResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $depositodechequecertificadoResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $successIndicator := fn:string($depositodechequecertificadoResponse1/Status/successIndicator/text())
                let $VALUEDATE2 := fn:string($depositodechequecertificadoResponse1/TELLERType/VALUEDATE2/text())
                return
                	if ($successIndicator = "Success") then (
                	    <valueDate>{ data($VALUEDATE2) }</valueDate>
                	) else ()
            }
        </ns1:ResponseHeader>
};

declare variable $depositodechequecertificadoResponse1 as element(ns0:DepositodechequecertificadoResponse) external;

xf:depositoChequeCertificadoHeaderOut($depositodechequecertificadoResponse1)
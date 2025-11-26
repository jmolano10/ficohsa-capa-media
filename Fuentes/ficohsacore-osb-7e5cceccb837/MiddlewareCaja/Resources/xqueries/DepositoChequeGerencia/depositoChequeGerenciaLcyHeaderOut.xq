xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$depositoChequeGerenciaLCYResponse1" element="ns0:DepositoChequeGerenciaLCYResponse" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeGerencia/depositoChequeGerenciaLcyHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:depositoChequeGerenciaLcyHeaderOut($depositoChequeGerenciaLCYResponse1 as element(ns0:DepositoChequeGerenciaLCYResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $successIndicator := fn:string($depositoChequeGerenciaLCYResponse1/Status/successIndicator/text())
                let $transactionId := fn:string($depositoChequeGerenciaLCYResponse1/Status/transactionId/text())
                return
                	if ($successIndicator = "Success") then (
                    	<transactionId>{ data($transactionId) }</transactionId>
                    ) else ()
            }
            {
                for $successIndicator in $depositoChequeGerenciaLCYResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $depositoChequeGerenciaLCYResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                let $successIndicator := fn:string($depositoChequeGerenciaLCYResponse1/Status/successIndicator/text())
                let $VALUEDATE2 := fn:string($depositoChequeGerenciaLCYResponse1/TELLERType/VALUEDATE2/text())
                return
                    if ($successIndicator = "Success") then (
                    	<valueDate>{ data($VALUEDATE2) }</valueDate>
                    ) else ()
            }
        </ns1:ResponseHeader>
};

declare variable $depositoChequeGerenciaLCYResponse1 as element(ns0:DepositoChequeGerenciaLCYResponse) external;

xf:depositoChequeGerenciaLcyHeaderOut($depositoChequeGerenciaLCYResponse1)
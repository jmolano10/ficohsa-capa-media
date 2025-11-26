xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$depositoChequeGerenciaFCYResponse1" element="ns0:DepositoChequeGerenciaFCYResponse" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cambioestadochqgerenciaFCYResponse1" element="ns0:CambioestadochqgerenciaFCYResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion_v2.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeGerencia/depositoChequeGerenciaFcyHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:depositoChequeGerenciaFcyHeaderOut($depositoChequeGerenciaFCYResponse1 as element(ns0:DepositoChequeGerenciaFCYResponse),
    $cambioestadochqgerenciaFCYResponse1 as element(ns0:CambioestadochqgerenciaFCYResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {   
            	let $transactionId := fn:string($depositoChequeGerenciaFCYResponse1/Status/transactionId/text())
            	let $valueDate := fn:string($depositoChequeGerenciaFCYResponse1/TELLERType/VALUEDATE2/text())
            	let $successIndicatorDep := fn:string($depositoChequeGerenciaFCYResponse1/Status/successIndicator/text())
            	let $successIndicatorEstado := fn:string($cambioestadochqgerenciaFCYResponse1/Status/successIndicator/text())
                return
                	if ($successIndicatorDep = "Success" and $successIndicatorEstado = "Success") then (
                    	<transactionId>{ data($transactionId) }</transactionId>,
                    	<successIndicator>{ $successIndicatorDep }</successIndicator>,
                    	<valueDate>{ $valueDate }</valueDate>
                    	
                    ) else if ($successIndicatorDep != "Success") then (
                    	<successIndicator>{ $successIndicatorDep }</successIndicator>,
                    	for $messages in $depositoChequeGerenciaFCYResponse1/Status/messages
                    	return
                    		<messages>{ data($messages) }</messages>
                    ) else (
                    	<successIndicator>{ $successIndicatorEstado }</successIndicator>,
                    	for $messages in $cambioestadochqgerenciaFCYResponse1/Status/messages
                    	return
                    		<messages>{ data($messages) }</messages>
                    	
                    )
            }
        </ns1:ResponseHeader>
};

declare variable $depositoChequeGerenciaFCYResponse1 as element(ns0:DepositoChequeGerenciaFCYResponse) external;
declare variable $cambioestadochqgerenciaFCYResponse1 as element(ns0:CambioestadochqgerenciaFCYResponse) external;

xf:depositoChequeGerenciaFcyHeaderOut($depositoChequeGerenciaFCYResponse1,
    $cambioestadochqgerenciaFCYResponse1)

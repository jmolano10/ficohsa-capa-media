(:: pragma bea:global-element-parameter parameter="$depositodechequedegerenciaFCYResponse" element="ns0:DepositodechequedegerenciaFCYResponse" location="../../xsds/Depositos/XMLSchema_-420276392.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cambioestadochqgerenciaFCYResponse" element="ns0:CambioestadochqgerenciaFCYResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeCajaFCY/DepositoChequeCajaFCYHeaderOut/";

declare function xf:DepositoChequeCajaFCYHeaderOut($depositodechequedegerenciaFCYResponse as element(ns0:DepositodechequedegerenciaFCYResponse),
    $cambioestadochqgerenciaFCYResponse as element(ns0:CambioestadochqgerenciaFCYResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	let $successIndicator := fn:string($cambioestadochqgerenciaFCYResponse/Status/successIndicator/text())
            	return
            		if($successIndicator = "Success") then (
            			<transactionId>{ data($depositodechequedegerenciaFCYResponse/Status/transactionId) }</transactionId>,
            			<successIndicator>{ data($successIndicator) }</successIndicator>,
            			<valueDate>{ data($cambioestadochqgerenciaFCYResponse/FICOFCYDRAFTDETAILSType/gDATETIME/DATETIME[1]) }</valueDate>
            		) else (
            			<successIndicator>{ data($successIndicator) }</successIndicator>,
            			<messages>{ data($cambioestadochqgerenciaFCYResponse/Status/messages) }</messages>
            			
            		)
            }
        </ns1:ResponseHeader>
};

declare variable $depositodechequedegerenciaFCYResponse as element(ns0:DepositodechequedegerenciaFCYResponse) external;
declare variable $cambioestadochqgerenciaFCYResponse as element(ns0:CambioestadochqgerenciaFCYResponse) external;

xf:DepositoChequeCajaFCYHeaderOut($depositodechequedegerenciaFCYResponse,
    $cambioestadochqgerenciaFCYResponse)
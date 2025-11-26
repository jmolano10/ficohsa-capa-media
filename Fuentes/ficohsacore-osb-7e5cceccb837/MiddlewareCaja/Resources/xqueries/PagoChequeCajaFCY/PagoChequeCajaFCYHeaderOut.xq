(:: pragma bea:global-element-parameter parameter="$pagodechequedegerenciaFCYResponse" element="ns0:PagodechequedegerenciaFCYResponse" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cambioestadochqgerenciaFCYResponse" element="ns0:CambioestadochqgerenciaFCYResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoChequeCajaFCY/PagoChequeCajaFCYHeaderOut/";

declare function xf:PagoChequeCajaFCYHeaderOut($pagodechequedegerenciaFCYResponse as element(ns0:PagodechequedegerenciaFCYResponse),
    $cambioestadochqgerenciaFCYResponse as element(ns0:CambioestadochqgerenciaFCYResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	let $successIndicator := fn:string($cambioestadochqgerenciaFCYResponse/Status/successIndicator/text())
            	return
            		if($successIndicator = "Success") then (
            			<transactionId>{ data($pagodechequedegerenciaFCYResponse/Status/transactionId) }</transactionId>,
            			<successIndicator>{ data($successIndicator) }</successIndicator>,
            			<valueDate>{ data($cambioestadochqgerenciaFCYResponse/FICOFCYDRAFTDETAILSType/gDATETIME/DATETIME[1]) }</valueDate>
            		) else (
            			<successIndicator>{ data($successIndicator) }</successIndicator>,
            			<messages>{ data($cambioestadochqgerenciaFCYResponse/Status/messages) }</messages>
            			
            		)
            }
        </ns1:ResponseHeader>
};

declare variable $pagodechequedegerenciaFCYResponse as element(ns0:PagodechequedegerenciaFCYResponse) external;
declare variable $cambioestadochqgerenciaFCYResponse as element(ns0:CambioestadochqgerenciaFCYResponse) external;

xf:PagoChequeCajaFCYHeaderOut($pagodechequedegerenciaFCYResponse,
    $cambioestadochqgerenciaFCYResponse)
(:: pragma bea:global-element-parameter parameter="$onlinePaymentV4Response1" element="ns2:OnlinePaymentV4Response" location="../../../BusinessServices/VisionPlusPA/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/PWS/retiroTC/xsd/retiroTC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:retiroEfectivoTCResponse" location="../xsd/retiroEfectivoTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoTCTypes";
declare namespace ns2 = "http://www.procesa.com/fdcs/ot";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/retiroTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoTC/xq/retiroEfectivoTCOut/";

declare function xf:retiroEfectivoTCOut($onlinePaymentV4Response1 as element(ns2:OnlinePaymentV4Response),
    $outputParameters1 as element(ns1:OutputParameters),
    $dateTimeAut as xs:string,
    $dateTimeCore as xs:string)
    as element(ns0:retiroEfectivoTCResponse) {
         
         
        <ns0:retiroEfectivoTCResponse>
            <TRANSACTION_AUT>{ data($onlinePaymentV4Response1/AuthorizationCode) }</TRANSACTION_AUT>
            <DATETIME_AUT>{ data($dateTimeAut) }</DATETIME_AUT>
            <DATETIME_CORE>{ data($dateTimeCore) }</DATETIME_CORE>
            <REFERENCE_NUMBER>{ data($onlinePaymentV4Response1/RRN37) }</REFERENCE_NUMBER>
            <MESSAGES_CORE>
            {
            	let $controlError  := fn-bea:trim(string($outputParameters1/ns1:PV_CONTROL_ERROR/text()))  
            	let $mensajeError  := fn-bea:trim(string($outputParameters1/ns1:PV_MENSAJE_ERROR/text()))
            	return 
             	fn:concat($controlError,' ', $mensajeError) 
            }
            </MESSAGES_CORE>
        </ns0:retiroEfectivoTCResponse>
};

declare variable $onlinePaymentV4Response1 as element(ns2:OnlinePaymentV4Response) external;
declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $dateTimeAut as xs:string external;
declare variable $dateTimeCore as xs:string external;

xf:retiroEfectivoTCOut($onlinePaymentV4Response1,
    $outputParameters1,
    $dateTimeAut,
    $dateTimeCore)
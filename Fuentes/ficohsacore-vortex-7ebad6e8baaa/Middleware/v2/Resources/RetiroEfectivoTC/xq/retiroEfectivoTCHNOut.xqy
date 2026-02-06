xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$onlinePaymentV4Response" element="ns2:OnlinePaymentV4Response" location="../../../BusinessServices/VisionPlusHN/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../v3/BusinessServices/PAGOSWSTC/registraPagoTC/xsd/registraPagoTC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:retiroEfectivoTCResponse" location="../xsd/retiroEfectivoTCTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPagoTC";
declare namespace ns2 = "http://www.procesa.com/fdcs/ot";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoTC/xq/retiroEfectivoTCHNOut/";

declare function xf:retiroEfectivoTCHNOut($onlinePaymentV4Response as element(ns2:OnlinePaymentV4Response),
    $outputParameters as element(ns0:OutputParameters),
    $dateTimeAut as xs:string,
    $dateTimeCore as xs:string)
    as element(ns1:retiroEfectivoTCResponse) {
        <ns1:retiroEfectivoTCResponse>
            <TRANSACTION_AUT>{ data($onlinePaymentV4Response/AuthorizationCode) }</TRANSACTION_AUT>
            <DATETIME_AUT>{ $dateTimeAut }</DATETIME_AUT>
            <DATETIME_CORE>{ $dateTimeCore }</DATETIME_CORE>
            <REFERENCE_NUMBER>{ data($onlinePaymentV4Response/RRN37) }</REFERENCE_NUMBER>
            <MESSAGES_CORE>
            {
            	let $controlError  := fn-bea:trim(string($outputParameters/ns0:PV_PV_ERRORCODE/text()))  
            	let $mensajeError  := fn-bea:trim(string($outputParameters/ns0:PV_ERRORMESSAGE/text()))
            	return 
             	fn:concat($controlError,' ', $mensajeError) 
            }
            </MESSAGES_CORE>
        </ns1:retiroEfectivoTCResponse>
};

declare variable $onlinePaymentV4Response as element(ns2:OnlinePaymentV4Response) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $dateTimeAut as xs:string external;
declare variable $dateTimeCore as xs:string external;

xf:retiroEfectivoTCHNOut($onlinePaymentV4Response,
    $outputParameters,
    $dateTimeAut,
    $dateTimeCore)
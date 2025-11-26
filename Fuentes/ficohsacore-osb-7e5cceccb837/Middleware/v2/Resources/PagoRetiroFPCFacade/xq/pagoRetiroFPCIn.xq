(:: pragma bea:global-element-return element="ns0:pagoRetiroFPC" location="../../PagoRetiroFPC/xsd/pagoRetiroFPCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRetiroFPCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRetiroFPCFacade/xq/pagoRetiroFPCIn/";

declare function xf:pagoRetiroFPCIn($message as xs:string)
    as element(ns0:pagoRetiroFPC) {
        <ns0:pagoRetiroFPC>
	        {
	        	let $messageList := fn:tokenize($message,"@FM")
	        	return(
		        	<APPLICATION_NUMBER>{ $messageList[1] }</APPLICATION_NUMBER>,
	            	<CURRENCY>{ $messageList[2] }</CURRENCY>,
		            <AMOUNT>{ $messageList[3] }</AMOUNT>,
		            <USER_PAY>{ $messageList[4] }</USER_PAY>,
		            <DATE>{ xs:date($messageList[5]) }</DATE>,
		            <TRANSACTION>{ $messageList[6] }</TRANSACTION>,
		            <CODE_AGENCY>{ $messageList[7] }</CODE_AGENCY>,
		            <AGENCY_NAME>{ $messageList[8] }</AGENCY_NAME>
	            )
	        }
            
        </ns0:pagoRetiroFPC>
};

declare variable $message as xs:string external;

xf:pagoRetiroFPCIn($message)

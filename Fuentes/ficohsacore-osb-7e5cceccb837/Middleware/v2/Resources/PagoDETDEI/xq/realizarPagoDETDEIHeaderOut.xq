(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoDETDEI/xq/realizarPagoDETDEIHeaderOut/";

declare function xf:realizarPagoDETDEIHeaderOut($transactionID as xs:string, $MessageError as xs:string, $ErrorCode  as xs:string)
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	{
	        	if($transactionID != '') then(
	        		<transactionId>{$transactionID }</transactionId>
	        	) else()
	        }
            
        	{
            	if ($MessageError  = '')  then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<messageId>{ $ErrorCode  }</messageId>,
	            	    <successIndicator>ERROR</successIndicator>,
	                    <messages>{ $MessageError }</messages>
	            	) 
	        }
	        
        </ns1:ResponseHeader>
};

declare variable $transactionID as xs:string external;
declare variable $MessageError as xs:string external;
declare variable $ErrorCode as xs:string external;

xf:realizarPagoDETDEIHeaderOut($transactionID,$MessageError,$ErrorCode)
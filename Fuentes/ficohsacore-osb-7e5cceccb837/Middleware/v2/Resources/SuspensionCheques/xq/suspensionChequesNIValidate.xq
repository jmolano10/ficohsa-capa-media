(:: pragma bea:global-element-parameter parameter="$suspensionChequesRequest" element="ns0:suspensionChequesRequest" location="../xsd/suspensionChequesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/suspensionChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SuspensionCheques/xq/suspensionChequesNIValidate/";

declare function xf:suspensionChequesNIValidate($suspensionChequesRequest as element(ns0:suspensionChequesRequest))
    as xs:string {
        if (fn:string($suspensionChequesRequest/PAYMENT_STOP_MOTIVE/text())= "LOST" 
        	or fn:string($suspensionChequesRequest/PAYMENT_STOP_MOTIVE/text())= "STOLEN")then
        	xs:string("")
        else 
        	xs:string("INVALID VALUE FOR PAYMENT_STOP_MOTIVE")    	
};

declare variable $suspensionChequesRequest as element(ns0:suspensionChequesRequest) external;

xf:suspensionChequesNIValidate($suspensionChequesRequest)
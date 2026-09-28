(:: pragma bea:global-element-parameter parameter="$transaccionSubasta" element="ns0:transaccionSubasta" location="transaccionSubastaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transaccionSubastaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/transaccionSubasta/transaccionSubastaValidateRequired/";

declare function xf:transaccionSubastaValidateRequired($transaccionSubasta as element(ns0:transaccionSubasta))
    as xs:string {
        if (fn:string($transaccionSubasta/DEBIT_ACCOUNT/text()) = "" or 
        	fn:string($transaccionSubasta/TRANSACTION_AMOUNT/text()) = "" or 
        	fn:string($transaccionSubasta/TRANSACTION_TYPE/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"

        ) else if (not(fn:string($transaccionSubasta/TRANSACTION_TYPE/text()) = ("ACCTTRF","INTLTRF","CASHCHQ"))) then (
        	"UNSUPPORTED TRANSACTION_TYPE"
        	        	
        ) else if (not(fn:string($transaccionSubasta/PROCESS_YES_NO/text()) = ("","YES","NO"))) then (
        	"UNSUPPORTED PROCESS_YES_NO"

		) else if (not(fn:string($transaccionSubasta/AUCTION_RATE_TYPE/text()) = ("MIN","MAX","MAN","AVG",""))) then (
			"UNSUPPORTED AUCTION_RATE_TYPE"
		 
		) else if (fn:string($transaccionSubasta/AUCTION_RATE_TYPE/text()) = "MAN" and
					fn:string($transaccionSubasta/SUGGESTED_RATE/text()) = "") then (
			"SUGGESTED_RATE IS REQUIRED WHEN AUCTION_RATE_TYPE IS *MAN*"

		) else if (fn:string($transaccionSubasta/SUGGESTED_RATE) != "" and fn:string(number($transaccionSubasta/SUGGESTED_RATE)) = "NaN") then (
			"SUGGESTED_RATE MUST BE NUMERIC VALUE"
								        	
        ) else (
        	""
        )
};

declare variable $transaccionSubasta as element(ns0:transaccionSubasta) external;

xf:transaccionSubastaValidateRequired($transaccionSubasta)
(:: pragma bea:global-element-parameter parameter="$consultaSolicitudSubasta" element="ns0:consultaSolicitudSubasta" location="consultaSolicitudSubastaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSolicitudSubastaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/subasta/consultaSolicitudSubasta/consultaSolicitudSubastaValidate/";

declare function xf:consultaSolicitudSubastaValidate($consultaSolicitudSubasta as element(ns0:consultaSolicitudSubasta))
    as xs:string {
        if (fn:string($consultaSolicitudSubasta/CUSTOMER_ID/text()) = "") then (
            "REQUIRED FIELDS NOT SUPPLIED"
        ) else if (not(fn:string($consultaSolicitudSubasta/AUCTION_STATUS/text()) = ("PREAUCTION","INAUCTION","POSTAUCTION",""))) then (
                "UNSUPPORT AUCTION_STATUS"
        ) else (
        	""
        )
};

declare variable $consultaSolicitudSubasta as element(ns0:consultaSolicitudSubasta) external;

xf:consultaSolicitudSubastaValidate($consultaSolicitudSubasta)
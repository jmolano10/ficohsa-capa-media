(:: pragma bea:global-element-parameter parameter="$procesaMensajeFicocel" element="ns0:procesaMensajeFicocel" location="procesaMensajeFicocelTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeFicocelTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelTransacciones/ProcesaMensajeFicocel/procesaMensajeFicocelValidateRequired/";

declare function xf:procesaMensajeFicocelValidateRequired($procesaMensajeFicocel as element(ns0:procesaMensajeFicocel))
    as xs:boolean {
        if ( fn:string($procesaMensajeFicocel/MOBILE_NUMBER/text()) != "" and 
        	 fn:string($procesaMensajeFicocel/KEYWORD/text()) != "") then (
        	xs:boolean("1")	 
       	) else (
       		xs:boolean("0")
       	)
};

declare variable $procesaMensajeFicocel as element(ns0:procesaMensajeFicocel) external;

xf:procesaMensajeFicocelValidateRequired($procesaMensajeFicocel)
(:: pragma bea:global-element-parameter parameter="$registroBitacoraConvenio" element="ns0:registroBitacoraConvenio" location="../../xsds/RegistroBitacoraConvenio/RegistroBitacoraConvenio.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraConvenioTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistroBitacoraConvenio/RegistroBitacoraConvenioValidate/";

declare function xf:RegistroBitacoraConvenioValidate($registroBitacoraConvenio as element(ns0:registroBitacoraConvenio))
    as xs:string {
        let $LOG_UUID := fn:string($registroBitacoraConvenio/LOG_UUID/text())
        let $LOG_TYPE := fn:string($registroBitacoraConvenio/LOG_TYPE/text())
        return
        	if ($LOG_UUID = "" or $LOG_TYPE = "") then (
        		"LOG_UUID AND LOG_TYPE ARE REQUIRED"
        	
        	) else if (not($LOG_TYPE = ("REQUEST","RESPONSE"))) then (
        		"INVALID LOG_TYPE. ALLOWED VALUES (REQUEST, RESPONSE)"
        	
        	) else (
        		""
        		
        	)
};

declare variable $registroBitacoraConvenio as element(ns0:registroBitacoraConvenio) external;

xf:RegistroBitacoraConvenioValidate($registroBitacoraConvenio)
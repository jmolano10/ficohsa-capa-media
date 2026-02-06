xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCompletaInscripcion" element="ns0:consultaCompletaInscripcion" location="../../InscripcionesRNP/xsd/inscripcionesRNPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaCompletaInscripcion" location="../../../BusinessServices/RNP/consultaCompletaInscripcion/xsd/consultaCompletaInscripcionTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/inscripcionesRNPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCompletaInscripcionRNP/xq/consultaCompletaInscripcionRNPIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
};
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
};

declare function xf:consultaCompletaInscripcionRNPIn($requestHeader as element(ns1:RequestHeader),
    $consultaCompletaInscripcion as element(ns0:consultaCompletaInscripcion),
    $institutionId as xs:string,
    $serviceAcctSecurityCode as xs:string)
    as element(ns0:consultaCompletaInscripcion) {
        <ns0:consultaCompletaInscripcion>
            <LEGAL_ID>{ data($consultaCompletaInscripcion/LEGAL_ID) }</LEGAL_ID>
            <INSTITUTION_ID>{ $institutionId }</INSTITUTION_ID>
            <SECURITY_CODE>
            {             	
            	fn-bea:fail-over( getPassword($serviceAcctSecurityCode),
                        data($requestHeader/Authentication/Password))
            }
            </SECURITY_CODE>
            {
                for $INSTITUTION_USER_ID in $consultaCompletaInscripcion/INSTITUTION_USER_ID
                return
                    <INSTITUTION_USER_ID>{ data($INSTITUTION_USER_ID) }</INSTITUTION_USER_ID>
            }
        </ns0:consultaCompletaInscripcion>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $consultaCompletaInscripcion as element(ns0:consultaCompletaInscripcion) external;
declare variable $institutionId as xs:string external;
declare variable $serviceAcctSecurityCode as xs:string external;

xf:consultaCompletaInscripcionRNPIn($requestHeader,
    $consultaCompletaInscripcion,
    $institutionId,
    $serviceAcctSecurityCode)
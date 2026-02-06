xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$reprocesoACHEnviadasCR" element="ns1:reprocesoACHEnviadasCR" location="../xsd/reprocesoACHEnviadasCRTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ReprocesarACHEnviados" location="../../../BusinessServices/ACH/Enviado/SvcACHEnviado/xsd/XMLSchema_-1255526967.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reprocesoACHEnviadasCRTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHEnviadasCR/xq/reprocesoACHEnviadosIn/";

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

declare function xf:reprocesoACHEnviadosIn($requestHeader1 as element(ns2:RequestHeader),
	$reprocesoACHEnviadasCR as element(ns1:reprocesoACHEnviadasCR),
    $isReprocess as xs:string,
    $stage as xs:string)
    as element(ns0:ReprocesarACHEnviados) {
        <ns0:ReprocesarACHEnviados>
        	<WebRequestCommon>
                <userName>
	                {
	                    fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)),
	                    	data($requestHeader1/Authentication/UserName))
	                }
				</userName>
                <password>
	                {
	                    fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
	                    	data($requestHeader1/Authentication/Password))
	                }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOHNACHONLINEREPROCESSWSType id = "{ data($reprocesoACHEnviadasCR/T24_CONTROL_REF) }">
                {
                    for $PXP_BATCH_REF in $reprocesoACHEnviadasCR/PXP_BATCH_REF
                    return
                        <GLOBALREFERENCE>{ data($PXP_BATCH_REF) }</GLOBALREFERENCE>
                }
                {
                    for $PXP_ID_TXN_REF in $reprocesoACHEnviadasCR/PXP_ID_TXN_REF
                    return
                        <LEGENDBANKISSUER>{ data($PXP_ID_TXN_REF) }</LEGENDBANKISSUER>
                }
                <ISREPROCESS>{ $isReprocess }</ISREPROCESS>
                <STAGE>{ $stage }</STAGE>
                {
                    for $STATUS in $reprocesoACHEnviadasCR/STATUS
                    return
                        <PXPRESULT>{ data($STATUS) }</PXPRESULT>
                }
                {
                    for $ERROR_CODE in $reprocesoACHEnviadasCR/ERROR_CODE,
                        $ERROR_MESSAGE in $reprocesoACHEnviadasCR/ERROR_MESSAGE
                    return
                        <PXPERRORCODE>{ fn:replace(fn:substring(fn:concat($ERROR_CODE, '-', $ERROR_MESSAGE), 1, 150), '(\:|\[|\]|\\|\||\"|\^|\$|\?|\*|\_|\-|\+|\{|\}|\(|\))', '.') }</PXPERRORCODE>
                }
            </FICOHNACHONLINEREPROCESSWSType>
        </ns0:ReprocesarACHEnviados>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $reprocesoACHEnviadasCR as element(ns1:reprocesoACHEnviadasCR) external;
declare variable $isReprocess as xs:string external;
declare variable $stage as xs:string external;

xf:reprocesoACHEnviadosIn($requestHeader1,
	$reprocesoACHEnviadasCR,
    $isReprocess,
    $stage)
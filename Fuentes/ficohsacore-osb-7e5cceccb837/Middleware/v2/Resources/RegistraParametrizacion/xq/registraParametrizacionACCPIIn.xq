(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registraParametrizacion" element="ns2:registraParametrizacion" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RegistraParametrizacionBancosACCPI" location="../../../BusinessServices/T24/RegistraParametrizacionBancosACCPI/xsd/registraParametrizacionBancosACCPI.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraParametrizacion/xq/registraParametrizacionACCPIIn/";

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
 
declare function xf:registraParametrizacionACCPIIn($requestHeader1 as element(ns0:RequestHeader),
    $registraParametrizacion as element(ns2:registraParametrizacion))
    as element(ns1:RegistraParametrizacionBancosACCPI) {
        <ns1:RegistraParametrizacionBancosACCPI>
            <WebRequestCommon>
                 <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                 <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
	            <gtsControl/>
	            <messageId/>
	            <noOfAuth/>
	            <replace/>
            </OfsFunction>          
            <FICOACCOUNTSPIINPUTWSType id = "{ data($registraParametrizacion/ID_CEPROBAN) }">
                <gCURRENCY>
                    {
                        for $ACCOUNTS in $registraParametrizacion/ACCOUNTS
                        return
                            <mCURRENCY>
                                <CURRENCY>{ data($ACCOUNTS/CURRENCY) }</CURRENCY>
                                <INTERACC>{ data($ACCOUNTS/INTER_ACCOUNT) }</INTERACC>
                                <CUSTOMERACC>{ data($ACCOUNTS/CUSTOMER_ACCOUNT) }</CUSTOMERACC>
                            </mCURRENCY>
                    }
                </gCURRENCY>
            </FICOACCOUNTSPIINPUTWSType>
        </ns1:RegistraParametrizacionBancosACCPI>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;
declare variable $registraParametrizacion as element(ns2:registraParametrizacion) external;

xf:registraParametrizacionACCPIIn($requestHeader1,
    $registraParametrizacion)

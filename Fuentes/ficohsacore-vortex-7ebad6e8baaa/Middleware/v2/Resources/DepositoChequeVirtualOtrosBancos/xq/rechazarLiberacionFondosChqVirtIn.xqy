xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registrarChequeOtroBcoVirtualResponse" element="ns1:registrarChequeOtroBcoVirtualResponse" location="../../../BusinessServices/SACE/WS-QUICKDEPOSIT.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:RechazarLiberacionFondosChqVirt" location="../../../../Business_Resources/compensacion/resources/XMLSchema_1569843523.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoChequeVirtualOtrosBancos/xq/rechazarLiberacionFondosChqVirtIn/";

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

declare function xf:rechazarLiberacionFondosChqVirtIn($requestHeader as element(ns2:RequestHeader),
    $registrarChequeOtroBcoVirtualResponse as element(ns1:registrarChequeOtroBcoVirtualResponse),
    $id as xs:string)
    as element(ns0:RechazarLiberacionFondosChqVirt) {
        <ns0:RechazarLiberacionFondosChqVirt>
            <WebRequestCommon>
                <userName>
                {
                    fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                    data($requestHeader/Authentication/UserName))
                }
				</userName>
                <password>
                {
                    fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                    data($requestHeader/Authentication/Password))
                }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOHCHEQUEVIRTUALRECHAZOWSType id = "{ $id }">
                <CODIGORECHAZO>{ data($registrarChequeOtroBcoVirtualResponse/ns1:registrarChequeOtroBcoVirtualResult/ns1:errId) }</CODIGORECHAZO>
                {
                    for $errMsg in $registrarChequeOtroBcoVirtualResponse/ns1:registrarChequeOtroBcoVirtualResult/ns1:errMsg
                    return
                        <RAZONRECHAZO>{ data($errMsg) }</RAZONRECHAZO>
                }
            </FICOHCHEQUEVIRTUALRECHAZOWSType>
        </ns0:RechazarLiberacionFondosChqVirt>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $registrarChequeOtroBcoVirtualResponse as element(ns1:registrarChequeOtroBcoVirtualResponse) external;
declare variable $id as xs:string external;

xf:rechazarLiberacionFondosChqVirtIn($requestHeader,
    $registrarChequeOtroBcoVirtualResponse,
    $id)
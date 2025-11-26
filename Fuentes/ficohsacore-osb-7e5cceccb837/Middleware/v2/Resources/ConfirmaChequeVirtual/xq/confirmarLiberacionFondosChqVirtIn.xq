(:: pragma bea:global-element-parameter parameter="$confirmaChequeVirtual" element="ns2:confirmaChequeVirtual" location="../xsd/confirmaChequeVirtualTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConfirmarLiberacionFondosChqVirt" location="../../../../Business_Resources/compensacion/resources/XMLSchema_1569843523.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/confirmaChequeVirtualTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmaChequeVirtual/xq/confirmarLiberacionFondosChqVirtIn/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

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

declare function xf:confirmarLiberacionFondosChqVirtIn($confirmaChequeVirtual as element(ns2:confirmaChequeVirtual),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns1:ConfirmarLiberacionFondosChqVirt) {
        <ns1:ConfirmarLiberacionFondosChqVirt>
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
            <FICOHCHEQUEVIRTUALCONFIRMACIONWSType id = "{ data($confirmaChequeVirtual/ID_RECORD_REF) }">
                <CODIGORECHAZO>{ data($confirmaChequeVirtual/REJECTED_CODE) }</CODIGORECHAZO>
                <RAZONRECHAZO>{ data($confirmaChequeVirtual/REJECTED_REASON) }</RAZONRECHAZO>
            </FICOHCHEQUEVIRTUALCONFIRMACIONWSType>
        </ns1:ConfirmarLiberacionFondosChqVirt>
};

declare variable $confirmaChequeVirtual as element(ns2:confirmaChequeVirtual) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:confirmarLiberacionFondosChqVirtIn($confirmaChequeVirtual,
    $requestHeader)
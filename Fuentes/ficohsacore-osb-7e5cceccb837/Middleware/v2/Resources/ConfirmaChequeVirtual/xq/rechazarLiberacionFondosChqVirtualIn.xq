(:: pragma bea:global-element-parameter parameter="$confirmaChequeVirtual" element="ns1:confirmaChequeVirtual" location="../xsd/confirmaChequeVirtualTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConfirmaChequeVirtual" location="../../../../Business_Resources/compensacion/RechazaChequeVirtual/RechazaChequeVirtualTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/confirmaChequeVirtualTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmaChequeVirtual/xq/rechazarLiberacionFondosChqVirtualIn/";
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

declare function xf:rechazarLiberacionFondosChqVirtualIn($confirmaChequeVirtual as element(ns1:confirmaChequeVirtual),
    $requestHeader as element(ns2:RequestHeader))
    as element(ns0:ConfirmaChequeVirtual) {
        <ns0:ConfirmaChequeVirtual>
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
            <FICOHCHEQUEVIRTUALRECHAZOWSType id = "{ data($confirmaChequeVirtual/ID_RECORD_REF) }">
                <CODIGORECHAZO>{ data($confirmaChequeVirtual/REJECTED_CODE) }</CODIGORECHAZO>
                {
                    for $REJECTED_REASON in $confirmaChequeVirtual/REJECTED_REASON
                    return
                        <RAZONRECHAZO>{ data($REJECTED_REASON) }</RAZONRECHAZO>
                }
                {
                    for $COMISION in $confirmaChequeVirtual/COMISION
                    return
                        <COMISION>{ data($COMISION) }</COMISION>
                }
            </FICOHCHEQUEVIRTUALRECHAZOWSType>
        </ns0:ConfirmaChequeVirtual>
};

declare variable $confirmaChequeVirtual as element(ns1:confirmaChequeVirtual) external;
declare variable $requestHeader as element(ns2:RequestHeader) external;

xf:rechazarLiberacionFondosChqVirtualIn($confirmaChequeVirtual,
    $requestHeader)
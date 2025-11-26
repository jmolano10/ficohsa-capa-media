(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$solicitudTarjetaDebito" element="ns0:solicitudTarjetaDebito" location="../xsd/solicitudTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:CreaciondeTDNueva" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudTarjetaDebitoTypes";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudTarjetaDebito/xq/CreaciondeTDNuevaIn/";

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

declare function xf:CreaciondeTDNuevaIn($requestHeader as element(ns1:RequestHeader),
    $recordName as xs:string,
    $solicitudTarjetaDebito as element(ns0:solicitudTarjetaDebito),
    $ProductType as xs:string)
    as element(ns2:CreaciondeTDNueva) {
        <ns2:CreaciondeTDNueva>
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
            <FICOBULKAPPRCLNTINPUTTDWSType id = "{ $recordName }">
                <TDCODID>{ concat($ProductType,".", data($solicitudTarjetaDebito/CARD_NUMBER)) }</TDCODID>
                <CUSTOMER>{ data($solicitudTarjetaDebito/CUSTOMER_CODE) }</CUSTOMER>
                <PRIMARYACCT>{ data($solicitudTarjetaDebito/PRIMARY_ACCOUNT) }</PRIMARYACCT>
                <TOAGENCY>{ data($solicitudTarjetaDebito/USER_BRANCH_CODE) }</TOAGENCY>
                <LRREEMISIONTD>{ data($solicitudTarjetaDebito/EMISSION_PAY) }</LRREEMISIONTD>
                <USERID>{ data($solicitudTarjetaDebito/INTERFACE_USER) }</USERID>
            </FICOBULKAPPRCLNTINPUTTDWSType>
        </ns2:CreaciondeTDNueva>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $recordName as xs:string external;
declare variable $solicitudTarjetaDebito as element(ns0:solicitudTarjetaDebito) external;
declare variable $ProductType as xs:string external;

xf:CreaciondeTDNuevaIn($requestHeader,
    $recordName,
    $solicitudTarjetaDebito,
    $ProductType)

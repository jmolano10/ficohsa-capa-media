xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/XMLSchema_-193201527.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/transactionReversalTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transactionReversalTypes.xsd" ::)

declare namespace xq = "http://www.w3.org/2005/xquery-local-functions";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

declare variable $user as xs:string external;
declare variable $password as xs:string external;
declare variable $transactionReversalRequest as element() (:: schema-element(ns1:transactionReversalRequest) ::) external;

(: Función encargada de realizar el mapeo de usuario:)
declare function xq:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
};

(: Función encargada de realizar el mapeo de contraseña:)
declare function xq:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
};

declare function local:func($user as xs:string, 
                            $password as xs:string, 
                            $transactionReversalRequest as element() (:: schema-element(ns1:transactionReversalRequest) ::)) 
                            as element() (:: schema-element(ns2:ReversiondetransaccionFT) ::) {
    <ns2:ReversiondetransaccionFT>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($user)),data($user)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($user)),data($password)) }</password>
            <company></company>
        </WebRequestCommon>
        <FUNDSTRANSFERREVERSEType>
            <transactionId>{fn:data($transactionReversalRequest/ns1:transactionId)}</transactionId>
        </FUNDSTRANSFERREVERSEType>
    </ns2:ReversiondetransaccionFT>
};

local:func($user, $password, $transactionReversalRequest)

(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns2:TransferenciaACH" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/transferenciasACHIn/";

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

declare function xf:transferenciasACHIn($requestHeader as element(ns1:RequestHeader),
    $transferenciasACHRequest as element(ns0:transferenciasACHRequest),
    $uuid as xs:string)
    as element(ns2:TransferenciaACH) {
        <ns2:TransferenciaACH>
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
                <messageId>{ $uuid }</messageId>
                <noOfAuth>1</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERFICOHACHORIGINATIONType id = "">
                <DEBITACCOUNT>{ data($transferenciasACHRequest/DEBIT_ACCOUNT) }</DEBITACCOUNT>
                <DEBITAMOUNT>{ data($transferenciasACHRequest/TRANSFER_AMOUNT) }</DEBITAMOUNT>
                <CREDITCURRENCY>{ data($transferenciasACHRequest/CREDIT_CURRENCY) }</CREDITCURRENCY>
                <LRBANKCODE>{ data($transferenciasACHRequest/DESTINATION_BANK) }</LRBANKCODE>
                <LRBENPAYACCT>{ data($transferenciasACHRequest/CREDIT_ACCOUNT) }</LRBENPAYACCT>
                <LRNARADDEND>{ substring(fn:string($transferenciasACHRequest/TRANSACTION_DESCRIPTION/text()),1,60) }</LRNARADDEND>
                <LRPAYACHTYPE>{ data($transferenciasACHRequest/ACCOUNT_TYPE) }</LRPAYACHTYPE>
       			<LRREFTXN>{ data($transferenciasACHRequest/INTERFACE_REFERENCE_NO) }</LRREFTXN>
            </FUNDSTRANSFERFICOHACHORIGINATIONType>
        </ns2:TransferenciaACH>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $transferenciasACHRequest as element(ns0:transferenciasACHRequest) external;
declare variable $uuid as xs:string external;

xf:transferenciasACHIn($requestHeader,
    $transferenciasACHRequest,
    $uuid)
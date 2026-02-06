xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$transactionDetail" type="ns0:transactionDetail" location="../xsd/transferenciasACHDebitosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RegistrodeACHDebitos" location="../../../BusinessServices/T24/ACHRecibidas/xsd/XMLSchema_478367602.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHDebitosTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHDebitos/xq/registroACHDebitoIn/";

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

declare function xf:registroACHDebitoIn($requestHeader as element(ns0:RequestHeader),
    $transactionDetail as element(),
    $globalReference as xs:string)
    as element(ns1:RegistrodeACHDebitos) {
        <ns1:RegistrodeACHDebitos>
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
            <FICOHNDEBACHINPUTType>
                <DEBITACCTNO>{ fn:substring(data($transactionDetail/DESTINATION), 1, 40) }</DEBITACCTNO>
                {
                    for $ACCOUNT in $transactionDetail/ORIGINATOR_INFO/ACCOUNT
                    return
                        <CREDITACCTNO>{ fn:substring(data($ACCOUNT),1,40) }</CREDITACCTNO>
                }
                <CREDITCCY>{ data($transactionDetail/CURRENCY) }</CREDITCCY>
                <AMOUNT>{ data($transactionDetail/AMOUNT) }</AMOUNT>
                <GLOBALREFERENCE>{ $globalReference }</GLOBALREFERENCE>
                <IDBANKISSUER>{ fn:substring(fn:replace(fn:substring(data($transactionDetail/ORIGINATOR_INFO/BANK_ID), 6, 2), '^0*(..*)', '$1'), 1, 20) }</IDBANKISSUER>
                {
                    for $REFERENCE_NUMBER in $transactionDetail/ORIGINATOR_INFO/REFERENCE_NUMBER
                    return
                        <LEGENDBANKISSUER>{ data($REFERENCE_NUMBER) }</LEGENDBANKISSUER>
                }
                <IDPRODUCT>{ fn:substring(data($transactionDetail/DESTINATION), 1, 30) }</IDPRODUCT>
                <TIPOTRANS>{ fn:substring(fn:replace(data($transactionDetail/TRANSACTION_TYPE), "_", "."), 1, 35) }</TIPOTRANS>
                <STATUS>PENDING</STATUS>
                {
                    for $CUSTOMER_NAME in $transactionDetail/ORIGINATOR_INFO/CUSTOMER_NAME
                    return
                        <CUSNAME>{ fn:substring(data($CUSTOMER_NAME), 1, 35) }</CUSNAME>
                }
                <ACHTXNTYPE>ACHIN</ACHTXNTYPE>
                <TXNACHINTYPE>{ fn:substring(fn:replace(fn:substring(data($transactionDetail/ORIGINATOR_INFO/BANK_ID), 6, 2),'^0*(..*)', '$1'), 1, 20) }</TXNACHINTYPE>
                <LRCONTRACTACH>{ data($transactionDetail/CONTRACT_ID) }</LRCONTRACTACH>
            </FICOHNDEBACHINPUTType>
        </ns1:RegistrodeACHDebitos>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $transactionDetail as element() external;
declare variable $globalReference as xs:string external;

xf:registroACHDebitoIn($requestHeader,
    $transactionDetail,
    $globalReference)
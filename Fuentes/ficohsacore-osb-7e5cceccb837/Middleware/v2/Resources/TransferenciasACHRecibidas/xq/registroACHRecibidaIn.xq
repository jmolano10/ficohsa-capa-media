(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRecibidas" element="ns0:transferenciasACHRecibidas" location="../xsd/transferenciasACHRecibidasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RegistrarACHRecibidos" location="../../../BusinessServices/ACH/Recibido/SvcACHRecibido/xsd/XMLSchema_478367602.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHRecibidasTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/registroACHRecibidaIn/";

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

declare function xf:registroACHRecibidaIn($requestHeader1 as element(ns2:RequestHeader),
    $transferenciasACHRecibidas as element(ns0:transferenciasACHRecibidas),
    $customerId as xs:string,
    $idProduct as xs:string,
    $tcccy as xs:string,
    $tcCurrentAmt as xs:string,
    $customerName as xs:string,
    $account as xs:string,
    $description as xs:string)
    as element(ns1:RegistrarACHRecibidos) {
        let $transactionDetail := $transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]
        return
            <ns1:RegistrarACHRecibidos>
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
                <FICOHNACHONLINEINPUTACHINType>
                    <DEBITACCTNO>{ $account }</DEBITACCTNO>
                    <CREDITACCTNO>{ data($transactionDetail/DESTINATION) }</CREDITACCTNO>
                    <CREDITCCY>{ data($transactionDetail/CURRENCY) }</CREDITCCY>
                    <CUSTOMERID>{ $customerId }</CUSTOMERID>
                    <AMOUNT>{ fn-bea:decimal-truncate(xs:decimal(data($transactionDetail/AMOUNT)), 2) }</AMOUNT>
                    <GLOBALREFERENCE>{ data($transferenciasACHRecibidas/GLOBAL_REFERENCE) }</GLOBALREFERENCE>
                    <IDBANKISSUER>{ substring(data($transactionDetail/ORIGINATOR_INFO/BANK_ID),6,2) }</IDBANKISSUER>
                    {
                        for $REFERENCE_NUMBER in $transactionDetail/ORIGINATOR_INFO/REFERENCE_NUMBER
                        return
                            <LEGENDBANKISSUER>{ data($REFERENCE_NUMBER) }</LEGENDBANKISSUER>
                    }
                    <IDPRODUCT>{ $idProduct }</IDPRODUCT>
                    <TIPOTRANS>{ replace(data($transactionDetail/TRANSACTION_TYPE),'_','.') }</TIPOTRANS>
                    <NARADDEND>{ fn:substring($description, 1, 34) }</NARADDEND>
                    <CUSNAME>{ fn:replace(fn:substring($customerName, 1, 34), '(\:|\[|\]|\\|\/|\||\"|\^|\,|\$|\?|\*|\+|\{|\}|\(|\))', '.') }</CUSNAME>
                    <ACHTXNTYPE>ACHIN</ACHTXNTYPE>
                    <TCCCY>{ $tcccy }</TCCCY>
                    <TCCURRENTAMT>{ $tcCurrentAmt }</TCCURRENTAMT>
                </FICOHNACHONLINEINPUTACHINType>
            </ns1:RegistrarACHRecibidos>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $transferenciasACHRecibidas as element(ns0:transferenciasACHRecibidas) external;
declare variable $customerId as xs:string external;
declare variable $idProduct as xs:string external;
declare variable $tcccy as xs:string external;
declare variable $tcCurrentAmt as xs:string external;
declare variable $customerName as xs:string external;
declare variable $account as xs:string external;
declare variable $description as xs:string external;

xf:registroACHRecibidaIn($requestHeader1,
    $transferenciasACHRecibidas,
    $customerId,
    $idProduct,
    $tcccy,
    $tcCurrentAmt,
    $customerName,
    $account,
    $description)
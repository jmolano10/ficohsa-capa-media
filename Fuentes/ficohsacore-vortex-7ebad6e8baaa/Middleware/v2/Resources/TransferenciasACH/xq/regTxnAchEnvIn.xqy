xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns1:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$wSCUSTOMERType1" type="ns0:ConsultadeclienteResponse/WSCUSTOMERType" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RegistroACHRecibida" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/regTxnAchEnvIn/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:regTxnAchEnvIn($requestHeader1 as element(ns2:RequestHeader),
    $responseHeader1 as element(ns2:ResponseHeader),
    $transferenciasACHRequest1 as element(ns1:transferenciasACHRequest),
    $wSCUSTOMERType1 as element(),
    $customerId as xs:string,
    $achType as xs:string,
    $transactionType as xs:string)
    as element(ns0:RegistroACHRecibida) {
        <ns0:RegistroACHRecibida>
        	 <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth>0</noOfAuth>
                <replace/>
            </OfsFunction>
            <FICOHNACHONLINEINPUTType>
                <DEBITACCTNO>{ data($transferenciasACHRequest1/DEBIT_ACCOUNT) }</DEBITACCTNO>
                <CREDITACCTNO>{ data($transferenciasACHRequest1/CREDIT_ACCOUNT) }</CREDITACCTNO>
                <CREDITCCY>{ data($transferenciasACHRequest1/CREDIT_CURRENCY) }</CREDITCCY>
                <CUSTOMERID>{ $customerId }</CUSTOMERID>
                <AMOUNT>{ data($transferenciasACHRequest1/TRANSFER_AMOUNT) }</AMOUNT>
                <IDBANKISSUER>{ data($transferenciasACHRequest1/DESTINATION_BANK) }</IDBANKISSUER>
                {
                    for $transactionId in $responseHeader1/transactionId
                    return
                        <IDTXNT24>{ data($transactionId) }</IDTXNT24>
                }
                <TIPOTRANS>{ $transactionType }</TIPOTRANS>
                <STATUS>PENDING</STATUS>
                <DESTCUSTOMERID>{ data($transferenciasACHRequest1/BENEFICIARY_ID) }</DESTCUSTOMERID>
                <NARADDEND>{ data($transferenciasACHRequest1/TRANSACTION_DESCRIPTION) }</NARADDEND>
                <CUSNAME>{ data($transferenciasACHRequest1/BENEFICIARY_NAME) }</CUSNAME>
                <ACHTXNTYPE>{ $achType }</ACHTXNTYPE>
            </FICOHNACHONLINEINPUTType>
        </ns0:RegistroACHRecibida>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $responseHeader1 as element(ns2:ResponseHeader) external;
declare variable $transferenciasACHRequest1 as element(ns1:transferenciasACHRequest) external;
declare variable $wSCUSTOMERType1 as element() external;
declare variable $customerId as xs:string external;
declare variable $achType as xs:string external;
declare variable $transactionType as xs:string external;

xf:regTxnAchEnvIn($requestHeader1,
    $responseHeader1,
    $transferenciasACHRequest1,
    $wSCUSTOMERType1,
    $customerId,
    $achType,
    $transactionType)
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciaACHResponse1" element="ns0:TransferenciaACHResponse" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns1:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RegistroACHRecibida" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/regTxAchEnvIn/";

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

declare function xf:regTxAchEnvIn($requestHeader1 as element(ns2:RequestHeader),
    $transferenciaACHResponse1 as element(ns0:TransferenciaACHResponse),
    $transferenciasACHRequest1 as element(ns1:transferenciasACHRequest),
    $customerId as xs:string,
    $achType as xs:string,
    $transactionType as xs:string,
    $status as xs:string,
    $idRejection as xs:string)
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
            <FICOHNACHONLINEINPUTType id="A1">
                <DEBITACCTNO>{ fn:substring(data($transferenciasACHRequest1/DEBIT_ACCOUNT),1,40) }</DEBITACCTNO>
                <CREDITACCTNO>{ fn:substring(data($transferenciasACHRequest1/CREDIT_ACCOUNT),1,40) }</CREDITACCTNO>
                <CREDITCCY>{ data($transferenciasACHRequest1/CREDIT_CURRENCY) }</CREDITCCY>
                <CUSTOMERID>{ $customerId }</CUSTOMERID>
                <AMOUNT>{ data($transferenciasACHRequest1/TRANSFER_AMOUNT) }</AMOUNT>
                <IDBANKISSUER>{ fn:substring(data($transferenciasACHRequest1/DESTINATION_BANK),1,20) }</IDBANKISSUER>
                <IDPRODUCT>{ fn:substring(data($transferenciasACHRequest1/ACCOUNT_TYPE),1,30) }</IDPRODUCT>
                {
                    for $transactionId in $transferenciaACHResponse1/Status/transactionId
                    return
                        <IDTXNT24>{ data($transactionId) }</IDTXNT24>
                }
                <TIPOTRANS>{ $transactionType }</TIPOTRANS>
                {
                	let $indicator := data($status)
                	return
	                	<IDREJECTION>
	                	{
	                		if ($indicator = "SUCCESS") then
	                			''
	                		elseif ($indicator = "PENDING") then
	                			''
	                		elseif ($indicator = "REJECTED") then
	                			$idRejection
	                		else
	                			$idRejection
	                	}
	                	</IDREJECTION>
               	}
               	{
                	let $indicator := data($status)
                	return
	                	<STATUS>
	                	{
	                		if ($indicator = "ERROR") then
	                			'REJECTED'
	                		else 
	                			$indicator
	                	}
	                	</STATUS>
                } 
                (:<STATUS>PENDING</STATUS>:)
                <DESTCUSTOMERID>{ fn:substring(data($transferenciasACHRequest1/BENEFICIARY_ID),1,20) }</DESTCUSTOMERID>
                <NARADDEND>{ fn:substring(data($transferenciasACHRequest1/TRANSACTION_DESCRIPTION),1,35) }</NARADDEND>
                <CUSNAME>{ fn:substring(data($transferenciasACHRequest1/BENEFICIARY_NAME),1,35) }</CUSNAME>
                <ACHTXNTYPE>{ $achType }</ACHTXNTYPE>
            </FICOHNACHONLINEINPUTType>
        </ns0:RegistroACHRecibida>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $transferenciaACHResponse1 as element(ns0:TransferenciaACHResponse) external;
declare variable $transferenciasACHRequest1 as element(ns1:transferenciasACHRequest) external;
declare variable $customerId as xs:string external;
declare variable $achType as xs:string external;
declare variable $transactionType as xs:string external;
declare variable $status as xs:string external;
declare variable $idRejection as xs:string external;

xf:regTxAchEnvIn($requestHeader1,
    $transferenciaACHResponse1,
    $transferenciasACHRequest1,
    $customerId,
    $achType,
    $transactionType,
    $status,
    $idRejection)
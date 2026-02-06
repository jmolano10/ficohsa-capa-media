xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$RequestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$ModelBankResponse" element="ns2:TransfmodelbankentrecuentasResponse" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$ACHRequest" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns2:RegistroACHRecibida" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/ProgramadasTxAchEnvIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";

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


declare function xf:ProgramadasTxAchEnvIn($RequestHeader as element(ns1:RequestHeader),
    $ModelBankResponse as element(ns2:TransfmodelbankentrecuentasResponse),
    $ACHRequest as element(ns0:transferenciasACHRequest),
    $CustomerID as xs:string,
    $ACHType as xs:string,
    $TransactionType as xs:string,
    $Status as xs:string,
    $IDRejection as xs:string)
    as element(ns2:RegistroACHRecibida) {

        
        <ns2:RegistroACHRecibida>
        	 <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($RequestHeader/Authentication/UserName)), 
												data($RequestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($RequestHeader/Authentication/UserName)),
                								data($RequestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId/>
                <noOfAuth>0</noOfAuth>
                <replace/>
            </OfsFunction>
            <FICOHNACHONLINEINPUTType id="A1">
                <DEBITACCTNO>{ fn:substring(data($ACHRequest/DEBIT_ACCOUNT),1,40) }</DEBITACCTNO>
                <CREDITACCTNO>{ fn:substring(data($ACHRequest/CREDIT_ACCOUNT),1,40) }</CREDITACCTNO>
                <CREDITCCY>{ data($ACHRequest/CREDIT_CURRENCY) }</CREDITCCY>
                <CUSTOMERID>{ $CustomerID }</CUSTOMERID>
                <AMOUNT>{ data($ACHRequest/TRANSFER_AMOUNT) }</AMOUNT>
                <IDBANKISSUER>{ fn:substring(data($ACHRequest/DESTINATION_BANK),1,20) }</IDBANKISSUER>
                <IDPRODUCT>{ fn:substring(data($ACHRequest/ACCOUNT_TYPE),1,30) }</IDPRODUCT>
                {
                    for $transactionId in $ModelBankResponse/Status/transactionId
                    return
                        <IDTXNT24>{ data($transactionId) }</IDTXNT24>
                }
                <TIPOTRANS>{ $TransactionType }</TIPOTRANS>
                {
                	let $indicator := data($Status)
                	return
	                	<IDREJECTION>
	                	{
	                		if ($indicator = "SUCCESS") then
	                			''
	                		elseif ($indicator = "PENDING") then
	                			''
	                		elseif ($indicator = "SCHEDULED") then
	                			''
	                		elseif ($indicator = "REJECTED") then
	                			$IDRejection
	                		else
	                			$IDRejection
	                			
	                	}
	                	</IDREJECTION>
               	}
               	{
                	let $indicator := data($Status)
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
                <DESTCUSTOMERID>{ fn:substring(data($ACHRequest/BENEFICIARY_ID),1,20) }</DESTCUSTOMERID>
                <NARADDEND>{ fn:substring(data($ACHRequest/TRANSACTION_DESCRIPTION),1,35) }</NARADDEND>
                <CUSNAME>{ fn:substring(data($ACHRequest/BENEFICIARY_NAME),1,35) }</CUSNAME>
                <ACHTXNTYPE>{ $ACHType }</ACHTXNTYPE>
            </FICOHNACHONLINEINPUTType>
        </ns2:RegistroACHRecibida>
};

declare variable $RequestHeader as element(ns1:RequestHeader) external;
declare variable $ModelBankResponse as element(ns2:TransfmodelbankentrecuentasResponse) external;
declare variable $ACHRequest as element(ns0:transferenciasACHRequest) external;
declare variable $CustomerID as xs:string external;
declare variable $ACHType as xs:string external;
declare variable $TransactionType as xs:string external;
declare variable $Status as xs:string external;
declare variable $IDRejection as xs:string external;

xf:ProgramadasTxAchEnvIn($RequestHeader,
    $ModelBankResponse,
    $ACHRequest,
    $CustomerID,
    $ACHType,
    $TransactionType,
    $Status,
    $IDRejection)
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RegistrarACHEnviados" location="../../../BusinessServices/ACH/Enviado/SvcACHEnviado/xsd/XMLSchema_-1255526967.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/registrarACHEnviadosIn/";

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

declare function xf:registrarACHEnviadosIn($requestHeader1 as element(ns2:RequestHeader),
	$transferenciasACHRequest as element(ns0:transferenciasACHRequest))
    as element(ns1:RegistrarACHEnviados) {
        <ns1:RegistrarACHEnviados>
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
            <FICOHNACHONLINEINPUTType>
                <DEBITACCTNO>{ data($transferenciasACHRequest/LOCAL_ORIGINAL_ACCOUNT) }</DEBITACCTNO>
                <CREDITACCTNO>{ data($transferenciasACHRequest/CREDIT_ACCOUNT) }</CREDITACCTNO>
                <CREDITCCY>{ data($transferenciasACHRequest/CREDIT_CURRENCY) }</CREDITCCY>
                <AMOUNT>{ fn-bea:decimal-truncate(xs:decimal(data($transferenciasACHRequest/TRANSFER_AMOUNT)), 2) }</AMOUNT>
                <IDBANKISSUER>{ data($transferenciasACHRequest/DESTINATION_BANK) }</IDBANKISSUER>
                <IDPRODUCT>{ data($transferenciasACHRequest/ACCOUNT_TYPE) }</IDPRODUCT>
                <TIPOTRANS>ACCT.CREDIT</TIPOTRANS>
                <DESTCUSTOMERID>{ data($transferenciasACHRequest/BENEFICIARY_ID) }</DESTCUSTOMERID>
                <NARADDEND>{ fn:substring(data($transferenciasACHRequest/TRANSACTION_DESCRIPTION), 1, 34) }</NARADDEND>
                <CUSNAME>{ fn:replace(fn:substring(data($transferenciasACHRequest/BENEFICIARY_NAME), 1, 34), '(\:|\[|\]|\\|\/|\||\"|\^|\,|\$|\?|\*|\+|\{|\}|\(|\))', '.') }</CUSNAME>
                <ACHTXNTYPE>ACHO</ACHTXNTYPE>
                <ACCTINDIRECT>
                	{ 
                		if(data($transferenciasACHRequest/LOCAL_ACCOUNT_TYPE) = ('INDIRECT', 'SCHEDULED')) then(
                			data($transferenciasACHRequest/DEBIT_ACCOUNT)
                		)else(
                			''
                		)
                	}
                </ACCTINDIRECT>
            </FICOHNACHONLINEINPUTType>
        </ns1:RegistrarACHEnviados>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $transferenciasACHRequest as element(ns0:transferenciasACHRequest) external;

xf:registrarACHEnviadosIn($requestHeader1,
	$transferenciasACHRequest)
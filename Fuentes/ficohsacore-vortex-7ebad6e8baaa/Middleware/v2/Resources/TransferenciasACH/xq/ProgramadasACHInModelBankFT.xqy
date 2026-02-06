xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$Header" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$ACHRequest" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns2:Transfmodelbankentrecuentas" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/ProgramadasACHInModelBankFT/";

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
 
declare function xf:ProgramadasACHInModelBankFT($Header as element(ns1:RequestHeader),
    $ACHRequest as element(ns0:transferenciasACHRequest),
    $UUID as xs:string,
    $CreditAccount as xs:string)
    as element(ns2:Transfmodelbankentrecuentas) {
        <ns2:Transfmodelbankentrecuentas>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($Header/Authentication/UserName)),
                        data($Header/Authentication/UserName))
                    }
				</userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($Header/Authentication/UserName)),
                        data($Header/Authentication/Password))
                    }
				</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $UUID }</messageId>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType id = "">
                <TRANSACTIONTYPE>ACHO</TRANSACTIONTYPE>
                <DEBITACCTNO>{ data($ACHRequest/DEBIT_ACCOUNT) }</DEBITACCTNO> 
                <DEBITCURRENCY>{ data($ACHRequest/CREDIT_CURRENCY) }</DEBITCURRENCY> 
                <CREDITACCTNO>{ $CreditAccount }</CREDITACCTNO>  
                <DEBITAMOUNT>{ fn-bea:decimal-truncate(xs:decimal(data($ACHRequest/TRANSFER_AMOUNT)), 2) }</DEBITAMOUNT> 
                <CREDITCURRENCY>{ data($ACHRequest/CREDIT_CURRENCY) }</CREDITCURRENCY> 
                <LRBENNAME>{ data($ACHRequest/BENEFICIARY_NAME) }</LRBENNAME> 
                <LRBANKCODE>{ data($ACHRequest/DESTINATION_BANK) }</LRBANKCODE> 
                <LRBENPAYACCT>{ data($ACHRequest/CREDIT_ACCOUNT) }</LRBENPAYACCT> 
                <LRNARADDEND>{ substring(fn:string($ACHRequest/TRANSACTION_DESCRIPTION/text()),1,34)  }</LRNARADDEND> 
                <LRPAYACHTYPE>{ data($ACHRequest/ACCOUNT_TYPE) }</LRPAYACHTYPE> 
                
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns2:Transfmodelbankentrecuentas>
};

declare variable $Header as element(ns1:RequestHeader) external;
declare variable $ACHRequest as element(ns0:transferenciasACHRequest) external;
declare variable $UUID as xs:string external;
declare variable $CreditAccount as xs:string external;

xf:ProgramadasACHInModelBankFT($Header,
    $ACHRequest,
    $UUID,
    $CreditAccount)
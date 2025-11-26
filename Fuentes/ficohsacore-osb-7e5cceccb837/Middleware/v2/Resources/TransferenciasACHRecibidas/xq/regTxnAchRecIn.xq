(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns2:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$tRANSACTION_DETAIL1" type="ns1:transferenciasACHRecibidas/TRANSACTION_DETAILS/TRANSACTION_DETAIL" location="../xsd/transferenciasACHRecibidasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RegistroACHRecibida" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHRecibidasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/regTxnAchRecIn/";

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

declare function xf:regTxnAchRecIn($requestHeader1 as element(ns2:RequestHeader),
    $responseHeader1 as element(ns2:ResponseHeader),
    $tRANSACTION_DETAIL1 as element(),
    $msjMapeado as xs:string,
    $achType as xs:string,
    $customerId as xs:string,
    $gLOBAL_REFERENCE1 as xs:string)
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
                <DEBITACCTNO>
                {
                	let $txnType :=  fn:string($tRANSACTION_DETAIL1/TRANSACTION_TYPE/text())
                	return
                		if ($txnType = "ACCT_DEBIT") then (
                			fn:substring(fn:string($tRANSACTION_DETAIL1/DESTINATION/text()),1,40)
                		) else (
                			fn:substring(fn:string($tRANSACTION_DETAIL1/ORIGINATOR_INFO/ACCOUNT/text()),1,40)
                		)
                }
                </DEBITACCTNO>
                <CREDITACCTNO>
                { 
                	let $txnType :=  fn:string($tRANSACTION_DETAIL1/TRANSACTION_TYPE/text())
                	return
                		if ($txnType = "ACCT_DEBIT") then (
                			fn:substring(fn:string($tRANSACTION_DETAIL1/ORIGINATOR_INFO/ACCOUNT/text()),1,40)
                		) else (
                			fn:substring(fn:string($tRANSACTION_DETAIL1/DESTINATION/text()),1,40)
                		)
                }
                </CREDITACCTNO>
                <CREDITCCY>{ data($tRANSACTION_DETAIL1/CURRENCY) }</CREDITCCY>
                <CUSTOMERID>{ $customerId }</CUSTOMERID>
                <AMOUNT>{ data($tRANSACTION_DETAIL1/AMOUNT) }</AMOUNT>
                <GLOBALREFERENCE>{ $gLOBAL_REFERENCE1 }</GLOBALREFERENCE>
                <IDBANKISSUER>{ fn:substring(fn:replace(fn:substring(data($tRANSACTION_DETAIL1/ORIGINATOR_INFO/BANK_ID),6,2),'^0*(..*)', '$1'),1,20) }</IDBANKISSUER>
                {
                    for $REFERENCE_NUMBER in $tRANSACTION_DETAIL1/ORIGINATOR_INFO/REFERENCE_NUMBER
                    return
                        <LEGENDBANKISSUER>{ data($REFERENCE_NUMBER) }</LEGENDBANKISSUER> (:PREGUNTAR:)
                }
                <IDPRODUCT>{ fn:substring(data($tRANSACTION_DETAIL1/DESTINATION),1,30) }</IDPRODUCT>
                 {
                 	let $successIndicator1 := data($msjMapeado)
                    return
                        <IDREJECTION>
                        { 
                        	if (fn:upper-case(data($successIndicator1)) = "SUCCESS") then (
                        		''
                        	) else (
                        		"REJECTED"
                        	) 
                        }
                        </IDREJECTION>
                }
                {
                    for $transactionId in $responseHeader1/transactionId
                    return
                        <IDTXNT24>{ data($transactionId) }</IDTXNT24> 
                }
                <TIPOTRANS>{ fn:substring(fn:replace(data($tRANSACTION_DETAIL1/TRANSACTION_TYPE),"_","."),1,35) }</TIPOTRANS>
                {
                    let $successIndicator := fn:upper-case(fn:string($responseHeader1/successIndicator/text()))
                    return
                        <STATUS>
                        { 
                        	if ($successIndicator = "SUCCESS") then (
                        		$successIndicator
                        	) else (
                        		"REJECTED"
                        	) 
                        }
                        </STATUS>
                }
                <CUSNAME>{ fn:substring(data($tRANSACTION_DETAIL1/ORIGINATOR_INFO/CUSTOMER_NAME),1,35) }</CUSNAME>
                <ACHTXNTYPE>{ $achType }</ACHTXNTYPE>
            </FICOHNACHONLINEINPUTType>
        </ns0:RegistroACHRecibida>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $responseHeader1 as element(ns2:ResponseHeader) external;
declare variable $tRANSACTION_DETAIL1 as element() external;
declare variable $msjMapeado as xs:string external;
declare variable $achType as xs:string external;
declare variable $customerId as xs:string external;
declare variable $gLOBAL_REFERENCE1 as xs:string external;

xf:regTxnAchRecIn($requestHeader1,
    $responseHeader1,
    $tRANSACTION_DETAIL1,
    $msjMapeado,
    $achType,
    $customerId,
    $gLOBAL_REFERENCE1)
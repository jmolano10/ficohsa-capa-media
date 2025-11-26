(:: pragma bea:global-element-parameter parameter="$confirmacionCheque" element="ns0:confirmacionCheque" location="confirmacionChequeTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Confirmaciondecheques" location="../Resources/XMLSchema_-1265051491.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/confirmacionChequeTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/confirmacionCheque/ConfirmacionChequeIn/";

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

declare function xf:ConfirmacionChequeIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
	$confirmacionCheque as element(ns0:confirmacionCheque),
    $issuingDate as xs:string)
    as element(ns1:Confirmaciondecheques) {
        <ns1:Confirmaciondecheques>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader/UserName)),
                								data($autenticacionRequestHeader/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <LATAMAGCHEQUECONFIRMDATALATAMWSVERType id = "{ concat(fn-bea:format-number(fn:number($confirmacionCheque/CHEQUE_NUMBER),"###") ,".", $confirmacionCheque/DEBIT_ACCOUNT) }">
                <gBENEFICIARYNAME g = "1">
                    <BENEFICIARYNAME>{ substring(fn-bea:trim(fn:string($confirmacionCheque/BENEFICIARY_NAME/text())), 1, 35) }</BENEFICIARYNAME>
                </gBENEFICIARYNAME>
                <ISSUEDATE>{ $issuingDate }</ISSUEDATE>
                <AMOUNT>{ data($confirmacionCheque/AMOUNT) }</AMOUNT>
                {
                	let $confirmationType := fn:string($confirmacionCheque/CONFIRMATION_TYPE/text())
                	return
	                	if ($confirmationType = "20") then (
							<CONFIRMYN>Y</CONFIRMYN>,
							<RESERVEFUNDSYN>Y</RESERVEFUNDSYN>
							               	
	                	) else if ($confirmationType = "21") then (
							<CONFIRMYN>Y</CONFIRMYN>,
							<RESERVEFUNDSYN>N</RESERVEFUNDSYN>
	                	
	                	) else if ($confirmationType = "22") then (
							<CONFIRMYN>N</CONFIRMYN>,
							<RESERVEFUNDSYN>N</RESERVEFUNDSYN>
							
	                	) else ()
                }
                {
                    for $AGREEMENT_CONTRACT_ID in $confirmacionCheque/AGREEMENT_CONTRACT_ID
                    return
                        <AGREEMENTCONTRACTID>{ data($AGREEMENT_CONTRACT_ID) }</AGREEMENTCONTRACTID>
                }                
            </LATAMAGCHEQUECONFIRMDATALATAMWSVERType>
        </ns1:Confirmaciondecheques>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $confirmacionCheque as element(ns0:confirmacionCheque) external;
declare variable $issuingDate as xs:string external;

xf:ConfirmacionChequeIn($autenticacionRequestHeader,
    $confirmacionCheque,
    $issuingDate)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaEstadoCheque1" element="ns1:consultaEstadoCheque" location="consultaEstadoChequeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Confirmaciondecheques_Validate" location="../Resources/XMLSchema_-1265051491.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoChequeTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/confirmaCheque/consultaEstadoCheque/consultaEstadoChequeConfirmacionChequeIn/";

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

declare function xf:consultaEstadoChequeConfirmacionChequeIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultaEstadoCheque1 as element(ns1:consultaEstadoCheque),
    $issuingDate as xs:string)
    as element(ns0:Confirmaciondecheques_Validate) {
        <ns0:Confirmaciondecheques_Validate>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <LATAMAGCHEQUECONFIRMDATALATAMWSVERType id = "{ concat($consultaEstadoCheque1/CHEQUE_NUMBER ,".", $consultaEstadoCheque1/DEBIT_ACCOUNT) }">
                <gBENEFICIARYNAME>                    
                    <BENEFICIARYNAME>TEST</BENEFICIARYNAME>
                </gBENEFICIARYNAME>
                <ISSUEDATE>{ $issuingDate }</ISSUEDATE>
                <AMOUNT>1</AMOUNT>                
				<CONFIRMYN>Y</CONFIRMYN>
				<RESERVEFUNDSYN>N</RESERVEFUNDSYN>							               		           
                {
                    for $AGREEMENT_CONTRACT_ID in $consultaEstadoCheque1/AGREEMENT_CONTRACT_ID
                    return
                        <AGREEMENTCONTRACTID>{ data($AGREEMENT_CONTRACT_ID) }</AGREEMENTCONTRACTID>
                }
            </LATAMAGCHEQUECONFIRMDATALATAMWSVERType>
        </ns0:Confirmaciondecheques_Validate>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaEstadoCheque1 as element(ns1:consultaEstadoCheque) external;
declare variable $issuingDate as xs:string external;

xf:consultaEstadoChequeConfirmacionChequeIn($autenticacionRequestHeader1,
    $consultaEstadoCheque1,
    $issuingDate)
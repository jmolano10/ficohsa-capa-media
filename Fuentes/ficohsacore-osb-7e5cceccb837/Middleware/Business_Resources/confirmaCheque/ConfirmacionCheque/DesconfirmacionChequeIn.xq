(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$desconfirmacionCheque1" element="ns0:confirmacionCheque" location="confirmacionChequeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:DesconfirmaciondeCheques" location="../Resources/XMLSchema_-1265051491.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/confirmacionChequeTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/confirmaCheque/DesconfirmacionChequeIn/";

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

declare function xf:DesconfirmacionChequeIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $desconfirmacionCheque1 as element(ns0:confirmacionCheque))
    as element(ns1:DesconfirmaciondeCheques) {
        <ns1:DesconfirmaciondeCheques>
            <WebRequestCommon>
                <userName>
                {
                    fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)),
                    data($autenticacionRequestHeader1/UserName))
                }
                </userName>
                <password>
                {
                    fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                    data($autenticacionRequestHeader1/Password))
                }
                </password>
            </WebRequestCommon>
            <OfsFunction>
            	<noOfAuth></noOfAuth>
         	</OfsFunction>
            <LATAMAGCHEQUECONFIRMDATAMODIFYBROWWSType id = "{ concat(fn-bea:format-number(fn:number($desconfirmacionCheque1/CHEQUE_NUMBER),"###") ,".", $desconfirmacionCheque1/DEBIT_ACCOUNT) }">
                <CONFIRM>N</CONFIRM>
                <RESERVEFUNDS>N</RESERVEFUNDS>
            </LATAMAGCHEQUECONFIRMDATAMODIFYBROWWSType>
        </ns1:DesconfirmaciondeCheques>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $desconfirmacionCheque1 as element(ns0:confirmacionCheque) external;

xf:DesconfirmacionChequeIn($autenticacionRequestHeader1,
    $desconfirmacionCheque1)
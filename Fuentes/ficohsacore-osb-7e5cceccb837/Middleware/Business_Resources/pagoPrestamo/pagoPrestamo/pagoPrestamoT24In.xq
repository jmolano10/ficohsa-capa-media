(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo1" element="ns0:pagoPrestamo" location="../pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:PagoaprestamoAAFT" location="../../consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/PagoPrestamoBOT24In/";

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


declare function xf:PagoPrestamoBOT24In($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $pagoPrestamo1 as element(ns0:pagoPrestamo),
    $uuid as xs:string,
    $t24DebitAccount as xs:string)
    as element(ns1:PagoaprestamoAAFT) {
        <ns1:PagoaprestamoAAFT>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl></gtsControl>
                <messageId>{ $uuid }</messageId>
                <noOfAuth>0</noOfAuth>
                <replace></replace>
            </OfsFunction>
            <FICOHADVANCEPAYMENTSFICOADVPAYINPOFSType>
                <LOANNO>{ data($pagoPrestamo1/LOAN_NUMBER) }</LOANNO>
                <PAYMENTTYPE>DEBIT TO ACCOUNT</PAYMENTTYPE>
                <AMOUNTTOBEREPAID>{ data($pagoPrestamo1/PAYMENT_AMOUNT) }</AMOUNTTOBEREPAID>
                <DEBITACCOUNT>{ $t24DebitAccount }</DEBITACCOUNT>
            </FICOHADVANCEPAYMENTSFICOADVPAYINPOFSType>
        </ns1:PagoaprestamoAAFT>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoPrestamo1 as element(ns0:pagoPrestamo) external;
declare variable $uuid as xs:string external;
declare variable $t24DebitAccount as xs:string external;

xf:PagoPrestamoBOT24In($autenticacionRequestHeader1,
    $pagoPrestamo1,
    $uuid,
    $t24DebitAccount)
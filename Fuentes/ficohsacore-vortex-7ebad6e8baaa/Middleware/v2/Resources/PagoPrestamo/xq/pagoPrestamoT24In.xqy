xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns2:pagoPrestamo" location="../../../../Business_Resources/pagoPrestamo/pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:PagoaprestamoAA" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoT24In/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace ns1 = "T24WebServicesImpl";

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
 
declare function xf:pagoPrestamoT24In($requestHeader as element(ns0:RequestHeader),
    $pagoPrestamo as element(ns2:pagoPrestamo),
    $accountCurrency as xs:string)
    as element(ns1:PagoaprestamoAA) {
        <ns1:PagoaprestamoAA>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
	            <gtsControl></gtsControl>
	            <messageId></messageId>
	            <noOfAuth></noOfAuth>
	            <replace></replace>
	        </OfsFunction>
            <TELLERFINANCIALSERVICESLOANPAYMENTWSType>
                <gTRANSACTION>
                    <mTRANSACTION>
                        <TRANSCTION>PR.ACT.DB</TRANSCTION>
                        {
                            for $DEBIT_ACCOUNT in $pagoPrestamo/DEBIT_ACCOUNT
                            return
                                <SURROGATEAC>{ data($DEBIT_ACCOUNT) }</SURROGATEAC>
                        }
                        <CURRENCY>{ $accountCurrency }</CURRENCY>
                        <AMOOUNT>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</AMOOUNT>
                        {
                            for $BANK_CODE in $pagoPrestamo/BANK_CODE
                            return
                                <SORTCODE>{ data($BANK_CODE) }</SORTCODE>
                        }
                        {
                            for $CHEQUE_NUMBER in $pagoPrestamo/CHEQUE_NUMBER
                            return
                                <CHEQUENUMBER>{ data($CHEQUE_NUMBER) }</CHEQUENUMBER>
                        }
                    </mTRANSACTION>
                </gTRANSACTION>
                <LRLOANNO>{ data($pagoPrestamo/LOAN_NUMBER) }</LRLOANNO>
                <LRWAIVECHG>NO</LRWAIVECHG>
            </TELLERFINANCIALSERVICESLOANPAYMENTWSType>
        </ns1:PagoaprestamoAA>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoPrestamo as element(ns2:pagoPrestamo) external;
declare variable $accountCurrency as xs:string external;

xf:pagoPrestamoT24In($requestHeader,
    $pagoPrestamo,
    $accountCurrency)
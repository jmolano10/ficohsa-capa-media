(:: pragma bea:global-element-return element="ns0:Transfmodelbankentrecuentas" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/cobroComisionACHIn/";
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";

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

declare function xf:cobroComisionACHIn($username as xs:string,
    $password as xs:string,
    $uuid as xs:string,
    $transactionType as xs:string,
    $debitAccount as xs:string,
    $creditAccount as xs:string,
    $currency as xs:string,
    $amount as xs:string)
    as element(ns0:Transfmodelbankentrecuentas) {
        <ns0:Transfmodelbankentrecuentas>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername($username),$username) }</userName>
                <password>{ fn-bea:fail-over( getPassword($username),$password) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                <DEBITACCTNO>{ $debitAccount }</DEBITACCTNO>
                <DEBITCURRENCY>{ $currency }</DEBITCURRENCY>
                <DEBITAMOUNT>{ $amount }</DEBITAMOUNT>
                <CREDITACCTNO>{ $creditAccount }</CREDITACCTNO>
                <gORDERINGBANK>
                	<ORDERINGBANK>999999</ORDERINGBANK>
                </gORDERINGBANK>
                <gPAYMENTDETAILS>
                    <PAYMENTDETAILS>Cobro Comision Transf ACH</PAYMENTDETAILS>
                </gPAYMENTDETAILS>
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns0:Transfmodelbankentrecuentas>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $uuid as xs:string external;
declare variable $transactionType as xs:string external;
declare variable $debitAccount as xs:string external;
declare variable $creditAccount as xs:string external;
declare variable $currency as xs:string external;
declare variable $amount as xs:string external;

xf:cobroComisionACHIn($username,
    $password,
    $uuid,
    $transactionType,
    $debitAccount,
    $creditAccount,
    $currency,
    $amount)
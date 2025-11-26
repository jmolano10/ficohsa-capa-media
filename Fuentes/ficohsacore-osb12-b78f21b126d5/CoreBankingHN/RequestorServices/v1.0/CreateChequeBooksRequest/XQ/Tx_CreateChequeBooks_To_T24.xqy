xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/ChequeBooksOperations/XMLSchema_21306858.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/accountsTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/accountsTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $userName as xs:string external;
declare variable $password as xs:string external;
declare variable $uuid as xs:string external;
declare variable $createChequeBooks as element() (:: schema-element(ns2:createCheckBooksRequest) ::) external;

(: Función encargada de realizar el mapeo de usuario:)
declare function xq:getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function xq:getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("CommonResources/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xq:Tx_CreateChequeBooks_To_T24($createChequeBooks as element() (:: schema-element(ns2:createCheckBooksRequest) ::),$userName as xs:string,$password as xs:string,$uuid as xs:string) as element() (:: schema-element(ns1:Solicituddechequera) ::) {
    <ns1:Solicituddechequera>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($userName)),data($password)) }</password>
        </WebRequestCommon>
        <OfsFunction>
            <messageId>{$uuid}</messageId>
            <noOfAuth>0</noOfAuth>
        </OfsFunction>
        <FICOHCHECKBOOKREQUESTISSUEDWSType>
            <ACCOUNTNUMBER>{fn:data($createChequeBooks/ns2:AccountNumber)}</ACCOUNTNUMBER>
            <DESTINATIONAGENCYCODE>{fn:data($createChequeBooks/ns2:DestinationBranch)}</DESTINATIONAGENCYCODE>
            <NOOFBOOKS>{fn:data($createChequeBooks/ns2:NoOfBooks)}</NOOFBOOKS>
            <CHEQUETYPEID>{fn:data($createChequeBooks/ns2:ChequeBookType)}</CHEQUETYPEID>
            <AUTHORISEDPERSON>{fn:data($createChequeBooks/ns2:AuthorizedClaimer)}</AUTHORISEDPERSON>
        </FICOHCHECKBOOKREQUESTISSUEDWSType>
    </ns1:Solicituddechequera>
};

xq:Tx_CreateChequeBooks_To_T24($createChequeBooks,$userName,$password,$uuid)

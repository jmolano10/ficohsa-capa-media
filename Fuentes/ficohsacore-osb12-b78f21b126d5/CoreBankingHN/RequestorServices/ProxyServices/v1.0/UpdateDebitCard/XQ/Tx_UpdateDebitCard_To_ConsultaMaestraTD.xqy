xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerDebitCards/XMLSchema_-155258746.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/debitCardsTypes";
(:: import schema at "../../../../../../MWBanking/DebitCards/RequestorServices/XSD/debitCardsTypes.xsd" ::)
declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
declare variable $userName as xs:string external;

declare variable $updateDebitCard as element() (:: schema-element(ns1:updateDebitCardRequest) ::) external;

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

declare function xq:Tx_UpdateDebitCard_To_ConsultaMaestraTD($updateDebitCard as element() (:: schema-element(ns1:updateDebitCardRequest) ::),$userName as xs:string) as element() (:: schema-element(ns2:ConsultaMaestraTarjetaDebito) ::) {
    <ns2:ConsultaMaestraTarjetaDebito>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($userName)),data($userName)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($userName)),data($userName)) }</password>
        </WebRequestCommon>
        <WSFICODEBITCARDCUSTOMERType>
            <enquiryInputCollection>
                <columnName>@ID</columnName>
                {
                    if ($updateDebitCard/ns1:cardNumber)
                    then <criteriaValue>{fn:concat("...",fn:data($updateDebitCard/ns1:cardNumber))}</criteriaValue>
                    else ()
                }
                <operand>LK</operand>
            </enquiryInputCollection>
        </WSFICODEBITCARDCUSTOMERType>
    </ns2:ConsultaMaestraTarjetaDebito>
};

xq:Tx_UpdateDebitCard_To_ConsultaMaestraTD($updateDebitCard,$userName)

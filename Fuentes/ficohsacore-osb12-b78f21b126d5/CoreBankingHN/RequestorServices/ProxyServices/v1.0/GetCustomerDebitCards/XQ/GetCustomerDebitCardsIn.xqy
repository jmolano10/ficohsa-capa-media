xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerDebitCards/XMLSchema_-155258746.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/getCustomerDebitCardsIn";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $customerId as xs:string external;
declare variable $account as xs:string external;
declare variable $cardStatus as xs:string external;

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
 
 
declare function xq:getCardStatus($cardStatus as xs:string) as xs:string {
	if ($cardStatus = "Issued") then ("90")
        else if ($cardStatus = "Returned") then ("91")
        else if ($cardStatus = "Scrap") then ("92")
        else if ($cardStatus = "Cancel") then ("93")
        else if ($cardStatus = "Active") then ("94")
        else if ($cardStatus = "Destroyed") then ("95")
        else if ($cardStatus = "Blocked") then ("96")
        else("")
};

declare function ns1:getCustomerDebitCardsIn($username as xs:string,
                                              $password as xs:string,
                                              $customerId as xs:string,
                                              $account as xs:string,
                                              $cardStatus as xs:string) as element() (:: schema-element(ns2:ConsultaMaestraTarjetaDebito) ::) {
    <ns2:ConsultaMaestraTarjetaDebito>
        <WebRequestCommon>
            <userName>{ fn-bea:fail-over( xq:getUsername(data($username)),data($username)) }</userName>
            <password>{ fn-bea:fail-over( xq:getPassword(data($username)),data($password)) }</password>
        </WebRequestCommon>
        <WSFICODEBITCARDCUSTOMERType>
            <enquiryInputCollection>
                <columnName>CUSTOMER</columnName>
                <criteriaValue>{fn:data($customerId)}</criteriaValue>
                <operand>EQ</operand>
            </enquiryInputCollection>
            {
               if (data($cardStatus)!="" ) then 
               (
                  if (data($cardStatus)!="All" ) then
                  (
                      <enquiryInputCollection>
                          <columnName>CARD.STATUS</columnName>
                          <criteriaValue>{xq:getCardStatus(data($cardStatus))}</criteriaValue>
                          <operand>EQ</operand>
                      </enquiryInputCollection>
                  ) else ()
                ) else ()
            }
            {
               if (data($account)!="" ) then 
               (
                  <enquiryInputCollection>
                      <columnName>ACCOUNT</columnName>
                      <criteriaValue>{fn:data($account)}</criteriaValue>
                      <operand>EQ</operand>
                  </enquiryInputCollection>
                ) else ()
            }
        </WSFICODEBITCARDCUSTOMERType>
    </ns2:ConsultaMaestraTarjetaDebito>
};

ns1:getCustomerDebitCardsIn($username, $password, $customerId, $account, $cardStatus)
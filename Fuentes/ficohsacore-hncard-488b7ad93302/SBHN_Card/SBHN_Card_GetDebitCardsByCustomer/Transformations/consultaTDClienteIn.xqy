xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../Schemas/getDebitCardsByCustomer/XMLSchema_-149513020.xsd" ::)
declare namespace ns0="https://www.ficohsa.com/honduras/user";
(:: import schema at "../../SBHN_Card_Commons/Schemas/UserLoginT24.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBHN_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare variable $consultaTDCliente as element() (:: schema-element(ns1:getDebitCardsByCustomer) ::) external;
declare variable $requestHeader as element() (:: schema-element(ns0:connInfoElement) ::) external;

declare function local:getCardStatus($cardStatus as xs:string) as xs:string {
    if ($cardStatus = "ISSUED") then ("90")
    else if ($cardStatus = "RETURNED") then ("91")
    else if ($cardStatus = "SCRAP") then ("92")
    else if ($cardStatus = "CANCEL") then ("93")
    else if ($cardStatus = "ACTIVE") then ("94")
    else if ($cardStatus = "DESTROYED") then ("95")
    else if ($cardStatus = "BLOCKED") then ("96")
    else("")
};

declare function local:func($consultaTDCliente as element() (:: schema-element(ns1:getDebitCardsByCustomer) ::), 
                            $requestHeader as element() (:: schema-element(ns0:connInfoElement) ::)) 
                            as element() (:: element(*, ns2:getDebitCardsByCustomer) ::) {
    if (data($consultaTDCliente/CardStatus) != "ALL") then
    (
    <ns2:getDebitCardsByCustomer>
        <WebRequestCommon>
            <userName>{fn:data($requestHeader/ns0:username)}</userName>
            <password>{fn:data($requestHeader/ns0:password)}</password>
            <company></company>
        </WebRequestCommon>
        <WSFICODEBITCARDCUSTOMERType>
        <enquiryInputCollection>
          <columnName>CUSTOMER</columnName>
          <criteriaValue>{ data($consultaTDCliente/CustomerId) }</criteriaValue>
          <operand>EQ</operand>
        </enquiryInputCollection>
        <enquiryInputCollection>
          <columnName>CARD.STATUS</columnName>
          <criteriaValue>{ local:getCardStatus(data($consultaTDCliente/CardStatus)) }</criteriaValue>
          <operand>EQ</operand>
        </enquiryInputCollection>
       </WSFICODEBITCARDCUSTOMERType>
       {
          if (data($consultaTDCliente/AccountNumber)!="" ) then 
          (
              <enquiryInputCollection>
                <columnName>ACCOUNT</columnName>
                <criteriaValue>{$consultaTDCliente/AccountNumber/text()}</criteriaValue>
                <operand>EQ</operand>
               </enquiryInputCollection>
                )
                else()
       }
    </ns2:getDebitCardsByCustomer>
    )else(
    <ns2:getDebitCardsByCustomer>
      <WebRequestCommon>
        <userName>{fn:data($requestHeader/ns0:username)}</userName>
        <password>{fn:data($requestHeader/ns0:password)}</password>
      </WebRequestCommon>
      <WSFICODEBITCARDCUSTOMERType>
        <enquiryInputCollection>
          <columnName>CUSTOMER</columnName>
          <criteriaValue>{ data($consultaTDCliente/CustomerId) }</criteriaValue>
          <operand>EQ</operand>
        </enquiryInputCollection> 
       </WSFICODEBITCARDCUSTOMERType>
    </ns2:getDebitCardsByCustomer>
    )
};

local:func($consultaTDCliente, $requestHeader)
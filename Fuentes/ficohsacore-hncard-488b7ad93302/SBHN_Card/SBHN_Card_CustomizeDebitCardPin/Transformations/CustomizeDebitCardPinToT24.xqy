xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../Schemas/services_1.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/card";
(:: import schema at "../Schemas/CustomizeDebitCardPinTypes.xsd" ::)

declare variable $CustomizeDebitCardPinToT24 as element() (:: schema-element(ns1:customizeDebitCardPin) ::) external;
declare variable $user as xs:string external;
declare variable $pass as xs:string external;
declare variable $pvv as xs:string external;

declare function local:funcCustomizeDebitCardPinToT24($CustomizeDebitCardPinToT24 as element() (:: schema-element(ns1:customizeDebitCardPin) ::),
                                                      $user as xs:string,
                                                      $pass as xs:string,
                                                      $pvv as xs:string) as element() (:: schema-element(ns2:getCustomizeDebitCardPin) ::) {
    <ns2:getCustomizeDebitCardPin>
      <WebRequestCommon>
            <userName>{fn:data($user)}</userName>
            <password>{fn:data($pass)}</password>
             <company></company>
      </WebRequestCommon>
      <FICOENQUPDPVVType>
              <enquiryInputCollection>
                  <columnName>CARD.NUMBER</columnName>
                  <criteriaValue>{fn:data($CustomizeDebitCardPinToT24/CardNumber)}</criteriaValue>
                  <operand>EQ</operand>
              </enquiryInputCollection>
              <enquiryInputCollection>
                  <columnName>PVV</columnName>
                  <criteriaValue>{fn:data($pvv)}</criteriaValue>
                  <operand>EQ</operand>
              </enquiryInputCollection>
      </FICOENQUPDPVVType>
    </ns2:getCustomizeDebitCardPin>
};

local:funcCustomizeDebitCardPinToT24($CustomizeDebitCardPinToT24, $user, $pass, $pvv)

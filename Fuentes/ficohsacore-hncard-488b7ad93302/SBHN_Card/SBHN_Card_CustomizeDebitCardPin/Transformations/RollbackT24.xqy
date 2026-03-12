xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../Schemas/Rollbackservices_1.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/card";
(:: import schema at "../Schemas/CustomizeDebitCardPinTypes.xsd" ::)

declare variable $RollbackT24 as element() (:: schema-element(ns1:customizeDebitCardPin) ::) external;
declare variable $user as xs:string external;
declare variable $pass as xs:string external;

declare function local:funcRollbackT24($RollbackT24 as element() (:: schema-element(ns1:customizeDebitCardPin) ::),
                                        $user as xs:string,
                                        $pass as xs:string) as element() (:: schema-element(ns2:rollbackCustomizeDebitCardPin) ::) {
    <ns2:rollbackCustomizeDebitCardPin>
    <WebRequestCommon>
            <userName>{fn:data($user)}</userName>
            <password>{fn:data($pass)}</password>
             <company></company>
      </WebRequestCommon>
      <OfsFunction>
            <gtsControl/>
            <messageId/>
            <noOfAuth/>
            <replace/>
         </OfsFunction>
      <FICOHDEBITCARDSTATUSPVVREVERTType id='{fn:data($RollbackT24/CardNumber)}'>
      
      </FICOHDEBITCARDSTATUSPVVREVERTType>
    </ns2:rollbackCustomizeDebitCardPin>
};

local:funcRollbackT24($RollbackT24, $user, $pass)

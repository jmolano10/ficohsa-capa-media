<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/gestionTCAumentoReduccionLCTypes";
(:: import schema at "../xsd/gestionTCAumentoReduccionLCTypes.xsd" ::)
declare namespace ns2="http://www.procesa.com/fdcs";
(:: import schema at "../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare variable $org as xs:string external;
declare variable $cardSequence as xs:string external;
declare variable $foreignUse as xs:string external;
declare variable $gestionTCAumentoReduccionLC as element() (:: schema-element(ns1:gestionTCAumentoReduccionLC) ::) external;

declare function local:func($org as xs:string, 
                            $cardSequence as xs:string, 
                            $foreignUse as xs:string, 
                            $gestionTCAumentoReduccionLC as element() (:: schema-element(ns1:gestionTCAumentoReduccionLC) ::)) 
                            as element() (:: schema-element(ns2:EmbosserUpdateL8V5Request) ::) {
    <ns2:EmbosserUpdateL8V5Request>
        <ARXEUI-ORG>{fn:data($org)}</ARXEUI-ORG>
        <ARXEUI-CARD-NBR>{fn:data($gestionTCAumentoReduccionLC/CARD_NUMBER)}</ARXEUI-CARD-NBR>
        <ARXEUI-CARD-SEQ>{fn:data($cardSequence)}</ARXEUI-CARD-SEQ>
        {
          if(fn:data($foreignUse))then
            <ARXEUI-FOREIGN-USE>{fn:data($foreignUse)}</ARXEUI-FOREIGN-USE>
          else
           <ARXEUI-FOREIGN-USE/>
        }
        <ARXEUI-CUSTOMER-NBR>{fn:data($gestionTCAumentoReduccionLC/CUSTOMER_NUMBER)}</ARXEUI-CUSTOMER-NBR>
        <ARXEUI-EMBR-NAME-1></ARXEUI-EMBR-NAME-1>
        <ARXEUI-EMBR-NAME-2></ARXEUI-EMBR-NAME-2>
        <ARXEUI-ADDR-LINE-1></ARXEUI-ADDR-LINE-1>
        <ARXEUI-ADDR-LINE-2></ARXEUI-ADDR-LINE-2>
        <ARXEUI-CITY></ARXEUI-CITY>
        <ARXEUI-ST-PR></ARXEUI-ST-PR>
        <ARXEUI-PSTL-CD></ARXEUI-PSTL-CD>
        <ARXEUI-USER-1></ARXEUI-USER-1>
        <ARXEUI-USER-2></ARXEUI-USER-2>
        <ARXEUI-USER-3>{fn:data($gestionTCAumentoReduccionLC/CUSTOMER_ID)}</ARXEUI-USER-3>
        <ARXEUI-USER-4></ARXEUI-USER-4>
        <ARXEUI-USER-5></ARXEUI-USER-5>
        <ARXEUI-USER-6></ARXEUI-USER-6>
        <ARXEUI-USER-7></ARXEUI-USER-7>
        <ARXEUI-USER-8></ARXEUI-USER-8> 
        <ARXEUI-USER-DATE-1 xsi:nil="true"/>
        <ARXEUI-USER-DATE-2 xsi:nil="true"/>
        <ARXEUI-CARDHOLDER-FLAG></ARXEUI-CARDHOLDER-FLAG>
        <ARXEUI-CARDHOLDER-TYPE></ARXEUI-CARDHOLDER-TYPE>
        <ARXEUI-LANG-CODE></ARXEUI-LANG-CODE>
        <ARXEUI-ISSUE-DELIV-OPTION>0</ARXEUI-ISSUE-DELIV-OPTION>
        <ARXEUI-REISSUE-DELIV-OPTION>0</ARXEUI-REISSUE-DELIV-OPTION>
        <ARXEUI-ADMIN-BRANCH>0</ARXEUI-ADMIN-BRANCH>
        <ARXEUI-FIRST-ISS-BRANCH>0</ARXEUI-FIRST-ISS-BRANCH>
        <ARXEUI-EMBLM-ID>0</ARXEUI-EMBLM-ID>
        <ARXEUI-FALC-MARK></ARXEUI-FALC-MARK>
        <ARXEUI-FALC-MARK-ST-DT xsi:nil="true"/>
        <ARXEUI-FALC-MARK-END-DT xsi:nil="true"/>
        <ARXEUI-EMBOSSED-NAME-1 xsi:nil="true"/>
        <ARXEUI-EMBOSSED-NAME-2 xsi:nil="true"/>
        <ARXEUI-PROFILE-ID>{fn:data($gestionTCAumentoReduccionLC/PROFILE_ID)}</ARXEUI-PROFILE-ID>
        <ARXEUI-ECOMM-IND>{fn:data($gestionTCAumentoReduccionLC/ECOMMERCE_INDICATOR)}</ARXEUI-ECOMM-IND>
        <ARXEUI-CONTLS-IND>{fn:data($gestionTCAumentoReduccionLC/CONTACTLESS_INDICATOR)}</ARXEUI-CONTLS-IND>
        <ARXEUI-AUTH-RSTR-TBL>{fn:data($gestionTCAumentoReduccionLC/RESTRICTION_TABLE)}</ARXEUI-AUTH-RSTR-TBL>
        {
                if(fn:data($gestionTCAumentoReduccionLC/SPENDING_LIMIT))then
                  <ARXEUI-AUTH-CR-LM>{fn:data($gestionTCAumentoReduccionLC/SPENDING_LIMIT)}</ARXEUI-AUTH-CR-LM>
                else
                 <ARXEUI-AUTH-CR-LM xsi:nil="true"/>
               }
    </ns2:EmbosserUpdateL8V5Request>
};

local:func($org, $cardSequence, $foreignUse, $gestionTCAumentoReduccionLC)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/gestionTCAumentoReduccionLCTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/GestionTCAumentoReduccionLC/xsd/gestionTCAumentoReduccionLCTypes"/>
        </con:importSchema>
        <con:importSchema location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>
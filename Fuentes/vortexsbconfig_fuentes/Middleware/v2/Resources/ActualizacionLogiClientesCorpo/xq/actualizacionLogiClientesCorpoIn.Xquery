<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizacionLogiClientesCorpo1" element="ns0:actualizacionLogiClientesCorpo" location="../xsd/actualizacionLogiClientesCorpoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:EmbosserUpdateL8V5Request" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/actualizacionLogiClientesCorpoTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizacionLogiClientesCorpo/xq/actualizacionLogiClientesCorpoIn/";

declare function xf:actualizacionLogiClientesCorpoIn($actualizacionLogiClientesCorpo1 as element(ns0:actualizacionLogiClientesCorpo))
    as element(ns1:EmbosserUpdateL8V5Request) {
        <ns1:EmbosserUpdateL8V5Request>
            <ARXEUI-ORG>{ data($actualizacionLogiClientesCorpo1/ORG) }</ARXEUI-ORG>
            <ARXEUI-CARD-NBR>{ data($actualizacionLogiClientesCorpo1/CARD_NUMBER) }</ARXEUI-CARD-NBR>
            <ARXEUI-CARD-SEQ>0</ARXEUI-CARD-SEQ>
            <ARXEUI-FOREIGN-USE>0</ARXEUI-FOREIGN-USE>
            <ARXEUI-CUSTOMER-NBR>{ data($actualizacionLogiClientesCorpo1/CUSTOMER_NUMBER) }</ARXEUI-CUSTOMER-NBR>
            <ARXEUI-EMBR-NAME-1/>
         	<ARXEUI-EMBR-NAME-2/>
         	<ARXEUI-ADDR-LINE-1/>
         	<ARXEUI-ADDR-LINE-2/>
         	<ARXEUI-CITY/>
         	<ARXEUI-ST-PR/>
         	<ARXEUI-PSTL-CD/>
         	<ARXEUI-USER-1/>
         	<ARXEUI-USER-2/>
            <ARXEUI-USER-3>{ data($actualizacionLogiClientesCorpo1/CUSTOMER_ID) }</ARXEUI-USER-3>
            <ARXEUI-USER-4/>
         	<ARXEUI-USER-5/>
         	<ARXEUI-USER-6/>
         	<ARXEUI-USER-7/>
         	<ARXEUI-USER-8/>
            <ARXEUI-USER-DATE-1 xsi:nil="true"/>
            <ARXEUI-USER-DATE-2 xsi:nil="true"/>
            <ARXEUI-CARDHOLDER-FLAG/>
         	<ARXEUI-CARDHOLDER-TYPE/>
         	<ARXEUI-LANG-CODE/>
            <ARXEUI-ISSUE-DELIV-OPTION>0</ARXEUI-ISSUE-DELIV-OPTION>
            <ARXEUI-REISSUE-DELIV-OPTION>0</ARXEUI-REISSUE-DELIV-OPTION>
            <ARXEUI-ADMIN-BRANCH>0</ARXEUI-ADMIN-BRANCH>
            <ARXEUI-FIRST-ISS-BRANCH>0</ARXEUI-FIRST-ISS-BRANCH>
            <ARXEUI-EMBLM-ID>0</ARXEUI-EMBLM-ID>
            <ARXEUI-FALC-MARK/>
            <ARXEUI-FALC-MARK-ST-DT xsi:nil="true"/>
            <ARXEUI-FALC-MARK-END-DT xsi:nil="true"/>
            <ARXEUI-EMBOSSED-NAME-1 xsi:nil="true"/>
            <ARXEUI-EMBOSSED-NAME-2 xsi:nil="true"/>
            <ARXEUI-PROFILE-ID>{ data($actualizacionLogiClientesCorpo1/PROFILE_ID) }</ARXEUI-PROFILE-ID>
            <ARXEUI-ECOMM-IND>{ data($actualizacionLogiClientesCorpo1/ECOMMERCE_INDICATOR) }</ARXEUI-ECOMM-IND>
            <ARXEUI-CONTLS-IND>{ data($actualizacionLogiClientesCorpo1/CONTACTLESS_INDICATOR) }</ARXEUI-CONTLS-IND>
            <ARXEUI-AUTH-RSTR-TBL>{ data($actualizacionLogiClientesCorpo1/RESTRICTION_TABLE) }</ARXEUI-AUTH-RSTR-TBL>
             {
                if(fn:data($actualizacionLogiClientesCorpo1/SPENDING_LIMIT))then
                  <ARXEUI-AUTH-CR-LM>{fn:data($actualizacionLogiClientesCorpo1/SPENDING_LIMIT)}</ARXEUI-AUTH-CR-LM>
                else
                 <ARXEUI-AUTH-CR-LM xsi:nil="true"/>
               }
        </ns1:EmbosserUpdateL8V5Request>
};

declare variable $actualizacionLogiClientesCorpo1 as element(ns0:actualizacionLogiClientesCorpo) external;

xf:actualizacionLogiClientesCorpoIn($actualizacionLogiClientesCorpo1)]]></con:xquery>
</con:xqueryEntry>
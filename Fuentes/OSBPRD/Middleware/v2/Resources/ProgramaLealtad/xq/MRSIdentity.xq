(:: pragma bea:global-element-return element="ns0:identity" location="../../../BusinessServices/Mastercard/Common/xsd/CommonResponses.xsd" ::)

declare namespace ns0 = "http://common.ws.mcrewards.mastercard.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProgramaLealtad/xq/MRSIdentity/";

declare function xf:MRSIdentity($appID as xs:string,
    $institutionName as xs:string)
    as element(ns0:identity) {
        <ns0:identity>
            <ns0:appID>{ $appID }</ns0:appID>
            <ns0:institutionName>{ $institutionName }</ns0:institutionName>
        </ns0:identity>
};

declare variable $appID as xs:string external;
declare variable $institutionName as xs:string external;

xf:MRSIdentity($appID,
    $institutionName)
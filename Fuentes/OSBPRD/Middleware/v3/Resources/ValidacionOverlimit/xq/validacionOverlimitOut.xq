(:: pragma bea:global-element-return element="ns0:validacionOverlimitResponse" location="../xsd/ValidacionOverlimitTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ValidacionOverlimitTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionOverlimit/xq/validacionOverlimitOut/";

declare function xf:validacionOverlimitOut($org as xs:string,
    $clientId as xs:string,
    $currentBalance as xs:string,
    $numIdentidad as xs:string)
    as element(ns0:validacionOverlimitResponse) {
        <ns0:validacionOverlimitResponse>
            <ORG>{ $org }</ORG>
            <CLIENT_ID>{ $clientId }</CLIENT_ID>
            <CURRENT_BALANCE>{ $currentBalance }</CURRENT_BALANCE>
            <IDENTIFICATION_NUMBER>{ $numIdentidad }</IDENTIFICATION_NUMBER>
        </ns0:validacionOverlimitResponse>
};

declare variable $org as xs:string external;
declare variable $clientId as xs:string external;
declare variable $currentBalance as xs:string external;
declare variable $numIdentidad as xs:string external;

xf:validacionOverlimitOut($org,
    $clientId,
    $currentBalance,
    $numIdentidad)
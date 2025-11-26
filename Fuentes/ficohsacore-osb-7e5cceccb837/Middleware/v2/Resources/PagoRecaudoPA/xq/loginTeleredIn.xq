(:: pragma bea:global-element-return element="ns0:loginTelered" location="../../LoginTelered/xsd/loginTeleredTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/loginTeleredTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoPA/xq/loginTeleredIn/";

declare function xf:loginTeleredIn($forceNewSession as xs:boolean,
    $channel as xs:string)
    as element(ns0:loginTelered) {
        <ns0:loginTelered>
            <ns0:FORCE_NEW_SESSION>{ $forceNewSession }</ns0:FORCE_NEW_SESSION>
            <ns0:CHANNEL>{ $channel }</ns0:CHANNEL>
        </ns0:loginTelered>
};

declare variable $forceNewSession as xs:boolean external;
declare variable $channel as xs:string external;

xf:loginTeleredIn($forceNewSession,
    $channel)
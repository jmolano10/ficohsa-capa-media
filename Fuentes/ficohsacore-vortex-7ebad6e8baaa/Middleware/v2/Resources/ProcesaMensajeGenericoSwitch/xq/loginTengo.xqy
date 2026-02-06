xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:login" location="../../../BusinessServices/TENGO/xsd/XMLSchema_-1112897975.xsd" ::)

declare namespace ns0 = "http://www.utiba.com/delirium/ws/Misc";
declare namespace ns2 = "http://www.utiba.com/delirium/ws/StdQuery";
declare namespace ns1 = "urn:UMARKETSCWS";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoSwitch/xq/loginTengo/";

declare function xf:loginTengo($sessionId as xs:string,
    $initiator as xs:string,
    $pin as xs:string)
    as element(ns1:login) {
        <ns1:login>
            <ns1:loginRequest>
                <ns1:sessionid>{ $sessionId }</ns1:sessionid>
                <ns1:initiator>{ $initiator }</ns1:initiator>
                <ns1:pin>{ $pin }</ns1:pin>
            </ns1:loginRequest>
        </ns1:login>
};

declare variable $sessionId as xs:string external;
declare variable $initiator as xs:string external;
declare variable $pin as xs:string external;

xf:loginTengo($sessionId,
    $initiator,
    $pin)
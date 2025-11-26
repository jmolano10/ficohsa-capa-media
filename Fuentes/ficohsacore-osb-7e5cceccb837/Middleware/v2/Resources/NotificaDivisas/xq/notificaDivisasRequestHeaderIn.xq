(:: pragma bea:global-element-return element="ns0:Action" location="../../../BusinessServices/notificaDivisasEncabezado/xsd/WS_Addressing.xsd" ::)

declare namespace ns0 = "http://www.w3.org/2005/08/addressing";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaDivisas/xq/notificaDivisasRequestHeaderIn/";

declare function xf:notificaDivisasRequestHeaderIn($action as xs:string)
    as element(ns0:Action) {
        <ns0:Action>{ $action }</ns0:Action>
};

declare variable $action as xs:string external;

xf:notificaDivisasRequestHeaderIn($action)

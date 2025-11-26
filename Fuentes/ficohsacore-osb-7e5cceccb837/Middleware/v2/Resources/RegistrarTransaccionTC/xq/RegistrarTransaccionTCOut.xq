(:: pragma bea:global-element-return element="ns0:RegistrarTransaccionTCResponse" location="../xsd/RegistrarTransaccionTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/RegistrarTransaccionTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarTransaccionTC/xq/RegistrarTransaccionTCOut/";

declare function xf:RegistrarTransaccionTCOut($AuthorizationCode as xs:string,
    $DateTimeAut as xs:string,
    $CoreAut as xs:string,
    $RRN37 as xs:string)
    as element(ns0:RegistrarTransaccionTCResponse) {
        <ns0:RegistrarTransaccionTCResponse>
            <TRANSACTION_AUT>{ $AuthorizationCode }</TRANSACTION_AUT>
            <DATETIME_AUT>{ $DateTimeAut }</DATETIME_AUT>
            <DATETIME_CORE>{ $CoreAut }</DATETIME_CORE>
            <REFERENCE_NUMBER>{ $RRN37 }</REFERENCE_NUMBER>
        </ns0:RegistrarTransaccionTCResponse>
};

declare variable $RRN37 as xs:string external;
declare variable $AuthorizationCode as xs:string external;
declare variable $DateTimeAut as xs:string external;
declare variable $CoreAut as xs:string external;

xf:RegistrarTransaccionTCOut($AuthorizationCode,
    $DateTimeAut,
    $CoreAut,
    $RRN37)

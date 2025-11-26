(:: pragma bea:global-element-return element="ns0:NotificaEstadoRemesaCreditoCuentaResponse" location="../xsd/notificaEstadoRemesaCreditoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoRemesaCreditoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEstadoRemesaCreditoCuenta/xq/notificaEstadoRemesaEnviarCorreoOut/";

declare function xf:notificaEstadoRemesaEnviarCorreoOut($MESSAGE as xs:string,
    $DATE as xs:string)
    as element(ns0:NotificaEstadoRemesaCreditoCuentaResponse) {
        <ns0:NotificaEstadoRemesaCreditoCuentaResponse>
            <MESSAGE>{ $MESSAGE }</MESSAGE>
            <DATE>{ $DATE }</DATE>
        </ns0:NotificaEstadoRemesaCreditoCuentaResponse>
};

declare variable $MESSAGE as xs:string external;
declare variable $DATE as xs:string external;

xf:notificaEstadoRemesaEnviarCorreoOut($MESSAGE,
    $DATE)
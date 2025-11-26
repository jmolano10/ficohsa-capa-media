(:: pragma bea:global-element-return element="ns0:desbloqueoFondosCuenta" location="../../DesbloqueoFondosCuenta/xsd/desbloqueoFondosCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/desbloqueoFondosCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntajeCredito/xq/desbloqueoFondosCuentaIn/";

declare function xf:desbloqueoFondosCuentaIn($lockReference as xs:string)
    as element(ns0:desbloqueoFondosCuenta) {
        <ns0:desbloqueoFondosCuenta>
            <LOCK_ID>{ $lockReference }</LOCK_ID>
        </ns0:desbloqueoFondosCuenta>
};

declare variable $lockReference as xs:string external;

xf:desbloqueoFondosCuentaIn($lockReference)

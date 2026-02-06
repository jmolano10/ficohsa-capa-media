xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:desbloqueoFondosCuenta" location="../../DesbloqueoFondosCuenta/xsd/desbloqueoFondosCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/desbloqueoFondosCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarFinanciamiento/xq/desbloqueoFondosCuentasIn/";

declare function xf:desbloqueoFondosCuentasIn($id as xs:string)
    as element(ns0:desbloqueoFondosCuenta) {
        <ns0:desbloqueoFondosCuenta>
            <LOCK_ID>{ $id }</LOCK_ID>
        </ns0:desbloqueoFondosCuenta>
};

declare variable $id as xs:string external;

xf:desbloqueoFondosCuentasIn($id)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../v2/BusinessServices/ABKGT/BancaSat/transaccionBancaSat/xsd/TRANSACCION_BANCASAT_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TRANSACCION_BANCASAT";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoBancaSat/xq/pagoBancaSatTransaccion/";

declare function xf:pagoBancaSatTransaccion($cuentaDebito as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_NUMERO_CUENTA>{ data($cuentaDebito) }</ns0:PN_NUMERO_CUENTA>
        </ns0:InputParameters>
};

declare variable $cuentaDebito as xs:string external;

xf:pagoBancaSatTransaccion($cuentaDebito)
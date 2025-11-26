(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xq/consultaMaestraSaldoCuentaGTIn/";

declare function xf:consultaMaestraSaldoCuentaGTIn($accNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ACCOUNT_NUMBER>{ $accNumber }</ns0:PV_ACCOUNT_NUMBER>
        </ns0:InputParameters>
};

declare variable $accNumber as xs:string external;

xf:consultaMaestraSaldoCuentaGTIn($accNumber)
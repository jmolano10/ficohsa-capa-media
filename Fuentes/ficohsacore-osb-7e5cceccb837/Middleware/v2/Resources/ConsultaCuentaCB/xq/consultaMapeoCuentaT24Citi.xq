(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaMapeoCuentaT24Citi/xsd/consultaMapeoCuentaT24Citi_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMapeoCuentaT24Citi";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaCB/xq/consultaMapeoCuentaT24Citi/";

declare function xf:consultaMapeoCuentaT24Citi($cuenta as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:NUMERO_CUENTA_P>{ $cuenta }</ns0:NUMERO_CUENTA_P>
        </ns0:InputParameters>
};

declare variable $cuenta as xs:string external;

xf:consultaMapeoCuentaT24Citi($cuenta)
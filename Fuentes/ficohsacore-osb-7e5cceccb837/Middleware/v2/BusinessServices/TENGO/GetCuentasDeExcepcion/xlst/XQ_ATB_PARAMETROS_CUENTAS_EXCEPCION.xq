(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/ATB_PARAMETROS_CUENTAS_EXCEPCION_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ATB_PARAMETROS_CUENTAS_EXCEPCION";
declare namespace xf = "http://tempuri.org/Middleware/v2/XLST/XQ_ATB_PARAMETROS_CUENTAS_EXCEPCION/";

declare function xf:XQ_ATB_PARAMETROS_CUENTAS_EXCEPCION($NUMERO_CUENTA as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_NUMERO_CUENTA>{ $NUMERO_CUENTA }</ns0:P_NUMERO_CUENTA>
        </ns0:InputParameters>
};

declare variable $NUMERO_CUENTA as xs:string external;

xf:XQ_ATB_PARAMETROS_CUENTAS_EXCEPCION($NUMERO_CUENTA)
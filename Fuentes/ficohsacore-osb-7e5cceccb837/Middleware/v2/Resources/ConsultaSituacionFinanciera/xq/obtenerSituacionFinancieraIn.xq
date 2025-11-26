(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/INTFC/obtenerSituacionFinanciera/xsd/obtenerSituacionFinanciera_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerSituacionFinanciera";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSituacionFinanciera/xq/obtenerSituacionFinancieraIn/";

declare function xf:obtenerSituacionFinancieraIn($uuid as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_REFERENCIA_LLAVE>{ $uuid }</ns0:PV_REFERENCIA_LLAVE>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;

xf:obtenerSituacionFinancieraIn($uuid)

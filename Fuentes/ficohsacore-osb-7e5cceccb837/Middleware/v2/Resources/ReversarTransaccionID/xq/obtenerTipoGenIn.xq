(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransaccionesGenericasCB/ObtenerTipoTrxGen/xsd/obtenerTipoTrxGen_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoTrxGen";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccionID/xq/obtenerTipoGenIn/";

declare function xf:obtenerTipoGenIn($codOSB as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_COD_OSB>{ $codOSB }</ns0:PV_COD_OSB>
        </ns0:InputParameters>
};

declare variable $codOSB as xs:string external;

xf:obtenerTipoGenIn($codOSB)

(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../BusinessServices/TransaccionesGenericasCB/ObtenerParametrosCB/xsd/obtenerParametrosTrxGENCB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerParametrosTrxGENCB";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesGenericasCB/ProcesarTransaccionesGenericaCB/xq/obtenerParamCB/";

declare function xf:obtenerParamCB($idCorresponsal as xs:string,
    $pais as xs:string,
    $codOSB as xs:string,
    $tipoTRX as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TIPO_TRX>{ $tipoTRX }</ns0:PV_TIPO_TRX>
            <ns0:PV_ID_CORRESPONSAL>{ $idCorresponsal }</ns0:PV_ID_CORRESPONSAL>
            <ns0:PV_PAIS>{ $pais }</ns0:PV_PAIS>
            <ns0:PV_COD_OSB>{ $codOSB }</ns0:PV_COD_OSB>
        </ns0:InputParameters>
};

declare variable $idCorresponsal as xs:string external;
declare variable $pais as xs:string external;
declare variable $codOSB as xs:string external;
declare variable $tipoTRX as xs:string external;

xf:obtenerParamCB($idCorresponsal,
    $pais,
    $codOSB,
    $tipoTRX)

xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conDatoTarjeta_v3/xsd/conDatoTarjeta_v3_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta_v3";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoBloqueoTC/xq/consultaEstadoBloqueoTCNIIn/";

declare function xf:consultaEstadoBloqueoTCNIIn($card as xs:string,
    $pais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $pais }</ns0:Pais>
            <ns0:NumTarjeta>{ $card }</ns0:NumTarjeta>
        </ns0:InputParameters>
};

declare variable $card as xs:string external;
declare variable $pais as xs:string external;

xf:consultaEstadoBloqueoTCNIIn($card,
    $pais)
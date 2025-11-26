(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/ConsultaRutaServicio_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRutaServicio";
declare namespace xf = "http://tempuri.org/Middleware/v3/BusinessServices/ConsultaRutaServicio/xq/ConsultaRutaServicio/";

declare function xf:ConsultaRutaServicio($IDServicio as xs:string,
    $BancoOrigen as xs:string,
    $BancoDestino as xs:string,
    $IDInvocador as xs:string,
    $IDAlterno as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDSERVICIO>{ $IDServicio }</ns0:PV_IDSERVICIO>
            <ns0:PV_BANCOORIGEN>{ $BancoOrigen }</ns0:PV_BANCOORIGEN>
            <ns0:PV_BANCODESTINO>{ $BancoDestino }</ns0:PV_BANCODESTINO>
            <ns0:PV_IDINVOCADOR>{ $IDInvocador }</ns0:PV_IDINVOCADOR>
            <ns0:PV_IDALTERNO>{ $IDAlterno }</ns0:PV_IDALTERNO>
        </ns0:InputParameters>
};

declare variable $IDServicio as xs:string external;
declare variable $BancoOrigen as xs:string external;
declare variable $BancoDestino as xs:string external;
declare variable $IDInvocador as xs:string external;
declare variable $IDAlterno as xs:string external;

xf:ConsultaRutaServicio($IDServicio,
    $BancoOrigen,
    $BancoDestino,
    $IDInvocador,
    $IDAlterno)

(:: pragma bea:global-element-parameter parameter="$retiroEfectivoTC" element="ns1:retiroEfectivoTC" location="../xsd/retiroEfectivoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/PAGOSWSTC/registraPagoTC/xsd/registraPagoTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraPagoTC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoTC/xq/registraPagoTCHNIn/";

declare function xf:registraPagoTCHNIn($retiroEfectivoTC as element(ns1:retiroEfectivoTC),
    $ORG as xs:string,
    $userName as xs:string,
    $sourceBank as xs:string,
    $destinationBank as xs:string,
    $RRN37 as xs:string,
    $authorizationCode as xs:string,
    $merchantNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_MERCHANTNUMBER>{ $merchantNumber }</ns0:PV_MERCHANTNUMBER>
            <ns0:PV_NUMEROTARJETA>{ data($retiroEfectivoTC/CREDIT_CARD) }</ns0:PV_NUMEROTARJETA>
            <ns0:PV_TIPOOPERACION>A</ns0:PV_TIPOOPERACION>
            <ns0:PN_ORGANIZACION>{ $ORG }</ns0:PN_ORGANIZACION>
            <ns0:PV_MONEDATRANSACCION>{ data($retiroEfectivoTC/CURRENCY) }</ns0:PV_MONEDATRANSACCION>
            <ns0:PN_TASACAMBIO>1</ns0:PN_TASACAMBIO>
            <ns0:PN_TIPOTRANSACCION>1</ns0:PN_TIPOTRANSACCION>
            <ns0:PV_CODIGOUSUARIO>{ $userName }</ns0:PV_CODIGOUSUARIO>
            <ns0:PV_SECUENCIAMOVIMIENTO>{ $RRN37 }</ns0:PV_SECUENCIAMOVIMIENTO>
            <ns0:PN_VALOREFECTIVO>{ data($retiroEfectivoTC/AMOUNT) }</ns0:PN_VALOREFECTIVO>
            <ns0:PV_BANCOORIGEN>{ $sourceBank }</ns0:PV_BANCOORIGEN>
            <ns0:PV_BANCODESTINO>{ $destinationBank }</ns0:PV_BANCODESTINO>
            <ns0:PV_DESCRIPCIONTRANSACCION>Retiro Efectivo</ns0:PV_DESCRIPCIONTRANSACCION>
            <ns0:PV_CANAL>13</ns0:PV_CANAL>
            <ns0:PV_NUMEROAUTORIZACION>{ data($authorizationCode) }</ns0:PV_NUMEROAUTORIZACION>
            <ns0:PV_APLICADO>N</ns0:PV_APLICADO>
            <ns0:PV_APLICARENLINEA>N</ns0:PV_APLICARENLINEA>
        </ns0:InputParameters>
};

declare variable $retiroEfectivoTC as element(ns1:retiroEfectivoTC) external;
declare variable $ORG as xs:string external;
declare variable $userName as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $RRN37 as xs:string external;
declare variable $authorizationCode as xs:string external;
declare variable $merchantNumber as xs:string external;

xf:registraPagoTCHNIn($retiroEfectivoTC,
    $ORG,
    $userName,
    $sourceBank,
    $destinationBank,
    $RRN37,
    $authorizationCode,
    $merchantNumber)
(:: pragma bea:global-element-parameter parameter="$retiroEfectivoTC" element="ns1:retiroEfectivoTC" location="../xsd/retiroEfectivoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/MasterData/conRegistraPagoTCRG/xsd/conRegistraPagoTCRG_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conRegistraPagoTCRG";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoTC/xq/registraPagoTCDBHNIn/";

declare function xf:registraPagoTCMDHNIn($retiroEfectivoTC as element(ns1:retiroEfectivoTC),
    $ORG as xs:string,
    $userName as xs:string,
    $sourceBank as xs:string,
    $destinationBank as xs:string,
    $RRN37 as xs:string,
    $authorizationCode as xs:string,
    $merchantNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:Pais>HND</ns0:Pais>
            <ns0:MerchantNumber>{ $merchantNumber }</ns0:MerchantNumber>
            <ns0:NumTarjeta>{ data($retiroEfectivoTC/CREDIT_CARD) }</ns0:NumTarjeta>
            <ns0:TipoOperacion>A</ns0:TipoOperacion>
            <ns0:Organizacion>{ $ORG }</ns0:Organizacion>
            <ns0:MonedaTransaccion>{ data($retiroEfectivoTC/CURRENCY) }</ns0:MonedaTransaccion>
            <ns0:TasaCambio>1</ns0:TasaCambio>
            <ns0:TipoTransaccion>1</ns0:TipoTransaccion>
            <ns0:CodigoUsuario>{ $userName }</ns0:CodigoUsuario>
            <ns0:SecuenciaMovimiento>{ $RRN37 }</ns0:SecuenciaMovimiento>
            <ns0:ValorEfectivo>{ data($retiroEfectivoTC/AMOUNT) }</ns0:ValorEfectivo>
            <ns0:BancoOrigen>{ $sourceBank }</ns0:BancoOrigen>
            <ns0:BancoDestino>{ $destinationBank }</ns0:BancoDestino>
            <ns0:DescripcionTXN>Retiro Efectivo</ns0:DescripcionTXN>
            <ns0:Canal>13</ns0:Canal>
            <ns0:NoAutorizacion>{ data($authorizationCode) }</ns0:NoAutorizacion>
            <ns0:Aplicado>N</ns0:Aplicado>
            <ns0:AplicarEnLinea>N</ns0:AplicarEnLinea>
            <ns0:CodigoError>0</ns0:CodigoError>
            <ns0:MensajeError>temp</ns0:MensajeError>
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

xf:registraPagoTCMDHNIn($retiroEfectivoTC,
    $ORG,
    $userName,
    $sourceBank,
    $destinationBank,
    $RRN37,
    $authorizationCode,
    $merchantNumber)
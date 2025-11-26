(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito1" element="ns0:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PWS/retiroTC/xsd/retiroTC_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/retiroTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/retiroTCIn/";

declare function xf:retiroTCIn($retiroTarjetaCredito1 as element(ns0:retiroTarjetaCredito),
    $org as xs:string,
    $vPrespCode as xs:string,
    $authorizationCode as xs:string,
    $aplicado as xs:string,
    $rrn37 as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_MERCHAT_NUMBER>99999998</ns1:PV_MERCHAT_NUMBER>
            <ns1:PV_NUMERO_TARJETA>{ data($retiroTarjetaCredito1/CREDIT_CARD_INFO/EXPIRATION_DATE) }</ns1:PV_NUMERO_TARJETA>
            <ns1:PN_VALOR_EFECTIVO>{ data($retiroTarjetaCredito1/AMOUNT) }</ns1:PN_VALOR_EFECTIVO>
            <ns1:PN_ORG>{ data($org) }</ns1:PN_ORG>
            <ns1:PN_ISO_MONEDA>{ data($retiroTarjetaCredito1/CURRENCY) }</ns1:PN_ISO_MONEDA>
            <ns1:PV_NUMERO_AUTORIZACION>{ data($authorizationCode) }</ns1:PV_NUMERO_AUTORIZACION>
            <ns1:PV_REFERENCIA_RECUPERACION>{ data($rrn37) }</ns1:PV_REFERENCIA_RECUPERACION>
            <ns1:PV_APLICADO>{ data($aplicado) }</ns1:PV_APLICADO>
            <ns1:PV_RESPONSE_CODE>{ data($vPrespCode) }</ns1:PV_RESPONSE_CODE>
        </ns1:InputParameters>
};

declare variable $retiroTarjetaCredito1 as element(ns0:retiroTarjetaCredito) external;
declare variable $org as xs:string external;
declare variable $vPrespCode as xs:string external;
declare variable $authorizationCode as xs:string external;
declare variable $aplicado as xs:string external;
declare variable $rrn37 as xs:string external;

xf:retiroTCIn($retiroTarjetaCredito1,
    $org,
    $vPrespCode,
    $authorizationCode,
    $aplicado,
    $rrn37)
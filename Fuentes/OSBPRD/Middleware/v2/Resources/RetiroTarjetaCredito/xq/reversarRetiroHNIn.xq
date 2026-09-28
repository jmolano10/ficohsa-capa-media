(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns1:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:reversarRetiro" location="../../../BusinessServices/ALCN/tarjetaCredito/wsdl/TarjetaDeCredito.wsdl" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/reversarRetiroIn/";

declare function xf:reversarRetiroIn($requestHeader as element(ns2:RequestHeader),
    $retiroTarjetaCredito as element(ns1:retiroTarjetaCredito),
    $secuenciaIdRetiro as xs:string,
    $idRefPago as xs:string)
    as element(ns0:reversarRetiro) {
        <ns0:reversarRetiro>
            <ns0:noTarjetaCredito>{ data($retiroTarjetaCredito/CREDIT_CARD_INFO/VALUE) }</ns0:noTarjetaCredito>
            {
                for $EXPIRATION_DATE in $retiroTarjetaCredito/CREDIT_CARD_INFO/EXPIRATION_DATE
                return
                    <ns0:fechaExpiracion>{ data($EXPIRATION_DATE) }</ns0:fechaExpiracion>
            }
            <ns0:montoRetiro>{ data($retiroTarjetaCredito/AMOUNT) }</ns0:montoRetiro>
            <ns0:monedaRetiro>
            {
                    let $currency  := (fn:string($retiroTarjetaCredito/CURRENCY/text()))  
                    return
                        if ($currency = "HNL") then
                            (340)
                        else 
                            if ($currency = "USD") then
                                (840)
                            else 
                                0
            }
            </ns0:monedaRetiro>
            <ns0:canalRetiro>{ data($requestHeader/Authentication/UserName) }</ns0:canalRetiro>
            <ns0:fechaRetiro>{ fn-bea:date-to-string-with-format('MMDDYYYY', fn:current-date()) }</ns0:fechaRetiro>
            <ns0:idRefRetiro>{ data($secuenciaIdRetiro) }</ns0:idRefRetiro>
            <ns0:codigoRetiro>{ $idRefPago }</ns0:codigoRetiro>
        </ns0:reversarRetiro>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $retiroTarjetaCredito as element(ns1:retiroTarjetaCredito) external;
declare variable $secuenciaIdRetiro as xs:string external;
declare variable $idRefPago as xs:string external;

xf:reversarRetiroIn($requestHeader,
    $retiroTarjetaCredito,
    $secuenciaIdRetiro,
    $idRefPago)
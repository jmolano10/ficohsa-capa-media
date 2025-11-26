(:: pragma bea:global-element-parameter parameter="$anulacionConsumoTarjetaCredito" element="ns1:anulacionConsumoTarjetaCredito" location="../../PuntoVentaVirtual/xsd/PuntoVentaVirtualTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AuthorizationRequest" location="../../../BusinessServices/VisaNet/wsdl/paymentcommerce_1.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/puntoVentaVirtualTypes";
declare namespace ns0 = "http://general_computing.com/paymentgw/types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AnulacionConsumoTarjetaCredito/xq/anulacionConsumoTarjetaCreditoVisanetIn/";

declare function xf:anulacionConsumoTarjetaCreditoVisanetIn($anulacionConsumoTarjetaCredito as element(ns1:anulacionConsumoTarjetaCredito),
    $posEntryMode as xs:string,
    $paymentgwIP as xs:string,
    $shopperIP as xs:string,
    $merchantServerIP as xs:string,
    $merchantUser as xs:string,
    $merchantPasswd as xs:string,
    $terminalId as xs:string,
    $merchant as xs:string,
    $messageType as xs:string,
    $auditNumber as xs:string)
    as element(ns0:AuthorizationRequest) {
        <ns0:AuthorizationRequest>
            <ns0:AuthorizationRequest>
                <ns0:posEntryMode>{ $posEntryMode }</ns0:posEntryMode>
                <ns0:pan>{ data($anulacionConsumoTarjetaCredito/CREDIT_CARD_NUMBER) }</ns0:pan>
                <ns0:expdate/>
                <ns0:amount/>
                <ns0:track2Data/>
                <ns0:cvv2/>
                <ns0:paymentgwIP>{ $paymentgwIP }</ns0:paymentgwIP>
                <ns0:shopperIP>{ $shopperIP }</ns0:shopperIP>
                <ns0:merchantServerIP>{ $merchantServerIP }</ns0:merchantServerIP>
                <ns0:merchantUser>{ $merchantUser }</ns0:merchantUser>
                <ns0:merchantPasswd>{ $merchantPasswd }</ns0:merchantPasswd>
                <ns0:terminalId>{ $terminalId }</ns0:terminalId>
                <ns0:merchant>{ $merchant }</ns0:merchant>
                <ns0:messageType>{ $messageType }</ns0:messageType>
                {
                    let $result :=
                        for $REFERENCE in $anulacionConsumoTarjetaCredito/REFERENCES/REFERENCE
                        return
                            <ns0:auditNumber>{ data($REFERENCE/VALUE) }</ns0:auditNumber>
                    return
                        $result[1]
                }
                <ns0:additionalData/>
            </ns0:AuthorizationRequest>
        </ns0:AuthorizationRequest>
};

declare variable $anulacionConsumoTarjetaCredito as element(ns1:anulacionConsumoTarjetaCredito) external;
declare variable $posEntryMode as xs:string external;
declare variable $paymentgwIP as xs:string external;
declare variable $shopperIP as xs:string external;
declare variable $merchantServerIP as xs:string external;
declare variable $merchantUser as xs:string external;
declare variable $merchantPasswd as xs:string external;
declare variable $terminalId as xs:string external;
declare variable $merchant as xs:string external;
declare variable $messageType as xs:string external;
declare variable $auditNumber as xs:string external;

xf:anulacionConsumoTarjetaCreditoVisanetIn($anulacionConsumoTarjetaCredito,
    $posEntryMode,
    $paymentgwIP,
    $shopperIP,
    $merchantServerIP,
    $merchantUser,
    $merchantPasswd,
    $terminalId,
    $merchant,
    $messageType,
    $auditNumber)
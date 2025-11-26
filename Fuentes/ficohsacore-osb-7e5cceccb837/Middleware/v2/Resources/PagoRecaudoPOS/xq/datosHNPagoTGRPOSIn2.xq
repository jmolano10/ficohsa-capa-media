(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns1:pagoRecaudo" location="../xsd/pagoRecaudoTGRPOSTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Pago" location="../../../BusinessServices/RecaudoPOSws/xsd/svcTGR1_GD.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoPOS/xq/datosHNPagoTGRPOSIn2/";

declare function xf:datosHNPagoTGRPOSIn2($pagoRecaudo1 as element(ns1:pagoRecaudo),
    $nroReferencia as xs:string,
    $mecanismo as xs:string,
    $fecha as xs:string,
    $estado as xs:string,
    $mensaje as xs:string)
    as element(ns0:Pago) {
        <ns0:Pago>
            <ns0:codigoTGR>{ data($pagoRecaudo1/DEBTOR_CODE) }</ns0:codigoTGR>
            <ns0:nroReferencia>{ $nroReferencia }</ns0:nroReferencia>
            <ns0:mecanismo>{ $mecanismo }</ns0:mecanismo>
            <ns0:cargo>{ data($pagoRecaudo1/ADDITIONAL_INFO/DATA[2]) }</ns0:cargo>
            <ns0:monto>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</ns0:monto>
            <ns0:moneda>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:moneda>
            <ns0:fecha>{ $fecha }</ns0:fecha>
            <ns0:estado>{ $estado }</ns0:estado>
            <ns0:mensaje>{ $mensaje }</ns0:mensaje>
            <ns0:response>{ fn:concat( '{"authTarjeta":"', data($pagoRecaudo1/ADDITIONAL_INFO/DATA[1]), '"}' ) }</ns0:response>
        </ns0:Pago>
};

declare variable $pagoRecaudo1 as element(ns1:pagoRecaudo) external;
declare variable $nroReferencia as xs:string external;
declare variable $mecanismo as xs:string external;
declare variable $fecha as xs:string external;
declare variable $estado as xs:string external;
declare variable $mensaje as xs:string external;

xf:datosHNPagoTGRPOSIn2($pagoRecaudo1,
    $nroReferencia,
    $mecanismo,
    $fecha,
    $estado,
    $mensaje)

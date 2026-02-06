xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validarInformacionPago" element="ns0:OutputParameters" location="../../../BusinessServices/TercerosPA/validarInformacionPago/xsd/validarInformacionPago_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/ABKPA/pignoracionSaldoRecaudo/xsd/pignoracionSaldoRecaudo_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pignoracionSaldoRecaudo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarInformacionPago";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoPA/xq/pignoracionSaldoRecaudoIn/";

declare function xf:pignoracionSaldoRecaudoIn($pagoRecaudo as element(ns1:pagoRecaudo),
    $validarInformacionPago as element(ns0:OutputParameters),
    $secuencia as xs:string, $descripcion as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            {
                for $DEBIT_ACCOUNT in $pagoRecaudo/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                return
                    <ns2:PV_CUENTADEBITO>{ data($DEBIT_ACCOUNT) }</ns2:PV_CUENTADEBITO>
            }
            <ns2:PN_MONTO>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</ns2:PN_MONTO>
            <ns2:PV_MONEDA>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns2:PV_MONEDA>
            <ns2:PN_TRANSACCION>{ data($validarInformacionPago/ns0:PN_TRANSACCION) }</ns2:PN_TRANSACCION>
            <ns2:PV_USUARIOSERVICIO>VIRTUAL</ns2:PV_USUARIOSERVICIO>
            <ns2:PN_SECUENCIA>{ $secuencia }</ns2:PN_SECUENCIA>
            <ns2:PV_DESCRIPCION>{$descripcion}</ns2:PV_DESCRIPCION>
        </ns2:InputParameters>
};

declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $validarInformacionPago as element(ns0:OutputParameters) external;
declare variable $secuencia as xs:string external;
declare variable $descripcion as xs:string external;

xf:pignoracionSaldoRecaudoIn($pagoRecaudo,
    $validarInformacionPago,
    $secuencia,$descripcion)
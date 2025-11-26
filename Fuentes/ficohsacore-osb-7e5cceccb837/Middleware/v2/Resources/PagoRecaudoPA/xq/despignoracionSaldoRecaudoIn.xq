(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validarInformacionPago" element="ns2:OutputParameters" location="../../../BusinessServices/TercerosPA/validarInformacionPago/xsd/validarInformacionPago_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/despignoracionSaldoRecaudo/xsd/despignoracionSaldoRecaudo_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/despignoracionSaldoRecaudo";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarInformacionPago";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoPA/xq/despignoracionSaldoRecaudo/";

declare function xf:despignoracionSaldoRecaudoIn($codigoPignoracion as xs:string,
    $pagoRecaudo as element(ns1:pagoRecaudo),
    $secuenciaPago as xs:string,
    $codigoErrorTelered as xs:string,
    $validarInformacionPago as element(ns2:OutputParameters))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_CODIGOPIGNORACION>{ $codigoPignoracion }</ns0:PN_CODIGOPIGNORACION>
            {
                for $DEBIT_ACCOUNT in $pagoRecaudo/PAYMENT_INFORMATION/DEBIT_ACCOUNT
                return
                    <ns0:PV_CUENTADEBITO>{ data($DEBIT_ACCOUNT) }</ns0:PV_CUENTADEBITO>
            }
            <ns0:PN_MONTO>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</ns0:PN_MONTO>
            <ns0:PV_MONEDA>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:PV_MONEDA>
            <ns0:PN_TRANSACCION>{ data($validarInformacionPago/ns2:PN_TRANSACCION) }</ns0:PN_TRANSACCION>
            <ns0:PV_USUARIOSERVICIO>VIRTUAL</ns0:PV_USUARIOSERVICIO>
            <ns0:PN_SECUENCIA>{ $secuenciaPago }</ns0:PN_SECUENCIA>
            <ns0:PV_DESCRIPCION>{fn:concat("Pago ",data($validarInformacionPago/ns2:PV_NOMBRECOBRANZA),' Código de Deudor ',$pagoRecaudo/DEBTOR_CODE)}</ns0:PV_DESCRIPCION>
            <ns0:PN_RESPUESTATELERED>{ $codigoErrorTelered }</ns0:PN_RESPUESTATELERED>
        </ns0:InputParameters>
};

declare variable $codigoPignoracion as xs:string external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $CodigoTransaccion as xs:string external;
declare variable $secuenciaPago as xs:string external;
declare variable $codigoErrorTelered as xs:string external;
declare variable $validarInformacionPago as element(ns2:OutputParameters) external;

xf:despignoracionSaldoRecaudoIn($codigoPignoracion,
    $pagoRecaudo,
    $secuenciaPago,
    $codigoErrorTelered,
    $validarInformacionPago)
(:: pragma bea:global-element-parameter parameter="$pagarSaldoResponse1" element="ns0:PagarSaldoResponse" location="../../../BusinessServices/RecaudoEEHws/wsdl/recaudoEEHSOAP.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudoResponse" location="../xsd/pagoRecaudoEEHTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://schemas.enee-pay.hn/contract";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoEEH/xq/pagoOut/";

declare function xf:pagoOut($pagarSaldoResponse1 as element(ns0:PagarSaldoResponse),
    $codigoSucursal1 as xs:string,
    $terminal1 as xs:string,
    $usuario1 as xs:string,
    $contractName as xs:string,
    $branchName as xs:string,
    $paymentMethod as xs:string,
    $paymentCurrency as xs:string,
    $debitAccount as xs:string)
    as element(ns1:pagoRecaudoResponse) {
        <ns1:pagoRecaudoResponse>
            <CONTRACT_NAME>{ $contractName }</CONTRACT_NAME>
            {
                for $Nombre in $pagarSaldoResponse1/ns0:Factura/ns0:Nombre
                return
                    <DEBTOR_NAME>{ data($Nombre) }</DEBTOR_NAME>
            }
            {
                for $Cajero in $pagarSaldoResponse1/ns0:Cajero
                return
                    <INPUTTER>{ data($Cajero) }</INPUTTER>
            }
            <DATE_TIME>{ fn:concat(fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()),fn-bea:dateTime-to-string-with-format("HHmm", fn:adjust-dateTime-to-timezone(current-dateTime(),()))) }</DATE_TIME>
            <BRANCH_NAME>{ $branchName }</BRANCH_NAME>
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ $paymentMethod }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ $paymentCurrency }</PAYMENT_CURRENCY>
                <PAYMENT_AMOUNT>{ string($pagarSaldoResponse1/ns0:Factura/ns0:TotalCalculado) }</PAYMENT_AMOUNT>
                <DEBIT_ACCOUNT>{ $debitAccount }</DEBIT_ACCOUNT>
            </PAYMENT_INFORMATION>
            <BILL_DETAIL>{fn:concat(fn:concat(data($pagarSaldoResponse1/ns0:CheckSum),'||',data($pagarSaldoResponse1/ns0:ReferenciaPago)),'||',data($pagarSaldoResponse1/ns0:IdTransaccionAgenteRecaudador))}</BILL_DETAIL>
        </ns1:pagoRecaudoResponse>
};

declare variable $pagarSaldoResponse1 as element(ns0:PagarSaldoResponse) external;
declare variable $codigoSucursal1 as xs:string external;
declare variable $terminal1 as xs:string external;
declare variable $usuario1 as xs:string external;
declare variable $contractName as xs:string external;
declare variable $branchName as xs:string external;
declare variable $paymentMethod as xs:string external;
declare variable $paymentCurrency as xs:string external;
declare variable $debitAccount as xs:string external;

xf:pagoOut($pagarSaldoResponse1,
    $codigoSucursal1,
    $terminal1,
    $usuario1,
    $contractName,
    $branchName,
    $paymentMethod,
    $paymentCurrency,
    $debitAccount)
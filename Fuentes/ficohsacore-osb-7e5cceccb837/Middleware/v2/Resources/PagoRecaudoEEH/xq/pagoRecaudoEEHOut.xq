(:: pragma bea:global-element-parameter parameter="$datosHNPagoResponse" element="ns1:DatosHNPagoResponse" location="../../../BusinessServices/RecaudoEEHws/wsdl/recaudoEEHws.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:pagoRecaudoResponse" location="../xsd/pagoRecaudoEEHTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://schemas.servicestack.net/types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoEEH/xq/pagoRecaudoEEHOut/";

declare function xf:pagoRecaudoEEHOut($datosHNPagoResponse as element(ns1:DatosHNPagoResponse),
    $contractName as xs:string,
    $branchName as xs:string,
    $paymentMethod as xs:string,
    $paymentCurrency as xs:string,
    $debitAccount as xs:string)
    as element(ns0:pagoRecaudoResponse) {
        <ns0:pagoRecaudoResponse>
            <CONTRACT_NAME>{ $contractName }</CONTRACT_NAME>
            {
                for $Nombre in $datosHNPagoResponse/ns1:DatosFactura/ns1:Nombre
                return
                    <DEBTOR_NAME>{ data($Nombre) }</DEBTOR_NAME>
            }
            {
                for $Cajero in $datosHNPagoResponse/ns1:Cajero
                return
                    <INPUTTER>{ data($Cajero) }</INPUTTER>
            }
            <DATE_TIME>{ fn:concat(fn-bea:date-to-string-with-format("yyyyMMdd",fn:current-date()),fn-bea:dateTime-to-string-with-format("HHmm", fn:adjust-dateTime-to-timezone(current-dateTime(),()))) }</DATE_TIME>
            <BRANCH_NAME>{ $branchName }</BRANCH_NAME>
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{ $paymentMethod }</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ $paymentCurrency }</PAYMENT_CURRENCY>
                <PAYMENT_AMOUNT>{ data($datosHNPagoResponse/ns1:DatosFactura/ns1:Totalcalculado) }</PAYMENT_AMOUNT>
                <DEBIT_ACCOUNT>{ $debitAccount }</DEBIT_ACCOUNT>
            </PAYMENT_INFORMATION>
            <BILL_DETAIL>{fn:concat(fn:concat(data($datosHNPagoResponse/ns1:CheckSum),'||',data($datosHNPagoResponse/ns1:ReferenciaPago)),'||',data($datosHNPagoResponse/ns1:IdTransaccionBanco))}</BILL_DETAIL>
        </ns0:pagoRecaudoResponse>
};

declare variable $datosHNPagoResponse as element(ns1:DatosHNPagoResponse) external;
declare variable $contractName as xs:string external;
declare variable $branchName as xs:string external;
declare variable $paymentMethod as xs:string external;
declare variable $paymentCurrency as xs:string external;
declare variable $debitAccount as xs:string external;

xf:pagoRecaudoEEHOut($datosHNPagoResponse,
    $contractName,
    $branchName,
    $paymentMethod,
    $paymentCurrency,
    $debitAccount)
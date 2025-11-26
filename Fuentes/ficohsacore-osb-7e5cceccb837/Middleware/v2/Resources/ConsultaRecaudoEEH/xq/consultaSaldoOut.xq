(:: pragma bea:global-element-parameter parameter="$saldoResponse1" element="ns1:SaldoResponse" location="../../../BusinessServices/RecaudoEEHws/wsdl/recaudoEEHSOAP.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaRecaudoResponse" location="../xsd/consultaRecaudoEEHTypes.xsd" ::)

declare namespace ns1 = "http://schemas.enee-pay.hn/contract";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoEEH/xq/consultaSaldoOut/";

declare function xf:consultaSaldoOut($saldoResponse1 as element(ns1:SaldoResponse),
    $contractID as xs:string,
    $contractName as xs:string,
    $billNumber as xs:string,
    $billCurrency as xs:string,
    $lateFee as xs:string,
    $totalAmountUSD as xs:string,
    $codigoSucursal1 as xs:string,
    $terminal1 as xs:string,
    $usuario1 as xs:string)
    as element(ns0:consultaRecaudoResponse) {
        <ns0:consultaRecaudoResponse>
            <CONTRACT_ID>{ $contractID }</CONTRACT_ID>
            <CONTRACT_NAME>{ $contractName }</CONTRACT_NAME>
            {
                for $ClavePrimaria in $saldoResponse1/ns1:Factura/ns1:ClavePrimaria
                return
                    <DEBTOR_CODE>{ data($ClavePrimaria) }</DEBTOR_CODE>
            }
            {
                for $Nombre in $saldoResponse1/ns1:Factura/ns1:Nombre
                return
                    <DEBTOR_NAME>{ data($Nombre) }</DEBTOR_NAME>
            }
            <BILLS>
                <BILL_RECORD>
                    <BILL_NUMBER>{ $billNumber }</BILL_NUMBER>
                    <BILL_CURRENCY>{ $billCurrency }</BILL_CURRENCY>
                    {
                        for $FechaEmision in $saldoResponse1/ns1:Factura/ns1:FechaEmision
                        return
                            <BILL_DATE>{ data($FechaEmision) }</BILL_DATE>
                    }
                    <DUE_DATE>{ fn-bea:dateTime-to-string-with-format("YYYYMMdd", current-dateTime()) }</DUE_DATE>
                    <BILL_AMOUNT>{ string($saldoResponse1/ns1:Factura/ns1:TotalCalculado) }</BILL_AMOUNT>
                    <LATE_FEE>{ $lateFee }</LATE_FEE>
                    <TOTAL_AMOUNT_LOC>{ string($saldoResponse1/ns1:Factura/ns1:TotalCalculado) }</TOTAL_AMOUNT_LOC>
                    <TOTAL_AMOUNT_USD>{ $totalAmountUSD }</TOTAL_AMOUNT_USD>
                </BILL_RECORD>
            </BILLS>
        </ns0:consultaRecaudoResponse>
};

declare variable $saldoResponse1 as element(ns1:SaldoResponse) external;
declare variable $contractID as xs:string external;
declare variable $contractName as xs:string external;
declare variable $billNumber as xs:string external;
declare variable $billCurrency as xs:string external;
declare variable $lateFee as xs:string external;
declare variable $totalAmountUSD as xs:string external;
declare variable $codigoSucursal1 as xs:string external;
declare variable $terminal1 as xs:string external;
declare variable $usuario1 as xs:string external;

xf:consultaSaldoOut($saldoResponse1,
    $contractID,
    $contractName,
    $billNumber,
    $billCurrency,
    $lateFee,
    $totalAmountUSD,
    $codigoSucursal1,
    $terminal1,
    $usuario1)
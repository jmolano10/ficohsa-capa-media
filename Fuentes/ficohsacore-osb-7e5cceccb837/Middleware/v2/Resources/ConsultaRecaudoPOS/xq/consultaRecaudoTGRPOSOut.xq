(:: pragma bea:global-element-parameter parameter="$consultaResponse1" element="ns0:ConsultaResponse" location="../../../BusinessServices/RecaudoPOSws/xsd/svcTGR1_GD.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoResponse" location="../xsd/consultaRecaudoPOSTypes.xsd" ::)

declare namespace ns2 = "http://schemas.datacontract.org/2004/07/svcTGR1_GD";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoPOS/xq/consultaRecaudoPOSOut/";

declare function xf:consultaRecaudoPOSOut($consultaResponse1 as element(ns0:ConsultaResponse),
    $contractID as xs:string,
    $contractName as xs:string,
    $billNumber as xs:string,
    $billCurrency as xs:string,
    $lateFee as xs:string,
    $totalAmountUSD as xs:string)
    as element(ns1:consultaRecaudoResponse) {
        <ns1:consultaRecaudoResponse>
            <CONTRACT_ID>{ $contractID }</CONTRACT_ID>
            <CONTRACT_NAME>{ $contractName }</CONTRACT_NAME>
            {
                for $NRO_RECIBO in $consultaResponse1/ns0:ConsultaResult/ns2:DataC/ns2:NRO_RECIBO
                return
                    <DEBTOR_CODE>{ data($NRO_RECIBO) }</DEBTOR_CODE>
            }
            {
                for $NOMBRE_RAZON in $consultaResponse1/ns0:ConsultaResult/ns2:DataC/ns2:NOMBRE_RAZON
                return
                    <DEBTOR_NAME>{ data($NOMBRE_RAZON) }</DEBTOR_NAME>
            }
            <BILLS>
                <BILL_RECORD>
                    <BILL_NUMBER>{ $billNumber }</BILL_NUMBER>
                    <BILL_CURRENCY>{ $billCurrency }</BILL_CURRENCY>
                    {
                        for $FEC_CRE in $consultaResponse1/ns0:ConsultaResult/ns2:DataC/ns2:FEC_CRE
                        return
                            <BILL_DATE>{ data($FEC_CRE) }</BILL_DATE>
                    }
                    <DUE_DATE>{ fn-bea:dateTime-to-string-with-format("YYYYMMdd", current-dateTime()) }</DUE_DATE>
                    {
                        for $MONTO in $consultaResponse1/ns0:ConsultaResult/ns2:DataC/ns2:MONTO
                        return
                            <BILL_AMOUNT>{ data($MONTO) }</BILL_AMOUNT>
                    }
                    <LATE_FEE>{ $lateFee }</LATE_FEE>
                    {
                        for $MONTO in $consultaResponse1/ns0:ConsultaResult/ns2:DataC/ns2:MONTO
                        return
                            <TOTAL_AMOUNT_LOC>{ data($MONTO) }</TOTAL_AMOUNT_LOC>
                    }
                    <TOTAL_AMOUNT_USD>{ $totalAmountUSD }</TOTAL_AMOUNT_USD>
                </BILL_RECORD>
            </BILLS>
        </ns1:consultaRecaudoResponse>
};

declare variable $consultaResponse1 as element(ns0:ConsultaResponse) external;
declare variable $contractID as xs:string external;
declare variable $contractName as xs:string external;
declare variable $billNumber as xs:string external;
declare variable $billCurrency as xs:string external;
declare variable $lateFee as xs:string external;
declare variable $totalAmountUSD as xs:string external;

xf:consultaRecaudoPOSOut($consultaResponse1,
    $contractID,
    $contractName,
    $billNumber,
    $billCurrency,
    $lateFee,
    $totalAmountUSD)

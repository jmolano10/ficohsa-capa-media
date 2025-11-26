(:: pragma bea:global-element-parameter parameter="$datosHNConsultaResponse" element="ns0:DatosHNConsultaResponse" location="../../../BusinessServices/RecaudoEEHws/wsdl/recaudoEEHws.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:consultaRecaudoResponse" location="../xsd/consultaRecaudoEEHTypes.xsd" ::)

declare namespace ns0 = "http://schemas.servicestack.net/types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoEEH/xq/consultaRecaudoEEHOut/";

declare function xf:consultaRecaudoEEHOut($datosHNConsultaResponse as element(ns0:DatosHNConsultaResponse),
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
                for $Claveprimaria in $datosHNConsultaResponse/ns0:DatosFactura/ns0:Claveprimaria
                return
                    <DEBTOR_CODE>{ data($Claveprimaria) }</DEBTOR_CODE>
            }
            {
                for $nombre in $datosHNConsultaResponse/ns0:DatosFactura/ns0:nombre
                return
                    <DEBTOR_NAME>{ data($nombre) }</DEBTOR_NAME>
            }
            <BILLS>
                <BILL_RECORD>
                    <BILL_NUMBER>{ $billNumber }</BILL_NUMBER>
                    <BILL_CURRENCY>{ $billCurrency }</BILL_CURRENCY>
                    {
                        for $Fechaemision in $datosHNConsultaResponse/ns0:DatosFactura/ns0:Fechaemision
                        return
                            <BILL_DATE>{ data($Fechaemision) }</BILL_DATE>
                    }
                    <DUE_DATE>{ fn-bea:dateTime-to-string-with-format("YYYYMMdd", current-dateTime()) }</DUE_DATE>
                    <BILL_AMOUNT>{ data($datosHNConsultaResponse/ns0:DatosFactura/ns0:Totalcalculado) }</BILL_AMOUNT>
                    <LATE_FEE>{ $lateFee }</LATE_FEE>
                    <TOTAL_AMOUNT_LOC>{ data($datosHNConsultaResponse/ns0:DatosFactura/ns0:Totalcalculado) }</TOTAL_AMOUNT_LOC>
                    <TOTAL_AMOUNT_USD>{ $totalAmountUSD }</TOTAL_AMOUNT_USD>
                </BILL_RECORD>
            </BILLS>
        </ns1:consultaRecaudoResponse>
};

declare variable $datosHNConsultaResponse as element(ns0:DatosHNConsultaResponse) external;
declare variable $contractID as xs:string external;
declare variable $contractName as xs:string external;
declare variable $billNumber as xs:string external;
declare variable $billCurrency as xs:string external;
declare variable $lateFee as xs:string external;
declare variable $totalAmountUSD as xs:string external;

xf:consultaRecaudoEEHOut($datosHNConsultaResponse,
    $contractID,
    $contractName,
    $billNumber,
    $billCurrency,
    $lateFee,
    $totalAmountUSD)
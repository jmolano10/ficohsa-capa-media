xquery version "2004-draft" encoding "Cp1252";
(:: pragma  parameter="$CuotaCalculada" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:calculaFinanciamientoTCResponse" location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CalculaFinanciamientoTC/xq/calculaFinanciamientoTCNIOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes";

declare function xf:calculaFinanciamientoTCNIOut($CuotaCalculada as element(*),
    $totalAmount as xs:string,
    $numberOfPayments as xs:string)
as element(ns0:calculaFinanciamientoTCResponse) {
    <ns0:calculaFinanciamientoTCResponse>
             <EXACT_MATCH>YES</EXACT_MATCH>
            <TOTAL_AMOUNT>{ data($totalAmount) }</TOTAL_AMOUNT>
            <MONTHLY_PAYMENT>{ fn:round-half-to-even(data($CuotaCalculada/CuotaMensual),2) }</MONTHLY_PAYMENT>
            <NUMBER_OF_PAYMENTS>{ data($numberOfPayments) }</NUMBER_OF_PAYMENTS>
            <YEARLY_INT_RATE>{ fn:round-half-to-even(data($CuotaCalculada/TasaAnual),2) }</YEARLY_INT_RATE>
            <MONTHLY_INT_RATE>{ fn:round-half-to-even(data($CuotaCalculada/TasaMensual),2) }</MONTHLY_INT_RATE>
            <CHARGES>
                <CHARGE>
                    <NAME>DISBURSEMENT</NAME>
                    <VALUE>{ fn:round-half-to-even(data($CuotaCalculada/ValorDesembolso),2) }</VALUE>
                </CHARGE>
                <CHARGE>
                    <NAME>INSURANCE</NAME>
                    <VALUE>{fn:round-half-to-even( data($CuotaCalculada/ValorSeguro), 2) }</VALUE>
                </CHARGE>
            </CHARGES>
    </ns0:calculaFinanciamientoTCResponse>
};

declare variable $CuotaCalculada as element(*) external;
declare variable $totalAmount as xs:string external;
declare variable $numberOfPayments as xs:string external;

xf:calculaFinanciamientoTCNIOut($CuotaCalculada, 
     $totalAmount,$numberOfPayments)
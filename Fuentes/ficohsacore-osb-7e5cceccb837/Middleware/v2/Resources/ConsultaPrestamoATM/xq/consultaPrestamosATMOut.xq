(:: pragma bea:local-element-parameter parameter="$offer" type="ns0:consultaConsolidadaRiesgoClienteResponse/LOAN_ORIGINATIONS/PRE_APPROVED_OFFERS/OFFER" location="../../ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaPrestamoATMResponse" location="../xsd/consultaPrestamoATMTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaPrestamoATMTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPrestamoATM/xq/consultaPrestamosATMOut/";

declare function xf:consultaPrestamosATMOut($customerName as xs:string,
    $offer as element(),
    $debitCard as xs:string)
    as element(ns2:consultaPrestamoATMResponse) {
        <ns2:consultaPrestamoATMResponse>
            <CUSTOMER_NAME>{ $customerName }</CUSTOMER_NAME>
            <AVAILABLE_AMOUNT>{ data($offer/INSTALLMENT) }</AVAILABLE_AMOUNT>
            <INTEREST_RATE>{ data($offer/RATE) }</INTEREST_RATE>
            <OFFER_TYPE>{ data($offer/TYPE) }</OFFER_TYPE>
            <DEBIT_CARD>{ $debitCard }</DEBIT_CARD>
        </ns2:consultaPrestamoATMResponse>
};

declare variable $customerName as xs:string external;
declare variable $offer as element() external;
declare variable $debitCard as xs:string external;

xf:consultaPrestamosATMOut($customerName,
    $offer,
    $debitCard)

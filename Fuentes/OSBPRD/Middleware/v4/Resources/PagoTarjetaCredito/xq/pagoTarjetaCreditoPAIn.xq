xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns1:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/ABKPA/pagoTarjetaCredito/xsd/pagoTarjetaCredito_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTarjetaCreditoPAIn/";

declare function xf:pagoTarjetaCreditoPAIn($pagoTarjetaCredito as element(ns1:pagoTarjetaCredito),
    $transactionType as xs:string,
    $sourceBank as xs:string,
    $destinationBank as xs:string,
    $debitAccount as xs:string,
    $paymentAmount as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMEROTARJETA>{ data($pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</ns0:PV_NUMEROTARJETA>
            <ns0:PV_MONEDASALDO>{ data($pagoTarjetaCredito/BALANCE_CURRENCY) }</ns0:PV_MONEDASALDO>
            <ns0:PN_MONTOPAGO>{ data($paymentAmount) }</ns0:PN_MONTOPAGO>
            <ns0:PV_CUENTADEBITO>{ data($debitAccount) }</ns0:PV_CUENTADEBITO>
            <ns0:PV_NUMEROINTERFACE>{ data($pagoTarjetaCredito/INTERFACE_REFERENCE_NO) }</ns0:PV_NUMEROINTERFACE>
            <ns0:PN_TIPOTRANSACCION>{ data($transactionType) }</ns0:PN_TIPOTRANSACCION>
            <ns0:PV_BANCOORIGEN>{ data($sourceBank) }</ns0:PV_BANCOORIGEN>
            <ns0:PV_BANCODESTINO>{ data($destinationBank) }</ns0:PV_BANCODESTINO>
        </ns0:InputParameters>
};

declare variable $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito) external;
declare variable $transactionType as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $debitAccount as xs:string external;
declare variable $paymentAmount as xs:string external;

xf:pagoTarjetaCreditoPAIn($pagoTarjetaCredito,
    $transactionType,
    $sourceBank,
    $destinationBank,
    $debitAccount,
    $paymentAmount)
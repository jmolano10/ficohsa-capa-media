(:: pragma bea:global-element-return element="ns0:consultaPuntosLealtad" location="../../ProgramaLealtad/xsd/programaLealtadTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaPuntosLealtadIn/";

declare function xf:consultaPuntosLealtadIn($cardNumber as xs:string,
    $customerIdType as xs:string,
    $returnCashEquivalent as xs:string)
    as element(ns0:consultaPuntosLealtad) {
        <ns0:consultaPuntosLealtad>
            <CUSTOMER_ID_TYPE>{ $customerIdType }</CUSTOMER_ID_TYPE>
            <CUSTOMER_ID_VALUE>{ $cardNumber }</CUSTOMER_ID_VALUE>
            <RETURN_CASH_EQUIVALENT>{ $returnCashEquivalent }</RETURN_CASH_EQUIVALENT>
             <CASH_REDEMPTION>
            	<CARD_NUMBER>{ $cardNumber }</CARD_NUMBER>
            	<MERCHANT_ID></MERCHANT_ID>
            	<MERCHANT_TYPE></MERCHANT_TYPE>
            	<TERMINAL_ID></TERMINAL_ID>
         	</CASH_REDEMPTION>
        </ns0:consultaPuntosLealtad>
};

declare variable $cardNumber as xs:string external;
declare variable $customerIdType as xs:string external;
declare variable $returnCashEquivalent as xs:string external;

xf:consultaPuntosLealtadIn($cardNumber,
    $customerIdType,
    $returnCashEquivalent)
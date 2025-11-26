(:: pragma bea:global-element-parameter parameter="$creditCardWithdrawal" element="ns2:creditCardWithdrawal" location="../../../../../v1/Resources/CreditCardOperations/xsd/CreditCardOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:retiroEfectivoTC" location="../../../../../../Middleware/v2/Resources/RetiroEfectivoTC/xsd/retiroEfectivoTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generalTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/creditCardOperationsTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoTCTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/CreditCardOperations/CreditCardWithdrawal/xq/retiroEfectivoGTIn/";

declare function xf:suma($anyType as element(*))
    as xs:decimal {
     	 xs:decimal(sum($anyType/ns2:PAYMENT/ns0:PAY_ITEM/ns0:AMOUNT))
};

declare function xf:retiroEfectivoGTIn($creditCardWithdrawal as element(ns2:creditCardWithdrawal),
    $MERCHANT_NUMBER as xs:string,
    $REFERENCE_NUMBER as xs:string,
    $CURRENCY as xs:string)
    as element(ns1:retiroEfectivoTC) {
        <ns1:retiroEfectivoTC>
            <CREDIT_CARD>{ data($creditCardWithdrawal/ns2:CREDIT_CARD_NUMBER) }</CREDIT_CARD>
            <CURRENCY>{ data($creditCardWithdrawal/ns2:PAYMENT/ns0:PAY_ITEM[1]/ns0:CURRENCY) }</CURRENCY>
            <MERCHANT_NUMBER>{ $MERCHANT_NUMBER }</MERCHANT_NUMBER>
            <REFERENCE_NUMBER>{ $REFERENCE_NUMBER }</REFERENCE_NUMBER>
      		<AMOUNT>{ xf:suma($creditCardWithdrawal) }</AMOUNT>
        	
        </ns1:retiroEfectivoTC>
};

declare variable $creditCardWithdrawal as element(ns2:creditCardWithdrawal) external;
declare variable $MERCHANT_NUMBER as xs:string external;
declare variable $REFERENCE_NUMBER as xs:string external;
declare variable $CURRENCY as xs:string external;

xf:retiroEfectivoGTIn($creditCardWithdrawal,
    $MERCHANT_NUMBER,
    $REFERENCE_NUMBER,
    $CURRENCY)

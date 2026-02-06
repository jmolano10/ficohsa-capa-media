xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoROP" element="ns0:pagoROP" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoROPDEI/xq/pagoRecaudoPagoROPDEIIn/";

declare function xf:pagoRecaudoPagoROPDEIIn($pagoROP as element(ns0:pagoROP),
    $contratoT24 as xs:string)
    as element(ns1:pagoRecaudo) {
        <ns1:pagoRecaudo>
            <CONTRACT_ID>{ $contratoT24 }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($pagoROP/RTN) }</DEBTOR_CODE>
            <DEBTOR_NAME>{ data($pagoROP/TAX_CONCEPT_ID) }</DEBTOR_NAME>
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{data($pagoROP/PAYMENT_INFORMATION/PAYMENT_METHOD)}</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($pagoROP/CURRENCY) }</PAYMENT_CURRENCY>
                <PAYMENT_AMOUNT>{ data($pagoROP/TOTAL_PAYMENT) }</PAYMENT_AMOUNT>
                <DEBIT_ACCOUNT>{ data($pagoROP/ACCOUNT_NUMBER) }</DEBIT_ACCOUNT>
            </PAYMENT_INFORMATION>
            <BILL_INFORMATION>
                <BILL_NUMBER>{ data($pagoROP/TAX_PAYMENT_ID) }</BILL_NUMBER>
                <DUE_DATE>
	                {
	                	fn:concat(
	                		fn:string($pagoROP/YEAR),
	                		if(xs:integer($pagoROP/MONTH) < 10) then ("0") else (""),
	                		fn:string(xs:integer($pagoROP/MONTH)),'01'
	                	)
	                }
                </DUE_DATE>
            </BILL_INFORMATION>
        </ns1:pagoRecaudo>
};

declare variable $pagoROP as element(ns0:pagoROP) external;
declare variable $contratoT24 as xs:string external;

xf:pagoRecaudoPagoROPDEIIn($pagoROP,
    $contratoT24)
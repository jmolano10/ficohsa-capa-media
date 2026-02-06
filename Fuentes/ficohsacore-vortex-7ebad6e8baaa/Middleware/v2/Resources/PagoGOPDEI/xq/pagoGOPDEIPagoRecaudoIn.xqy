xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoGOP" element="ns1:pagoGOP" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoGOPDEI/xq/pagoGOPDEIPagoRecaudoIn/";

declare function xf:pagoGOPDEIPagoRecaudoIn($pagoGOP as element(ns1:pagoGOP),
    $contractId as xs:string)
    as element(ns0:pagoRecaudo) {
        <ns0:pagoRecaudo>
            <CONTRACT_ID>{ data($contractId) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($pagoGOP/RTN) }</DEBTOR_CODE>
            {
	            for $CONTRACT_NUMBER in string($pagoGOP/CONTRACT_NUMBER/text())
	            return
		            if($CONTRACT_NUMBER != "") then(
		            	<DEBTOR_NAME>{ $CONTRACT_NUMBER  }</DEBTOR_NAME>
		            )else(
		            	<DEBTOR_NAME>{ data($pagoGOP/RTN)}</DEBTOR_NAME>
		            )
		    }
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{data($pagoGOP/PAYMENT_INFORMATION/PAYMENT_METHOD)}</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($pagoGOP/CURRENCY) }</PAYMENT_CURRENCY>
                <PAYMENT_AMOUNT>{ data($pagoGOP/TOTAL_PAYMENT) }</PAYMENT_AMOUNT>
                <DEBIT_ACCOUNT>{ data($pagoGOP/ACCOUNT_NUMBER) }</DEBIT_ACCOUNT>
            </PAYMENT_INFORMATION>
            <BILL_INFORMATION>
                <BILL_NUMBER>{ data($pagoGOP/GOP_CODE) }</BILL_NUMBER>
                <DUE_DATE>{ concat(data($pagoGOP/PERIOD), '01') }</DUE_DATE>
            </BILL_INFORMATION>
        </ns0:pagoRecaudo>
};

declare variable $pagoGOP as element(ns1:pagoGOP) external;
declare variable $contractId as xs:string external;

xf:pagoGOPDEIPagoRecaudoIn($pagoGOP,
    $contractId)
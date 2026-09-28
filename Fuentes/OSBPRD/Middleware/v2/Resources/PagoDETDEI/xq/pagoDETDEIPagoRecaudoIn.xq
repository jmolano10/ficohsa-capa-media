(:: pragma bea:global-element-parameter parameter="$pagoDET" element="ns2:pagoDET" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoDETDEI/xq/PagoDETDEIPagoRecaudo/";

declare function xf:PagoDETDEIPagoRecaudo($pagoDET as element(ns2:pagoDET),
    $contractId as xs:string)
    as element(ns0:pagoRecaudo) {
        <ns0:pagoRecaudo>
            <CONTRACT_ID>{ data($contractId) }</CONTRACT_ID>
            <DEBTOR_CODE>{ data($pagoDET/RTN) }</DEBTOR_CODE>
            <DEBTOR_NAME>{ concat($pagoDET/TAX_PAYMENT_ID ,'-', $pagoDET/TAX_CONCEPT_ID) }</DEBTOR_NAME>
            <PAYMENT_INFORMATION>
                <PAYMENT_METHOD>{data($pagoDET/PAYMENT_INFORMATION/PAYMENT_METHOD)}</PAYMENT_METHOD>
                <PAYMENT_CURRENCY>{ data($pagoDET/CURRENCY) }</PAYMENT_CURRENCY>
                <PAYMENT_AMOUNT>{ data($pagoDET/TOTAL_PAYMENT) }</PAYMENT_AMOUNT>
                <DEBIT_ACCOUNT>{ data($pagoDET/ACCOUNT_NUMBER) }</DEBIT_ACCOUNT>
                <CHEQUE_NUMBER/>
                <BANK_CODE/>
                <CREDIT_CARD_NUMBER/>
                <EXPIRATION_DATE/>
            </PAYMENT_INFORMATION>
            <BILL_INFORMATION>
                <BILL_NUMBER>{ data($pagoDET/JURIDICAL_DECLARATION_ID) }</BILL_NUMBER>
                <DUE_DATE>
                { 
                	let $year  := (substring(data($pagoDET/PERIOD), 1, 4))
                	let $month  := (substring(data($pagoDET/PERIOD), 5, 2))
                	return
                	if ($month = '13') then (
                		concat($year, '0101')
                	)
                	else (
                		concat(data($pagoDET/PERIOD), '01')
                	)
                }
                </DUE_DATE>
            </BILL_INFORMATION>
            <EXTENDED_COLLECTION_YES_NO/>
            <DEALSLIP_PICKUP_BRANCH/>
            <ADDITIONAL_INFO>
                <DATA/>
            </ADDITIONAL_INFO>
        </ns0:pagoRecaudo>
};

declare variable $pagoDET as element(ns2:pagoDET) external;
declare variable $contractId as xs:string external;

xf:PagoDETDEIPagoRecaudo($pagoDET,
    $contractId)
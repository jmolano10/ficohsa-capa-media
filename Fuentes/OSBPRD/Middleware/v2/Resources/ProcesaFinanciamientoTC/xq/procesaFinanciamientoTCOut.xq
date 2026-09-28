(:: pragma bea:global-element-parameter parameter="$procesaFinanciamiento" element="ns0:procesaFinanciamiento" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaFinanciamientoResponse" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/financiamientoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaFinanciamiento/xq/procesaFinanciamientoTCOut/";

declare function getValor($entrada as xs:string) as xs:decimal {
	if(fn:string(number($entrada)) != 'NaN') then (
		xs:decimal($entrada) div 100
	) else (-1)
};

declare function xf:procesaFinanciamientoTCOut($procesaFinanciamiento as element(ns0:procesaFinanciamiento),
    $bit48 as xs:string,
    $confirmation_id as xs:string)
    as element(ns0:procesaFinanciamientoResponse) {
        <ns0:procesaFinanciamientoResponse>
            <CARD_NUMBER>{ data($procesaFinanciamiento/CARD_NUMBER) }</CARD_NUMBER>
            <CREDIT_LINE>{ data($procesaFinanciamiento/CREDIT_LINE) }</CREDIT_LINE>
            {
                for $REQUEST_AMOUNT in $procesaFinanciamiento/REQUEST_AMOUNT
                return
                    <REQUEST_AMOUNT>{ data($REQUEST_AMOUNT) }</REQUEST_AMOUNT>
            }            
            <PROCESSING_TYPE>{ data($procesaFinanciamiento/PROCESSING_TYPE) }</PROCESSING_TYPE>
            <CURRENCY>{ data($procesaFinanciamiento/CURRENCY) }</CURRENCY>
            <CONFIRMATION_REFERENCE>{ $confirmation_id }</CONFIRMATION_REFERENCE>
            {
                for $INTEREST_RATE in $procesaFinanciamiento/INTEREST_RATE
                return
                    <INTEREST_RATE>{ data($INTEREST_RATE) }</INTEREST_RATE>
            }
            <NUMBER_OF_PAYMENTS>{ data($procesaFinanciamiento/NUMBER_OF_PAYMENTS) }</NUMBER_OF_PAYMENTS>
            <MONTHLY_PAYMENT>{ getValor(fn:substring($bit48, 7, 12)) }</MONTHLY_PAYMENT>
		    <TOTAL_INTEREST>{ getValor(fn:substring($bit48, 19, 5)) }</TOTAL_INTEREST>
		    <TOTAL_AMOUNT>{ getValor(fn:substring($bit48, 36, 12)) }</TOTAL_AMOUNT>

        </ns0:procesaFinanciamientoResponse>
};

declare variable $procesaFinanciamiento as element(ns0:procesaFinanciamiento) external;
declare variable $bit48 as xs:string external;
declare variable $confirmation_id as xs:string external;

xf:procesaFinanciamientoTCOut($procesaFinanciamiento,
    $bit48,
    $confirmation_id)
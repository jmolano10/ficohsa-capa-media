(:: pragma bea:global-element-parameter parameter="$confirmaFinanciamiento" element="ns0:confirmaFinanciamiento" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:confirmaFinanciamientoResponse" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/financiamientoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmaFinanciamientoTC/xq/confirmaFinanciamientoTCOut/";

declare function getValor($entrada as xs:string) as xs:decimal {
	if(fn:string(number($entrada)) != 'NaN') then (
		xs:decimal($entrada) div 100
	) else (-1)
};

declare function xf:confirmaFinanciamientoTCOut($confirmaFinanciamiento as element(ns0:confirmaFinanciamiento),
    $bit48 as xs:string,
    $confirmationId as xs:string)
    as element(ns0:confirmaFinanciamientoResponse) {
        <ns0:confirmaFinanciamientoResponse>
            <CARD_NUMBER>{ data($confirmaFinanciamiento/CARD_NUMBER) }</CARD_NUMBER>
            <CONFIRMATION_TYPE>{ data($confirmaFinanciamiento/CONFIRMATION_TYPE) }</CONFIRMATION_TYPE>
            {
                for $REQUEST_AMOUNT in $confirmaFinanciamiento/REQUEST_AMOUNT
                return
                    <REQUEST_AMOUNT>{ data($REQUEST_AMOUNT) }</REQUEST_AMOUNT>
            }            
            <CURRENCY>{ data($confirmaFinanciamiento/CURRENCY) }</CURRENCY>
            <CONFIRMATION_REFERENCE>{ $confirmationId }</CONFIRMATION_REFERENCE>
            {
                for $INTEREST_RATE in $confirmaFinanciamiento/INTEREST_RATE
                return
                    <INTEREST_RATE>{data($INTEREST_RATE) }</INTEREST_RATE>
            }
            <NUMBER_OF_PAYMENTS>{ data($confirmaFinanciamiento/NUMBER_OF_PAYMENTS) }</NUMBER_OF_PAYMENTS>
            <MONTHLY_PAYMENT>{ getValor(fn:substring($bit48, 7, 12)) }</MONTHLY_PAYMENT>
		    <TOTAL_INTEREST>{ getValor(fn:substring($bit48, 19, 5)) }</TOTAL_INTEREST>
		    <TOTAL_AMOUNT>{ getValor(fn:substring($bit48, 36, 12)) }</TOTAL_AMOUNT>
        </ns0:confirmaFinanciamientoResponse>
};

declare variable $confirmaFinanciamiento as element(ns0:confirmaFinanciamiento) external;
declare variable $bit48 as xs:string external;
declare variable $confirmationId as xs:string external;

xf:confirmaFinanciamientoTCOut($confirmaFinanciamiento,
    $bit48, 
    $confirmationId)
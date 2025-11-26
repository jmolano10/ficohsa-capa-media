(:: pragma bea:global-element-parameter parameter="$consultaFinanciamiento" element="ns0:consultaFinanciamiento" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaFinanciamientoResponse" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/financiamientoTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinanciamientoTC/xq/consultaFinanciamientoTCOut/";

declare function getValor($entrada as xs:string) as xs:decimal {
	if(fn:string(number($entrada)) != 'NaN') then (
		xs:decimal($entrada) div 100
	) else (-1)
};

declare function xf:consultaFinanciamientoTCOut($bit48 as xs:string,
    $consultaFinanciamiento as element(ns0:consultaFinanciamiento))
    as element(ns0:consultaFinanciamientoResponse) {
        <ns0:consultaFinanciamientoResponse>
            <CARD_NUMBER>{ data($consultaFinanciamiento/CARD_NUMBER) }</CARD_NUMBER>
            <CREDIT_LINE>{ data($consultaFinanciamiento/CREDIT_LINE) }</CREDIT_LINE>
            {
	           	for $REQUEST_AMOUNT in $consultaFinanciamiento/REQUEST_AMOUNT
	           	return
	            	<REQUEST_AMOUNT>{ data($REQUEST_AMOUNT) }</REQUEST_AMOUNT>
            }            
            <CURRENCY>{ data($consultaFinanciamiento/CURRENCY) }</CURRENCY>
            <RATE_CLASS>{ data($consultaFinanciamiento/RATE_CLASS) }</RATE_CLASS>   
            {
                for $INTEREST_RATE in $consultaFinanciamiento/INTEREST_RATE
                return
                    <INTEREST_RATE>{ data($INTEREST_RATE) }</INTEREST_RATE>
            }      
            <NUMBER_OF_PAYMENTS>{ data($consultaFinanciamiento/NUMBER_OF_PAYMENTS) }</NUMBER_OF_PAYMENTS>
            <MONTHLY_PAYMENT>{ getValor(fn:substring($bit48, 7, 12)) }</MONTHLY_PAYMENT>
			<TOTAL_INTEREST>{ getValor(fn:substring($bit48, 24, 12)) }</TOTAL_INTEREST>
			<TOTAL_AMOUNT>{ getValor(fn:substring($bit48, 36, 12)) }</TOTAL_AMOUNT>
        </ns0:consultaFinanciamientoResponse>
};

declare variable $bit48 as xs:string external;
declare variable $consultaFinanciamiento as element(ns0:consultaFinanciamiento) external;

xf:consultaFinanciamientoTCOut($bit48,
    $consultaFinanciamiento)
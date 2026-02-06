xquery version "2004-draft" encoding "Cp1252";
(:: pragma  parameter="$equifaxCreditScore" type="xs:anyType" ::)
(:: pragma bea:global-element-return element="ns0:consultaPuntajeCreditoResponse" location="../xsd/consultaPuntajeCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntajeCredito/xq/consultaPuntajeCreditoOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaPuntajeCreditoTypes";
declare namespace ns1 = "http://wsscore.equifax.com.hn";

declare function xf:consultaPuntajeCreditoOut($equifaxCreditScore as element(*), $paymentAmount as xs:string, $paymentCurrency as xs:string)
    as element(ns0:consultaPuntajeCreditoResponse) {
        <ns0:consultaPuntajeCreditoResponse>
        	<ns0:PAYMENT_AMOUNT>{ $paymentAmount }</ns0:PAYMENT_AMOUNT>
        	<ns0:PAYMENT_CURRENCY>{ $paymentCurrency }</ns0:PAYMENT_CURRENCY>
    		<ns0:SCORE>{ data($equifaxCreditScore/ns1:response/ns1:scoreConsumidor/ns1:scoreActual) }</ns0:SCORE>
    		<ns0:DETERMINING_CONDITIONS>
    			<ns0:CONDITION>{ data($equifaxCreditScore/ns1:response/ns1:mensajeList/ns1:mensaje1) }</ns0:CONDITION>
    			<ns0:CONDITION>{ data($equifaxCreditScore/ns1:response/ns1:mensajeList/ns1:mensaje2) }</ns0:CONDITION>
    			<ns0:CONDITION>{ data($equifaxCreditScore/ns1:response/ns1:mensajeList/ns1:mensaje3) }</ns0:CONDITION>
    		</ns0:DETERMINING_CONDITIONS>
    		<ns0:RANGES>
    		{
    			for $range in $equifaxCreditScore/ns1:response/ns1:nivelList/ns1:nivel
    			order by $range/ns1:minimo
    			return
    			<ns0:RANGE>
    				<ns0:CATEGORY>{ data($range/ns1:riesgo) }</ns0:CATEGORY>
    				<ns0:MINIMUM_VALUE>{ data($range/ns1:minimo) }</ns0:MINIMUM_VALUE>
    				<ns0:MAXIMUM_VALUE>{ data($range/ns1:maximo) }</ns0:MAXIMUM_VALUE>
    			</ns0:RANGE>
    		}
    		</ns0:RANGES>
        </ns0:consultaPuntajeCreditoResponse>
};

declare variable $equifaxCreditScore as element(*) external;
declare variable $paymentAmount as xs:string external;
declare variable $paymentCurrency as xs:string external;

xf:consultaPuntajeCreditoOut($equifaxCreditScore, $paymentAmount, $paymentCurrency)
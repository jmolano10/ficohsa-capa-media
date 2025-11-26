(:: pragma bea:global-element-parameter parameter="$pagoRetiroFPC" element="ns0:pagoRetiroFPC" location="../xsd/pagoRetiroFPCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRetiroFPC" location="../../../BusinessServices/FPC/pagoRetiroFPC12c/xsd/PagoRetiroFPCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRetiroFPCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRetiroFPC/xq/pagoRetiroFPCIn/";

declare function xf:pagoRetiroFPCIn($pagoRetiroFPC as element(ns0:pagoRetiroFPC))
    as element(ns0:pagoRetiroFPC) {
        <ns0:pagoRetiroFPC>
        	{
        		for $APPLICATION_NUMBER in $pagoRetiroFPC/APPLICATION_NUMBER
        		return
        		<APPLICATION_NUMBER>{ data($APPLICATION_NUMBER) }</APPLICATION_NUMBER>
        	}
        		<CURRENCY>{if(data($pagoRetiroFPC/CURRENCY) = 'LPS')then('HNL')else if(data($pagoRetiroFPC/CURRENCY) = 'US$')then ('USD')else(data($pagoRetiroFPC/CURRENCY))}</CURRENCY>
        	{
        		for $AMOUNT in $pagoRetiroFPC/AMOUNT
        		return
        		<AMOUNT>{ data($AMOUNT) }</AMOUNT>
        	}
        	{
        		for $USER_PAY in $pagoRetiroFPC/USER_PAY
        		return
        		<USER_PAY>{ data($USER_PAY) }</USER_PAY>
        	}
        	{
        		for $DATE in $pagoRetiroFPC/DATE
        		return
        		<DATE>{ data($DATE) }</DATE>
        	}
        	{
        		for $TRANSACTION in $pagoRetiroFPC/TRANSACTION
        		return
        		<TRANSACTION>{ data($TRANSACTION) }</TRANSACTION>
        	}
        	{
        		for $CODE_AGENCY in $pagoRetiroFPC/CODE_AGENCY
        		return
        		<CODE_AGENCY>{ data($CODE_AGENCY) }</CODE_AGENCY>
        	}
        	{
        		for $AGENCY_NAME in $pagoRetiroFPC/AGENCY_NAME
        		return
        		<AGENCY_NAME>{ data($AGENCY_NAME) }</AGENCY_NAME>
        	}
        </ns0:pagoRetiroFPC>
};

declare variable $pagoRetiroFPC as element(ns0:pagoRetiroFPC) external;

xf:pagoRetiroFPCIn($pagoRetiroFPC)

xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosResponse" element="ns0:sjConsultaMultipleProductosResponse" location="../../../BusinessServices/SJS/consultaMultiplesProductos/xsd/sjConsultaMultipleProductos.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMultiplesProductosResponse" location="../xsd/consultaMultiplesProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMultiplesProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMultiplesProductos/xq/sjConsultaMultiplesProductosOut/";

declare function xf:sjConsultaMultiplesProductosOut($sjConsultaMultipleProductosResponse as element(ns0:sjConsultaMultipleProductosResponse))
    as element(ns1:consultaMultiplesProductosResponse) {
        <ns1:consultaMultiplesProductosResponse>
            {
                let $ASSETS := $sjConsultaMultipleProductosResponse/ns0:ASSETS
                return
                    <ASSETS>
                        {
                            for $ASSET in $ASSETS/ns0:ASSET
                            return
                                <ASSET>
                                    <ID>{ data($ASSET/ns0:ID) }</ID>
                                    {
                                        for $PRODUCT_NAME in $ASSET/ns0:PRODUCT_NAME
                                        return
                                            <PRODUCT_NAME>{ data($PRODUCT_NAME) }</PRODUCT_NAME>,
                                            <STATUS>ACTIVE</STATUS>
                                    }
                                    {
                                        for $CURRENCY in $ASSET/ns0:CURRENCY
                                        return
                                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                                    }
                                    {
                                        for $RESERVE_BALANCE in $ASSET/ns0:RESERVE_BALANCE
                                        return
                                            <RESERVE_BALANCE>{ data($RESERVE_BALANCE) }</RESERVE_BALANCE>
                                    }
                                    {
                                        for $LOCKED_BALANCE in $ASSET/ns0:LOCKED_BALANCE
                                        return
                                            <LOCKED_BALANCE>{ data($LOCKED_BALANCE) }</LOCKED_BALANCE>
                                    }
                                    {
                                        for $VISA_FLOATING_BALANCE in $ASSET/ns0:VISA_FLOATING_BALANCE
                                        return
                                            <VISA_FLOATING_BALANCE>{ data($VISA_FLOATING_BALANCE) }</VISA_FLOATING_BALANCE>
                                    }
                                    {
                                        if  (data($ASSET/ns0:TYPE) = 'AHO'  or data($ASSET/ns0:TYPE) ='CHQ' )  then  (							
	                                   		if  (data($ASSET/ns0:SOURCE_BANK) ='HN01')  then  (
                                         		for $CASH_ADVANCE_LIMIT in $ASSET/ns0:CASH_ADVANCE_LIMIT
                                          		return
                                          		if(string($CASH_ADVANCE_LIMIT) != "") then 
                                    			(
                                    				<CASH_ADVANCE_LIMIT>{ data($CASH_ADVANCE_LIMIT) }</CASH_ADVANCE_LIMIT>
                                    			) else
                                    			(
                                    				<CASH_ADVANCE_LIMIT>0</CASH_ADVANCE_LIMIT>
                                    			)
											)
                                        	else
                                        	(
                                          		<CASH_ADVANCE_LIMIT>0</CASH_ADVANCE_LIMIT>
                                         	)
					         			)
				                		else ()
                                  	}
                                    {
                                      	if  (data($ASSET/ns0:TYPE) = 'AHO' or  data($ASSET/ns0:TYPE) ='CHQ')  then (
                                         	if   (data($ASSET/ns0:SOURCE_BANK) ='HN01') then (
                                              	for $CASH_ADVANCE_AVAILABLE in $ASSET/ns0:CASH_ADVANCE_AVAILABLE
                                                 	return
                                                    if(string($CASH_ADVANCE_AVAILABLE) != "") then 
	                                    			(
	                                    				<CASH_ADVANCE_AVAILABLE>{ data($CASH_ADVANCE_AVAILABLE) }</CASH_ADVANCE_AVAILABLE>
	                                    			) else
	                                    			(
	                                    				<CASH_ADVANCE_AVAILABLE>0</CASH_ADVANCE_AVAILABLE>
	                                         		)
	                                        ) 
			                 				else(
			                				<CASH_ADVANCE_AVAILABLE>0</CASH_ADVANCE_AVAILABLE> )
			                   			)                                          
                                        else ()	  
                                    }
                                    {
                                        for $INTEREST_BALANCE in $ASSET/ns0:INTEREST_BALANCE
                                        return
                                            <INTEREST_BALANCE>{ data($INTEREST_BALANCE) }</INTEREST_BALANCE>
                                    }
                                    {
                                        for $TOTAL_BALANCE in $ASSET/ns0:TOTAL_BALANCE
                                        return
                                            <TOTAL_BALANCE>{ data($TOTAL_BALANCE) }</TOTAL_BALANCE>
                                    }
                                    {
                                        for $AVAILABLE_BALANCE in $ASSET/ns0:AVAILABLE_BALANCE
                                        return
                                            <AVAILABLE_BALANCE>{ data($AVAILABLE_BALANCE) }</AVAILABLE_BALANCE>
                                    }
                                    {
                                        for $OPENING_DATE in $ASSET/ns0:OPENING_DATE
                                        return
                                            <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                                    }
                                    <TYPE>{ data($ASSET/ns0:TYPE) }</TYPE>
                                    <SOURCE_BANK>{ data($ASSET/ns0:SOURCE_BANK) }</SOURCE_BANK>
                                    <SUCCESS_INDICATOR>{ data($ASSET/ns0:SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                                    {
                                        for $ERROR_MESSAGE in $ASSET/ns0:ERROR_MESSAGE
                                        return
                                            <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                                    }
                                    {
                                        for $INTERNATIONAL_ACCOUNT_NUMBER in $ASSET/ns0:INTERNATIONAL_ACCOUNT_NUMBER
                                        return
                                            <INTERNATIONAL_ACCOUNT_NUMBER>{ data($INTERNATIONAL_ACCOUNT_NUMBER) }</INTERNATIONAL_ACCOUNT_NUMBER>
                                    }
                                </ASSET>
                        }
                    </ASSETS>
            }
            {
                let $LIABILITIES := $sjConsultaMultipleProductosResponse/ns0:LIABILITIES
                return
                    <LIABILITIES>
                        {
                            for $LIABILITY in $LIABILITIES/ns0:LIABILITY
                            return
                                <LIABILITY>
                                    <ID>{ data($LIABILITY/ns0:ID) }</ID>
                                    {
                                        for $PRODUCT_NAME in $LIABILITY/ns0:PRODUCT_NAME
                                        return
                                            <PRODUCT_NAME>{ data($PRODUCT_NAME) }</PRODUCT_NAME>,
                                            <STATUS>ACTIVE</STATUS>
                                    }
                                    {
                                        for $BALANCES in $LIABILITY/ns0:BALANCES
                                        return
                                            <BALANCES>
                                                {
                                                    for $BALANCE in $BALANCES/ns0:BALANCE
                                                    return
                                                        <BALANCE>
                                                            {
                                                                for $CURRENCY in $BALANCE/ns0:CURRENCY
                                                                return
                                                                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                                                            }
                                                            {
                                                                for $PRINCIPAL in $BALANCE/ns0:PRINCIPAL
                                                                return
                                                                    <PRINCIPAL>{ data($PRINCIPAL) }</PRINCIPAL>
                                                            }
                                                            {
                                                                for $INT_COMM in $BALANCE/ns0:INT_COMM
                                                                return
                                                                    <INT_COMM>{ data($INT_COMM) }</INT_COMM>
                                                            }
                                                            {
                                                                for $TOTAL in $BALANCE/ns0:TOTAL
                                                                return
                                                                    <TOTAL>{ data($TOTAL) }</TOTAL>
                                                            }
                                                            {
                                                                for $WITHDRAWAL_LIMIT in $BALANCE/ns0:WITHDRAWAL_LIMIT
                                                                return
                                                                    <WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</WITHDRAWAL_LIMIT>
                                                            }
                                                        </BALANCE>
                                                }
                                            </BALANCES>
                                    }
                                    {
                                        for $NEXT_PAYMENT_DATE in $LIABILITY/ns0:NEXT_PAYMENT_DATE
                                        return
                                            <NEXT_PAYMENT_DATE>{ data($NEXT_PAYMENT_DATE) }</NEXT_PAYMENT_DATE>
                                    }
                                    {
                                        for $TSTANDING_TOTAL in $LIABILITY/ns0:TSTANDING_TOTAL
                                        return
                                            <TSTANDING_TOTAL>{ data($TSTANDING_TOTAL) }</TSTANDING_TOTAL>
                                    }
                                    {
                                        for $CANCELATION_TOTAL in $LIABILITY/ns0:CANCELATION_TOTAL
                                        return
                                            <CANCELATION_TOTAL>{ data($CANCELATION_TOTAL) }</CANCELATION_TOTAL>
                                    }
                                    {
                                        for $TOTAL_AMOUNT in $LIABILITY/ns0:TOTAL_AMOUNT
                                        return
                                            <TOTAL_AMOUNT>{ data($TOTAL_AMOUNT) }</TOTAL_AMOUNT>
                                    }
                                    <TYPE>{ data($LIABILITY/ns0:TYPE) }</TYPE>
                                    {
                                        for $OPENING_DATE in $LIABILITY/ns0:OPENING_DATE
                                        return
                                            <OPENING_DATE>{ data($OPENING_DATE) }</OPENING_DATE>
                                    }
                                    <SOURCE_BANK>{ data($LIABILITY/ns0:SOURCE_BANK) }</SOURCE_BANK>
                                    <SUCCESS_INDICATOR>{ data($LIABILITY/ns0:SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                                    {
                                        for $ERROR_MESSAGE in $LIABILITY/ns0:ERROR_MESSAGE
                                        return
                                            <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                                    }
                                </LIABILITY>
                        }
                    </LIABILITIES>
            }
        </ns1:consultaMultiplesProductosResponse>
};

declare variable $sjConsultaMultipleProductosResponse as element(ns0:sjConsultaMultipleProductosResponse) external;

xf:sjConsultaMultiplesProductosOut($sjConsultaMultipleProductosResponse)
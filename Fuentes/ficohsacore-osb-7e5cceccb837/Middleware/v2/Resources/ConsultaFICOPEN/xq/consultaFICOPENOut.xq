(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../../Business_Resources/Ficopen/Resource/ConsultaFICOPEN/xsd/FICOPEN_OSB_K_CONSULTAFICOPEN_TOPLEVEL-24OSB_CON_FICOPEN.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFICOPENResponse" location="../xsd/consultaFICOPENTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFICOPENTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FICOPEN/OSB_K_CONSULTAFICOPEN/TOPLEVEL-24OSB_CON_FICOPEN/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFICOPEN/consultaFICOPENOut/";

declare function xf:consultaFICOPENOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaFICOPENResponse) {
        <ns1:consultaFICOPENResponse>
            <CUSTOMER_LEGAL_ID>{ data($outputParameters1/ns0:CUSTOMER_LEGAL_ID) }</CUSTOMER_LEGAL_ID>
            <CUSTOMER_NAME>{ data($outputParameters1/ns0:CUSTOMER_NAME) }</CUSTOMER_NAME>
            <ACCOUNT_NUMBER>{ data($outputParameters1/ns0:ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            <ACCOUNT_CURRENCY>
            { 
            	let $currency := data($outputParameters1/ns0:ACCOUNT_CURRENCY)
            	return
            	if ($currency = "1") then (
            		"HNL"
            	) else if ($currency ="2") then (
            		"USD"
            	) else if ($currency ="3") then (
            		"EUR"
            	) else (
            		""
            	)
            }
            </ACCOUNT_CURRENCY>
            <CONTRACT_NUMBER>{ data($outputParameters1/ns0:CONTRACT_NUMBER) }</CONTRACT_NUMBER>
            <CONTRACT_TYPE>{ data($outputParameters1/ns0:CONTRACT_TYPE) }</CONTRACT_TYPE>
            <COMPANY>{ data($outputParameters1/ns0:COMPANY) }</COMPANY>
            <START_DATE>{ data($outputParameters1/ns0:START_DATE_RESP) }</START_DATE>
            <consultaFICOPENResponseType>
            {
                for $i in (1 to max( (	count($outputParameters1/ns0:BALANCE_TYPE/ns0:ITEM),
                						count($outputParameters1/ns0:PREVIOUS_BALANCE/ns0:ITEM),
                						count($outputParameters1/ns0:GROSS_CONTRIBUTIONS_AMOUNT/ns0:ITEM),
                						count($outputParameters1/ns0:INTEREST_AMOUNT/ns0:ITEM),
                						count($outputParameters1/ns0:WITHDRAWALS_AMOUNT/ns0:ITEM),
                						count($outputParameters1/ns0:FEE_AMOUNT/ns0:ITEM),
                						count($outputParameters1/ns0:INSURANCE_AMOUNT/ns0:ITEM),
                						count($outputParameters1/ns0:CURRENT_BALANCE/ns0:ITEM))))
                return
                    <consultaFICOPENResponseRecordType>
                        <BALANCE_TYPE>{ data($outputParameters1/ns0:BALANCE_TYPE/ns0:ITEM[$i]) }</BALANCE_TYPE>
                        <PREVIOUS_BALANCE>{ data($outputParameters1/ns0:PREVIOUS_BALANCE/ns0:ITEM[$i]) }</PREVIOUS_BALANCE>
                        <GROSS_CONTRIBUTIONS_AMOUNT>{ data($outputParameters1/ns0:GROSS_CONTRIBUTIONS_AMOUNT/ns0:ITEM[$i]) }</GROSS_CONTRIBUTIONS_AMOUNT>
                        <INTEREST_AMOUNT>{ data($outputParameters1/ns0:INTEREST_AMOUNT/ns0:ITEM[$i]) }</INTEREST_AMOUNT>
                        <WITHDRAWALS_AMOUNT>{ data($outputParameters1/ns0:WITHDRAWALS_AMOUNT/ns0:ITEM[$i]) }</WITHDRAWALS_AMOUNT>
                        <FEE_AMOUNT>{ data($outputParameters1/ns0:FEE_AMOUNT/ns0:ITEM[$i]) }</FEE_AMOUNT>
                        <INSURANCE_AMOUNT>{ data($outputParameters1/ns0:INSURANCE_AMOUNT/ns0:ITEM[$i]) }</INSURANCE_AMOUNT>
                        <CURRENT_BALANCE>{ data($outputParameters1/ns0:CURRENT_BALANCE/ns0:ITEM[$i]) }</CURRENT_BALANCE>
                    </consultaFICOPENResponseRecordType>
            }
            </consultaFICOPENResponseType>
        </ns1:consultaFICOPENResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaFICOPENOut($outputParameters1)
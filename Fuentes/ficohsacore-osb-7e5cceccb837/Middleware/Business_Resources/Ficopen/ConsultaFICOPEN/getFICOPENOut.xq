(:: pragma bea:global-element-parameter parameter="$consultaFICOPENResponse" element="ns0:consultaFICOPENResponse" location="../../../v2/BusinessServices/FPC/getFicopen12c/xsd/GetFicopenTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaFICOPENResponse" location="consultaFICOPENTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFICOPENTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/getFICOPENOut/";

declare function xf:getFICOPENOut($consultaFICOPENResponse as element(ns0:consultaFICOPENResponse))
    as element(ns0:consultaFICOPENResponse) {
        <ns0:consultaFICOPENResponse>
            {
                for $CUSTOMER_LEGAL_ID in $consultaFICOPENResponse/CUSTOMER_LEGAL_ID
                return
                    <CUSTOMER_LEGAL_ID>{ data($CUSTOMER_LEGAL_ID) }</CUSTOMER_LEGAL_ID>
            }
            {
                for $CUSTOMER_NAME in $consultaFICOPENResponse/CUSTOMER_NAME
                return
                    <CUSTOMER_NAME>{ data($CUSTOMER_NAME) }</CUSTOMER_NAME>
            }
            {
                for $ACCOUNT_NUMBER in $consultaFICOPENResponse/ACCOUNT_NUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            }
            {
                for $CONTRACT_NUMBER in $consultaFICOPENResponse/CONTRACT_NUMBER
                return
                    <CONTRACT_NUMBER>{ data($CONTRACT_NUMBER) }</CONTRACT_NUMBER>
            }
            {
                for $CONTRACT_TYPE in $consultaFICOPENResponse/CONTRACT_TYPE
                return
                    <CONTRACT_TYPE>{ data($CONTRACT_TYPE) }</CONTRACT_TYPE>
            }
            {
                for $COMPANY in $consultaFICOPENResponse/COMPANY
                return
                    <COMPANY>{ data($COMPANY) }</COMPANY>
            }
            {
                for $START_DATE in $consultaFICOPENResponse/START_DATE
                return
                    <START_DATE>{ data($START_DATE) }</START_DATE>
            }
            <ns0:consultaFICOPENResponseType>
			{
			    for $item in $consultaFICOPENResponse/consultaFICOPENResponseType/consultaFICOPENResponseRecordType
				return
                <ns0:consultaFICOPENResponseRecordType>
                    <BALANCE_TYPE>{ data($item/BALANCE_TYPE) }</BALANCE_TYPE> 
                    <PREVIOUS_BALANCE>{ data($item/PREVIOUS_BALANCE) }</PREVIOUS_BALANCE>
                    <GROSS_CONTRIBUTIONS_AMOUNT>{ data($item/GROSS_CONTRIBUTIONS_AMOUNT) }</GROSS_CONTRIBUTIONS_AMOUNT>
                    <INTEREST_AMOUNT>{ data($item/INTEREST_AMOUNT) }</INTEREST_AMOUNT>	
                    <WITHDRAWALS_AMOUNT>{ data($item/WITHDRAWALS_AMOUNT) }</WITHDRAWALS_AMOUNT>	
                    <FEE_AMOUNT>{ data($item/FEE_AMOUNT) }</FEE_AMOUNT>
                    <INSURANCE_AMOUNT>{ data($item/INSURANCE_AMOUNT) }</INSURANCE_AMOUNT>
                    <CURRENT_BALANCE>{ data($item/CURRENT_BALANCE) }</CURRENT_BALANCE>							
                </ns0:consultaFICOPENResponseRecordType>
			}
            </ns0:consultaFICOPENResponseType>
        </ns0:consultaFICOPENResponse>
};

declare variable $consultaFICOPENResponse as element(ns0:consultaFICOPENResponse) external;

xf:getFICOPENOut($consultaFICOPENResponse)

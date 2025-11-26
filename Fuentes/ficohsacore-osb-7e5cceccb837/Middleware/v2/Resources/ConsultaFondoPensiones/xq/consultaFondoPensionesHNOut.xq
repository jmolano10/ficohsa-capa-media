(:: pragma bea:global-element-parameter parameter="$getPensionFundResponse" element="ns0:getPensionFundResponse" location="../../../BusinessServices/FPC/getPensionFund12c/xsd/GetPensionFundTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaFondoPensionesResponse" location="../xsd/consultaFondoPensionesTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaFondoPensionesTypes";
declare namespace ns1 = "https://www.ficohsa.com/regional/common/commonTypes";
declare namespace ns0 = "https://www.ficohsa.com/regional/pension";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFondoPensiones/xq/consultaFondoPensionesHNOut/";

declare function local:format-date-from-FPC($textdate as xs:string) as xs:string
{
	fn:concat(fn:substring($textdate,1,4),fn:substring($textdate,6,2),fn:substring($textdate,9,2),fn:substring($textdate,12,2),fn:substring($textdate,15,2))
};

declare function xf:consultaFondoPensionesHNOut($getPensionFundResponse as element(ns0:getPensionFundResponse),
    $accountNumber as xs:string)
    as element(ns2:consultaFondoPensionesResponse) {
        <ns2:consultaFondoPensionesResponse>
            <ns2:ACCOUNT_NUMBER>{ data($accountNumber) }</ns2:ACCOUNT_NUMBER>
            <ns2:CUSTOMER_ID>{ data($getPensionFundResponse/Data/Account/CustomerCode) }</ns2:CUSTOMER_ID>
            <ns2:CUSTOMER_NAME>{ data($getPensionFundResponse/Data/Account/CustomerName) }</ns2:CUSTOMER_NAME>
            <ns2:PRODUCT_CODE>{ data($getPensionFundResponse/Data/Account/CodeProductLine) }</ns2:PRODUCT_CODE>
            <ns2:PRODUCT_NAME>{ data($getPensionFundResponse/Data/Account/ProductName) }</ns2:PRODUCT_NAME>
            <ns2:SUB_PRODUCT_CODE>{ data($getPensionFundResponse/Data/Account/ProductCode) }</ns2:SUB_PRODUCT_CODE>
            <ns2:OPENING_DATE>{ data($getPensionFundResponse/Data/Account/OpeningDate) }</ns2:OPENING_DATE>
            <ns2:FREQUENCY>{ data($getPensionFundResponse/Data/Account/FrequencyContribution) }</ns2:FREQUENCY>
            <ns2:PAYMENT_METHOD>{ data($getPensionFundResponse/Data/Account/FormContribution) }</ns2:PAYMENT_METHOD>
            {
                for $InsuredAmount in $getPensionFundResponse/Data/Account/InsuredAmount
                return
                    <ns2:INSURED_AMOUNT>{ data($InsuredAmount) }</ns2:INSURED_AMOUNT>
            }
            <ns2:CONTRIBUTION_AMOUNT>{ data($getPensionFundResponse/Data/Account/AmountContribution) }</ns2:CONTRIBUTION_AMOUNT>
            {
                for $LastContributionAmount in $getPensionFundResponse/Data/Account/LastContributionAmount
                return
                    <ns2:LAST_CONTRIBUTION_AMOUNT>{ data($LastContributionAmount) }</ns2:LAST_CONTRIBUTION_AMOUNT>
            }
            <ns2:LAST_CONTRIBUTION_DATE>{ data($getPensionFundResponse/Data/Account/LastContribution) }</ns2:LAST_CONTRIBUTION_DATE>
            <ns2:NEXT_CONTRIBUTION_DATE>{ data($getPensionFundResponse/Data/Account/NextContribution) }</ns2:NEXT_CONTRIBUTION_DATE>
            <ns2:LAST_EXTRA_CONTRIBUTION_AMOUNT>{ data($getPensionFundResponse/Data/Account/LastContributionExtra) }</ns2:LAST_EXTRA_CONTRIBUTION_AMOUNT>
            <ns2:BENEFICIARY_INFO>
                {
                    for $beneficiary in $getPensionFundResponse/Data/Account/Beneficiaries
                    return
                        <ns2:BENEFICIARY_ITEM>
                            <ns2:FULL_NAME>{ data($beneficiary/NameBeneficiary) }</ns2:FULL_NAME>
                            <ns2:RELATIONSHIP>{ data($beneficiary/RelationshipBeneficiary) }</ns2:RELATIONSHIP>
                        </ns2:BENEFICIARY_ITEM>
                }
            </ns2:BENEFICIARY_INFO>
        </ns2:consultaFondoPensionesResponse>
};

declare variable $getPensionFundResponse as element(ns0:getPensionFundResponse) external;
declare variable $accountNumber as xs:string external;

xf:consultaFondoPensionesHNOut($getPensionFundResponse,
    $accountNumber)

(:: pragma bea:global-element-parameter parameter="$consultaFondoPensionesRequest" element="ns2:consultaFondoPensionesRequest" location="../xsd/consultaFondoPensionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:getPensionFund" location="../../../BusinessServices/FPC/getPensionFund12c/xsd/GetPensionFundTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaFondoPensionesTypes";
declare namespace ns1 = "https://www.ficohsa.com/regional/common/commonTypes";
declare namespace ns0 = "https://www.ficohsa.com/regional/pension";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFondoPensiones/xq/getPensionFundIn/";

declare function xf:getPensionFundIn($sourceBank as xs:string,
    $destinationBank as xs:string,
    $consultaFondoPensionesRequest as element(ns2:consultaFondoPensionesRequest))
    as element(ns0:getPensionFund) {
        <ns0:getPensionFund>
            <GeneralInfo>
                <SourceBank>{ $sourceBank }</SourceBank>
                <DestinationBank>{ $destinationBank }</DestinationBank>
                <Language>es</Language>
            </GeneralInfo>
            <AccountCode>{ data($consultaFondoPensionesRequest/ns2:ACCOUNT_NUMBER) }</AccountCode>
        </ns0:getPensionFund>
};

declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $consultaFondoPensionesRequest as element(ns2:consultaFondoPensionesRequest) external;

xf:getPensionFundIn($sourceBank,
    $destinationBank,
    $consultaFondoPensionesRequest)

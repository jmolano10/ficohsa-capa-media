xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamo";
(:: import schema at "../../../../../../MWBanking/Loans/RequestorServices/XSD/getLoanDetails.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/getLoanDetailsHN_SJ";
(:: import schema at "../XSD/GetLoanDetailsHN_SJ.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/sjSetLoanDetail";

declare namespace dyn = "http://www.ficohsa.com.hn/middleware.services/dynamoTypes";

declare variable $liabilityNumber as xs:string external;
declare variable $getLoanDetailsResponse as element() (:: schema-element(ns2:getLoanDetailsResponse) ::) external;

declare function ns1:sjSetLoanDetail($liabilityNumber as xs:string, 
                                     $getLoanDetailsResponse as element() (:: schema-element(ns2:getLoanDetailsResponse) ::)) 
                                     as element() (:: schema-element(ns3:getLoanDetailsHN_SJResponse) ::) {
    <ns3:getLoanDetailsHN_SJResponse>
        <ns3:consultaListaPrestamosResponse>
            {
                if ($getLoanDetailsResponse/ns2:StatusInfo/dyn:Status)
                then <ns3:successIndicator>{fn:data($getLoanDetailsResponse/ns2:StatusInfo/dyn:Status)}</ns3:successIndicator>
                else ()
            }
            <ns3:messages></ns3:messages>
            <ns3:LiabilityNumber>{fn:data($liabilityNumber)}</ns3:LiabilityNumber>
            {
                if ($getLoanDetailsResponse/ns2:LoanDetails/ns2:LoanCustomerName)
                then <ns3:LiabilityName>{fn:data($getLoanDetailsResponse/ns2:LoanDetails/ns2:LoanCustomerName)}</ns3:LiabilityName>
                else ()
            }
            {
                if ($getLoanDetailsResponse/ns2:LoanDetails/ns2:Currency)
                then <ns3:Currency>{fn:data($getLoanDetailsResponse/ns2:LoanDetails/ns2:Currency)}</ns3:Currency>
                else ()
            }
            {
                if ($getLoanDetailsResponse/ns2:LoanDetails/ns2:NextPaymentPrincipalAmount)
                then <ns3:PrincipalAmount>{fn:data($getLoanDetailsResponse/ns2:LoanDetails/ns2:NextPaymentPrincipalAmount)}</ns3:PrincipalAmount>
                else ()
            }
            {
                if ($getLoanDetailsResponse/ns2:LoanDetails/ns2:NextPaymentInterestAmount)
                then <ns3:InterestComAmount>{xs:double(fn:data($getLoanDetailsResponse/ns2:LoanDetails/ns2:NextPaymentInterestAmount)) + xs:double(fn:data($getLoanDetailsResponse/ns2:LoanDetails/ns2:NextPaymentInsuranceAmount))}</ns3:InterestComAmount>
                else ()
            }
            {
                if ($getLoanDetailsResponse/ns2:LoanDetails/ns2:NextPaymentTotalAmount)
                then <ns3:TotalAmount>{fn:data($getLoanDetailsResponse/ns2:LoanDetails/ns2:NextPaymentTotalAmount)}</ns3:TotalAmount>
                else ()
            }
            {
                if ($getLoanDetailsResponse/ns2:LoanDetails/ns2:NextPaymentTotalAmount)
                then <ns3:LiabilityTotalAmount>{fn:data($getLoanDetailsResponse/ns2:LoanDetails/ns2:NextPaymentTotalAmount)}</ns3:LiabilityTotalAmount>
                else ()
            }
            {
                if ($getLoanDetailsResponse/ns2:LoanDetails/ns2:MaturityDate)
                then <ns3:PaymentDate>{fn:data($getLoanDetailsResponse/ns2:LoanDetails/ns2:MaturityDate)}</ns3:PaymentDate>
                else ()
            }
            {
                if ($getLoanDetailsResponse/ns2:LoanDetails/ns2:TotalDebt)
                then <ns3:TotalCancellationAmount>{fn:data($getLoanDetailsResponse/ns2:LoanDetails/ns2:TotalDebt)}</ns3:TotalCancellationAmount>
                else ()
            }
            {
                if ($getLoanDetailsResponse/ns2:LoanDetails/ns2:LoanStatus)
                then <ns3:Status>{fn:data($getLoanDetailsResponse/ns2:LoanDetails/ns2:LoanStatus)}</ns3:Status>
                else ()
            }
            {
                if ($getLoanDetailsResponse/ns2:LoanDetails/ns2:EffectiveDate)
                then <ns3:LiabilityIssuanceDate>{fn:data($getLoanDetailsResponse/ns2:LoanDetails/ns2:EffectiveDate)}</ns3:LiabilityIssuanceDate>
                else ()
            }
            {
                if ($getLoanDetailsResponse/ns2:LoanDetails/ns2:ProductDescription)
                then <ns3:LiabilityType>{fn:data($getLoanDetailsResponse/ns2:LoanDetails/ns2:ProductDescription)}</ns3:LiabilityType>
                else ()
            }
        </ns3:consultaListaPrestamosResponse>
    </ns3:getLoanDetailsHN_SJResponse>
};

ns1:sjSetLoanDetail($liabilityNumber, $getLoanDetailsResponse)
xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/consultaPasivosCliente";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerLiabilities.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerLiabilities_BS";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerLiabilities/GetCustomerLiabilities_BS_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/middleware.services/Tx_Cobis_To_GetCustomerLiabilities";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $OutputParameters as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $uuid as xs:string external;
declare variable $liabilityType as xs:string external;

declare function ns1:func($OutputParameters as element() (:: schema-element(ns2:OutputParameters) ::),
                          $liabilityType as xs:string,
                          $uuid as xs:string) as element() (:: schema-element(ns3:getCustomerLiabilitiesResponse) ::) {
    <ns3:getCustomerLiabilitiesResponse>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        {
            if ($liabilityType = 'CreditCards' or $liabilityType = 'All')
            then
                <ns3:Liabilities>
                    <ns3:Type>CreditCards</ns3:Type>
                    <ns3:Status>{if ($OutputParameters/ns2:RowSet/ns2:Row[ns2:Column[@name = 'LIABILITY_TYPE'] = 'TCR']) then 'Success' else 'NoRecords'}</ns3:Status>
                    {
                    for $Row in $OutputParameters/ns2:RowSet/ns2:Row[ns2:Column[@name = 'LIABILITY_TYPE'] = 'TCR']
                    return 
                        <ns3:LiabilitiesDetails>
                            <ns3:LiabilityNumber>{fn:data($Row/ns2:Column[@name='LIABILITY_NUMBER'])}</ns3:LiabilityNumber>
                            <ns3:LiabilityName>{fn:data($Row/ns2:Column[@name='LIABILITY_CUST_NAME'])}</ns3:LiabilityName>
                            <ns3:Currency>{fn:data($Row/ns2:Column[@name='LIABILITY_CURRENCY_1'])}</ns3:Currency>
                            <ns3:PrincipalAmount>{fn-bea:format-number((xs:decimal(fn:data($Row/ns2:Column[@name='LIABILITY_PRINCIPAL_AMT_1']))),'0.00')}</ns3:PrincipalAmount>
                            <ns3:InterestComAmount>{fn-bea:format-number((xs:decimal(fn:data($Row/ns2:Column[@name='LIABILITY_INT_COM_AMT_1']))),'0.00')}</ns3:InterestComAmount>
                            <ns3:TotalAmount>{fn-bea:format-number((xs:decimal(fn:data($Row/ns2:Column[@name='LIABILITY_TOTAL_AMT']))),'0.00')}</ns3:TotalAmount>
                            <ns3:LiabilityTotalAmount>{fn-bea:format-number((xs:decimal(fn:data($Row/ns2:Column[@name='LIABILITY_TOTAL_AMT_1']))),'0.00')}</ns3:LiabilityTotalAmount>
                            <ns3:PaymentDate>{fn:data($Row/ns2:Column[@name='LIABILITY_PAYMENT_DATE'])}</ns3:PaymentDate>
                            <ns3:TotalCancellationAmount>{fn-bea:format-number((xs:decimal(fn:data($Row/ns2:Column[@name='LIABILITY_TOTAL_AMT']))),'0.00')}</ns3:TotalCancellationAmount>
                            <ns3:SourceBank>NI01</ns3:SourceBank>
                            <ns3:Status>ACTIVE</ns3:Status>
                        </ns3:LiabilitiesDetails>
                    }
                </ns3:Liabilities>
          else ()
        } 
        {
            if ($liabilityType = 'Loans' or $liabilityType = 'All')
            then
                <ns3:Liabilities>
                    <ns3:Type>Loans</ns3:Type>
                    <ns3:Status>{if ($OutputParameters/ns2:RowSet/ns2:Row[ns2:Column[@name = 'LIABILITY_TYPE'] = 'CCA']) then 'Success' else 'NoRecords'}</ns3:Status>
                    {
                    for $Row in $OutputParameters/ns2:RowSet/ns2:Row[ns2:Column[@name = 'LIABILITY_TYPE'] = 'CCA']
                    return 
                        <ns3:LiabilitiesDetails>
                            <ns3:LiabilityNumber>{fn:data($Row/ns2:Column[@name='LIABILITY_NUMBER'])}</ns3:LiabilityNumber>
                            <ns3:LiabilityName>{fn:data($Row/ns2:Column[@name='LIABILITY_CUST_NAME'])}</ns3:LiabilityName>
                            <ns3:Currency>{fn:data($Row/ns2:Column[@name='LIABILITY_CURRENCY_1'])}</ns3:Currency>
                            <ns3:PrincipalAmount>{fn-bea:format-number((xs:decimal(fn:data($Row/ns2:Column[@name='LIABILITY_PRINCIPAL_AMT_1']))),'0.00')}</ns3:PrincipalAmount>
                            <ns3:InterestComAmount>{fn-bea:format-number((xs:decimal(fn:data($Row/ns2:Column[@name='LIABILITY_INT_COM_AMT_1']))),'0.00')}</ns3:InterestComAmount>
                            <ns3:TotalAmount>{fn-bea:format-number((xs:decimal(fn:data($Row/ns2:Column[@name='LIABILITY_TOTAL_AMT']))),'0.00')}</ns3:TotalAmount>
                            <ns3:LiabilityTotalAmount>{fn-bea:format-number((xs:decimal(fn:data($Row/ns2:Column[@name='LIABILITY_TOTAL_AMT_1']))),'0.00')}</ns3:LiabilityTotalAmount>
                            <ns3:PaymentDate>{fn:data($Row/ns2:Column[@name='LIABILITY_PAYMENT_DATE'])}</ns3:PaymentDate>
                            <ns3:TotalCancellationAmount>{fn-bea:format-number((xs:decimal(fn:data($Row/ns2:Column[@name='LIABILITY_TOTAL_AMT']))),'0.00')}</ns3:TotalCancellationAmount>
                            <ns3:SourceBank>NI01</ns3:SourceBank>
                             <ns3:Status>ACTIVE</ns3:Status>
                        </ns3:LiabilitiesDetails>
                    }
                </ns3:Liabilities>
          else ()
        } 
    </ns3:getCustomerLiabilitiesResponse>
};

ns1:func($OutputParameters, $liabilityType, $uuid)
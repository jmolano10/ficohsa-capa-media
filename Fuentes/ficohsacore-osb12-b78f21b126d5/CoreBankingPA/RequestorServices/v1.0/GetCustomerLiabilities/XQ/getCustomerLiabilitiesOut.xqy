xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns4="http://www.ficohsa.com.hn/middleware.services/consultaPasivosCliente";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerLiabilities.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetaClienteHN";
(:: import schema at "../../../../../CreditCardProcessor/ProviderServices/XSD/GetCustomerLiabilities/conDatoTarjetaClienteGT_sp.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaPasivosCliente";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerLiabilities/GetCustomerLiabilities_BS.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/getCustomerLiabilitiesOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $liabilityType as xs:string external;
declare variable $status as xs:string external;
declare variable $customerLiabilities as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $creditCardData as element() (:: schema-element(ns3:OutputParameters) ::) external;

declare function ns1:getCustomerLiabilitiesOut($uuid as xs:string, 
                                               $liabilityType as xs:string, 
                                               $customerLiabilities as element() (:: schema-element(ns2:OutputParameters) ::), 
                                               $creditCardData as element() (:: schema-element(ns3:OutputParameters) ::)) 
                                               as element() (:: schema-element(ns4:getCustomerLiabilitiesResponse) ::) {
    <ns4:getCustomerLiabilitiesResponse>
        <ns4:StatusInfo>
            {
              if ($liabilityType = 'CreditCards' and string($creditCardData/ns3:CodigoError/text()) = '-2')
              then <com:Status>NoRecords</com:Status>
              else if ($liabilityType = 'Loans' and fn:data($customerLiabilities/ns2:ERROR_CODE) = 'NO RECORDS')
              then <com:Status>NoRecords</com:Status>
              else if ($liabilityType = 'All' and fn:data($customerLiabilities/ns2:ERROR_CODE) = 'NO RECORDS' and string($creditCardData/ns3:CodigoError/text()) = '-2')
              then <com:Status>NoRecords</com:Status>
              else <com:Status>Success</com:Status>
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns4:StatusInfo>
        {
            if ($liabilityType = 'CreditCards' or $liabilityType = 'All')
            then
                <ns4:Liabilities>
                    <ns4:Type>CreditCards</ns4:Type>
                    {
                        if (string($creditCardData/ns3:CodigoError/text()) = '-2')
                        then <ns4:Status>NoRecords</ns4:Status>
                        else <ns4:Status>Success</ns4:Status>
                    }
                    {
                        if (string($creditCardData/ns3:CodigoError/text()) = '-1') then
                            for $Row in $creditCardData/ns3:RowSet/ns3:Row
                            return
                                <ns4:LiabilitiesDetails>
                                    <ns4:LiabilityNumber>{xs:long(data($Row/ns3:Column[@name = 'numtarjeta']))}</ns4:LiabilityNumber>
                                    <ns4:LiabilityName>{data($Row/ns3:Column[@name = 'cardholder_name'])}</ns4:LiabilityName>
                                    <ns4:Currency>{data($Row/ns3:Column[@name = 'codMoneda'])}</ns4:Currency>
                                    <ns4:PrincipalAmount>{data($Row/ns3:Column[@name = 'MontoPrincipal'])}</ns4:PrincipalAmount>
                                    <ns4:TotalAmount>{data($Row/ns3:Column[@name = 'MontoTotal'])}</ns4:TotalAmount>
                                    <ns4:LiabilityTotalAmount>{data($Row/ns3:Column[@name = 'BalanceTotal'])}</ns4:LiabilityTotalAmount>
                                    {
                                    if ($Row/ns3:Column[@name = 'FechaMaximaPago'])
                                    then <ns4:PaymentDate>{fn:substring(data($Row/ns3:Column[@name = 'FechaMaximaPago']),0,11) }</ns4:PaymentDate>
                                    else <ns4:PaymentDate/>
                                    }
                                    <ns4:TotalCancellationAmount>{data($Row/ns3:Column[@name = 'MontoCancelacion'])}</ns4:TotalCancellationAmount>
                                    <ns4:SourceBank>GT01</ns4:SourceBank>
                                </ns4:LiabilitiesDetails>
                        else ()
                    }
                </ns4:Liabilities>
          else ()
        } 
        {
          if ($liabilityType = 'Loans' or $liabilityType = 'All')
          then
              <ns4:Liabilities>
                  <ns4:Type>Loans</ns4:Type>
                  {
                    if (fn:data($customerLiabilities/ns2:ERROR_CODE) = 'NO RECORDS')
                    then <ns4:Status>NoRecords</ns4:Status>
                    else <ns4:Status>Success</ns4:Status>
                  }
                  {
                  for $ITEM at $i in $customerLiabilities/ns2:LIABILITY_NUMBER/ns2:LIABILITY_NUMBER_ITEM
                  return
                      <ns4:LiabilitiesDetails>
                          <ns4:LiabilityNumber>{fn:data($customerLiabilities/ns2:LIABILITY_NUMBER/ns2:LIABILITY_NUMBER_ITEM[$i])}</ns4:LiabilityNumber>
                          <ns4:LiabilityName>{fn:data($customerLiabilities/ns2:LIABILITY_CUST_NAME/ns2:LIABILITY_CUST_NAME_ITEM[$i])}</ns4:LiabilityName>
                          <ns4:Currency>{fn:data($customerLiabilities/ns2:LIABILITY_CURRENCY_1/ns2:LIABILITY_NUMBER_ITEM[$i])}</ns4:Currency>
                          <ns4:PrincipalAmount>{fn:data($customerLiabilities/ns2:LIABILITY_PRINCIPAL_AMT_1/ns2:LIABILITY_NUMBER_ITEM[$i])}</ns4:PrincipalAmount>
                          <ns4:InterestComAmount>{fn:data($customerLiabilities/ns2:LIABILITY_INT_COM_AMT_1/ns2:LIABILITY_NUMBER_ITEM[$i])}</ns4:InterestComAmount>
                          <ns4:TotalAmount>{fn:data($customerLiabilities/ns2:LIABILITY_NUMBER/ns2:LIABILITY_NUMBER_ITEM[$i])}</ns4:TotalAmount>
                          <ns4:LiabilityTotalAmount>{fn:data($customerLiabilities/ns2:LIABILITY_TOTAL_AMT_1/ns2:LIABILITY_NUMBER_ITEM[$i])}</ns4:LiabilityTotalAmount>
                          <ns4:PaymentDate></ns4:PaymentDate>
                          <ns4:TotalCancellationAmount>{fn:data($customerLiabilities/ns2:LIABILITY_TOTAL_DEBT/ns2:LIABILITY_NUMBER_ITEM[$i])}</ns4:TotalCancellationAmount>
                          <ns4:SourceBank>GT01</ns4:SourceBank>
                      </ns4:LiabilitiesDetails>
                  }
              </ns4:Liabilities>
          else ()
        }
    </ns4:getCustomerLiabilitiesResponse>
};

ns1:getCustomerLiabilitiesOut($uuid, $liabilityType, $customerLiabilities, $creditCardData)
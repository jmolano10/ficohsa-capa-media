xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns4="http://www.ficohsa.com.hn/middleware.services/consultaPasivosCliente";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerLiabilities.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/PROXYABANKSHN/OSB_K_CONSULTALISTAPRESTAMOS/TOPLEVEL-24OSB_CON_LISTA_PRESTA/";
(:: import schema at "../../../../../../LegacyCoreBankingHN/ProviderServices/XSD/GetCustomerLiabilities/ConsultaListaPrestamos.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetaClienteHN";
(:: import schema at "../../../../../../CreditCardProcessor/ProviderServices/XSD/GetCustomerLiabilities/conDatoTarjetaClienteHN_sp.xsd" ::)
declare namespace ns5="http://www.ficohsa.com.hn/middleware.services/getLoanDetailsHN_SJ";
(:: import schema at "../XSD/GetLoanDetailsHN_SJ.xsd" ::)

declare namespace ns1="http://www.w3.org/2005/GetCustomerLiabilitiesOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $liabilityType as xs:string external;
declare variable $status as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $consultaListaPrestamosRSP as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $datosTarjetasClienteRSP as element() (:: schema-element(ns3:OutputParameters) ::) external;
declare variable $getLoanDetailsHN_SJ as element() (:: schema-element(ns5:getLoanDetailsHN_SJResponse) ::) external;

declare function ns1:getCustomerLiabilitiesOut($uuid as xs:string, 
                                               $liabilityType as xs:string, 
                                               $status as xs:string, 
                                               $sourceBank as xs:string, 
                                               $getLoanDetailsHN_SJ as element() (:: schema-element(ns5:getLoanDetailsHN_SJResponse) ::),
                                               $consultaListaPrestamosRSP as element() (:: schema-element(ns2:OutputParameters) ::), 
                                               $datosTarjetasClienteRSP as element() (:: schema-element(ns3:OutputParameters) ::)) 
                                               as element() (:: schema-element(ns4:getCustomerLiabilitiesResponse) ::) {
    <ns4:getCustomerLiabilitiesResponse>
        <ns4:StatusInfo>
            {
              if ($liabilityType = 'CreditCards' and string($datosTarjetasClienteRSP/ns3:CodigoError/text()) = '-2')
              then <com:Status>NoRecords</com:Status>
              else if ($liabilityType = 'Loans' and not($consultaListaPrestamosRSP/ns2:LIABILITY_NUMBER/ns2:ITEM))
              then <com:Status>NoRecords</com:Status>
              else if ($liabilityType = 'All' and not($consultaListaPrestamosRSP/ns2:LIABILITY_NUMBER/ns2:ITEM) and string($datosTarjetasClienteRSP/ns3:CodigoError/text()) = '-2')
              then <com:Status>NoRecords</com:Status>
              else <com:Status>{fn:data($status)}</com:Status>
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
                    if (string($datosTarjetasClienteRSP/ns3:CodigoError/text()) = '-2')
                    then <ns4:Status>NoRecords</ns4:Status>
                    else <ns4:Status>Success</ns4:Status>
                  }
                  {
                  if (string($datosTarjetasClienteRSP/ns3:CodigoError/text()) = '-1') then
                    for $Row in $datosTarjetasClienteRSP/ns3:RowSet/ns3:Row
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
                            <ns4:SourceBank>{fn:data($sourceBank)}</ns4:SourceBank>
                            {
                            if($Row/ns3:Column[@name = 'D2ED_CURR_FIRST_USAGE_FLAG'] = 'N')
                            then <ns4:Status>ACTIVE</ns4:Status>
                            else <ns4:Status>INACTIVE</ns4:Status>
                            }
                            <ns4:LiabilityIssuanceDate>{ fn:substring(data($Row/ns3:Column[@name = 'fecapertura']),0,11)}</ns4:LiabilityIssuanceDate>
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
                    if (not($consultaListaPrestamosRSP/ns2:LIABILITY_NUMBER/ns2:ITEM))
                    then <ns4:Status>NoRecords</ns4:Status>
                    else <ns4:Status>Success</ns4:Status>
                  }
                  {
                  for $ITEM at $i in $getLoanDetailsHN_SJ/ns5:consultaListaPrestamosResponse
                  where $ITEM/ns5:Status eq $ITEM/ns5:Status
                  return
                      <ns4:LiabilitiesDetails>
                          <ns4:LiabilityNumber>{fn:data($ITEM/ns5:LiabilityNumber)}</ns4:LiabilityNumber>
                          <ns4:LiabilityName>{fn:data($ITEM/ns5:LiabilityName)}</ns4:LiabilityName>
                          <ns4:Currency>{fn:data($ITEM/ns5:Currency)}</ns4:Currency>
                          <ns4:PrincipalAmount>{fn:data($ITEM/ns5:PrincipalAmount)}</ns4:PrincipalAmount>
                          <ns4:InterestComAmount>{fn:data($ITEM/ns5:InterestComAmount)}</ns4:InterestComAmount>
                          <ns4:TotalAmount>{fn:data($ITEM/ns5:TotalAmount)}</ns4:TotalAmount>
                          <ns4:LiabilityTotalAmount>{fn:data($ITEM/ns5:LiabilityTotalAmount)}</ns4:LiabilityTotalAmount>
                          <ns4:PaymentDate>{fn:data($ITEM/ns5:PaymentDate)}</ns4:PaymentDate>
                          <ns4:TotalCancellationAmount>{fn:data($ITEM/ns5:TotalCancellationAmount)}</ns4:TotalCancellationAmount>
                          <ns4:SourceBank>{fn:data($sourceBank)}</ns4:SourceBank>
                          <ns4:Status>{fn:data($ITEM/ns5:Status)}</ns4:Status>
                          <ns4:LiabilityIssuanceDate>{fn:data($ITEM/ns5:LiabilityIssuanceDate)}</ns4:LiabilityIssuanceDate>
                          <ns4:LiabilityType>{fn:data($ITEM/ns5:LiabilityType)}</ns4:LiabilityType>
                      </ns4:LiabilitiesDetails>
                  }
              </ns4:Liabilities>
          else ()
        }
    </ns4:getCustomerLiabilitiesResponse>
};

ns1:getCustomerLiabilitiesOut($uuid, $liabilityType, $status, $sourceBank, $getLoanDetailsHN_SJ, $consultaListaPrestamosRSP, $datosTarjetasClienteRSP)
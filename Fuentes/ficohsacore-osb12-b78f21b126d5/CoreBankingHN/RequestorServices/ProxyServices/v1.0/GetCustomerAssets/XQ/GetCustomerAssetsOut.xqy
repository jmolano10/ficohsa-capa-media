xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns4="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerAssetsDynamo/getCustomerAssetsDynamo.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/consultaClientes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerAssets.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
(:: import schema at "../XSD/sjConsultaActivosCliente.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/midleware.services/GetCustomerAssetsOut";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";
declare variable $sjConsultaActivosClienteResponse as element() (:: schema-element(ns1:sjConsultaActivosClienteResponse) ::) external;
declare variable $pensionesResponse as element() (:: schema-element(ns1:sjConsultaActivosClienteResponse) ::) external;
declare variable $uuid as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $status as xs:string external;

declare function ns2:getCustomerAssetsOut($status as xs:string, 
                                          $uuid as xs:string,
                                          $sourceBank as xs:string,
                                          $pensionesResponse as element() (:: schema-element(ns1:sjConsultaActivosClienteResponse) ::),
                                          $sjConsultaActivosClienteResponse as element() (:: schema-element(ns1:sjConsultaActivosClienteResponse) ::)) as element() (:: schema-element(ns3:getCustomerAssetsResponse) ::) {
    <ns3:getCustomerAssetsResponse>
        <ns3:StatusInfo>
            <com:Status>{fn:data($status)}</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        {
        if ($pensionesResponse/ns1:consultaFondoPensionesResponse/ns1:successIndicator) then
        <ns3:Assets>
            <ns3:Type>PensionFunds</ns3:Type>
            {
              if($pensionesResponse/ns1:consultaFondoPensionesResponse/ns1:successIndicator)
              then <ns3:Status>{fn:data($pensionesResponse/ns1:consultaFondoPensionesResponse/ns1:successIndicator)}</ns3:Status>
              else()
            }
            {
                for $consultaActivoResponseRecord3 in $pensionesResponse/ns1:consultaFondoPensionesResponse/ns1:consultaActivoResponseRecords/ns1:consultaActivoResponseRecord
                return 
                <ns3:AssetDetails>
                    {
                        if ($consultaActivoResponseRecord3/ns1:ACCOUNTNUMBER)
                        then <ns3:AssetNumber>{fn:data($consultaActivoResponseRecord3/ns1:ACCOUNTNUMBER)}</ns3:AssetNumber>
                        else ()
                    }
                    {
                        if($consultaActivoResponseRecord3/ns1:ACCOUNTNAME)
                        then <ns3:AssetName>{fn:data($consultaActivoResponseRecord3/ns1:ACCOUNTNAME)}</ns3:AssetName>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord3/ns1:CURRENCY)
                        then <ns3:Currency>{fn:data($consultaActivoResponseRecord3/ns1:CURRENCY)}</ns3:Currency>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord3/ns1:TOTALBALANCE)
                        then <ns3:TotalBalance>{fn:data($consultaActivoResponseRecord3/ns1:TOTALBALANCE)}</ns3:TotalBalance>
                        else ()
                    }
                    
                    <ns3:SourceBank>{fn:data($sourceBank)}</ns3:SourceBank>
                    </ns3:AssetDetails>
            }
        </ns3:Assets>
        else ()
        }
        {
        if ($sjConsultaActivosClienteResponse/ns1:consultaCertifDepositoResponse/ns1:successIndicator) then
        <ns3:Assets>
            <ns3:Type>TermDeposits</ns3:Type>
            {
                if ($sjConsultaActivosClienteResponse/ns1:consultaCertifDepositoResponse/ns1:successIndicator)
                then <ns3:Status>{fn:data($sjConsultaActivosClienteResponse/ns1:consultaCertifDepositoResponse/ns1:successIndicator)}</ns3:Status>
                else ()
            }
            {
                for $consultaActivoResponseRecord2 in $sjConsultaActivosClienteResponse/ns1:consultaCertifDepositoResponse/ns1:consultaActivoResponseRecords/ns1:consultaActivoResponseRecord
                return 
                <ns3:AssetDetails>
                    {
                        if ($consultaActivoResponseRecord2/ns1:ACCOUNTNUMBER)
                        then <ns3:AssetNumber>{fn:data($consultaActivoResponseRecord2/ns1:ACCOUNTNUMBER)}</ns3:AssetNumber>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord2/ns1:ACCOUNTNAME)
                        then <ns3:AssetName>{fn:data($consultaActivoResponseRecord2/ns1:ACCOUNTNAME)}</ns3:AssetName>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord2/ns1:CURRENCY)
                        then <ns3:Currency>{fn:data($consultaActivoResponseRecord2/ns1:CURRENCY)}</ns3:Currency>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord2/ns1:TOTALBALANCE)
                        then <ns3:TotalBalance>{fn:data($consultaActivoResponseRecord2/ns1:TOTALBALANCE)}</ns3:TotalBalance>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord2/ns1:RESERVEBALANCE)
                        then <ns3:ReserveBalance>{fn:data($consultaActivoResponseRecord2/ns1:RESERVEBALANCE)}</ns3:ReserveBalance>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord2/ns1:BLOCKEDFUNDSPOS)
                        then <ns3:LockedBalance>{fn:data($consultaActivoResponseRecord2/ns1:BLOCKEDFUNDSPOS)}</ns3:LockedBalance>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord2/ns1:LIENBALANCE)
                        then <ns3:FloatingBalance>{fn:data($consultaActivoResponseRecord2/ns1:LIENBALANCE)}</ns3:FloatingBalance>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord2/ns1:AVAILABLEBAL)
                        then <ns3:AvailableBalance>{fn:data($consultaActivoResponseRecord2/ns1:AVAILABLEBAL)}</ns3:AvailableBalance>
                        else ()
                    }
                    <ns3:SourceBank>{fn:data($sourceBank)}</ns3:SourceBank>
                    {
                        if ($consultaActivoResponseRecord2/ns1:PRODUCTTYPE)
                        then <ns3:OperationType>{fn:data($consultaActivoResponseRecord2/ns1:PRODUCTTYPE)}</ns3:OperationType>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord2/ns1:OPENINGDATE)
                        then <ns3:OpeningDate>{fn-bea:date-from-string-with-format("dd/MM/yyyy", fn:data($consultaActivoResponseRecord2/ns1:OPENINGDATE))}</ns3:OpeningDate>
                        else ()
                    }
                </ns3:AssetDetails>
            }
        </ns3:Assets>
        else ()
        }
        {
        if ($sjConsultaActivosClienteResponse/ns1:consultaCuentaCorrienteResponse) then
        <ns3:Assets>
            <ns3:Type>Currents</ns3:Type>
            {
                if ($sjConsultaActivosClienteResponse/ns1:consultaCuentaCorrienteResponse/ns1:successIndicator)
                then <ns3:Status>{fn:data($sjConsultaActivosClienteResponse/ns1:consultaCuentaCorrienteResponse/ns1:successIndicator)}</ns3:Status>
                else ()
            }
            {
                for $consultaActivoResponseRecord in $sjConsultaActivosClienteResponse/ns1:consultaCuentaCorrienteResponse/*:consultaActivoResponseRecords/ns1:consultaActivoResponseRecord
                return 
                <ns3:AssetDetails>
                {
                    if ($consultaActivoResponseRecord/ns1:ACCOUNTNUMBER)
                    then <ns3:AssetNumber>{fn:data($consultaActivoResponseRecord/ns1:ACCOUNTNUMBER)}</ns3:AssetNumber>
                    else ()
                }
                {
                    if ($consultaActivoResponseRecord/ns1:ACCOUNTNAME)
                    then <ns3:AssetName>{fn:data($consultaActivoResponseRecord/ns1:ACCOUNTNAME)}</ns3:AssetName>
                    else ()
                }
                {
                    if ($consultaActivoResponseRecord/ns1:CURRENCY)
                    then <ns3:Currency>{fn:data($consultaActivoResponseRecord/ns1:CURRENCY)}</ns3:Currency>
                    else ()
                }
                {
                    if ($consultaActivoResponseRecord/ns1:TOTALBALANCE)
                    then <ns3:TotalBalance>{fn:data($consultaActivoResponseRecord/ns1:TOTALBALANCE)}</ns3:TotalBalance>
                    else ()
                }
                {
                    if ($consultaActivoResponseRecord/ns1:RESERVEBALANCE)
                    then <ns3:ReserveBalance>{fn:data($consultaActivoResponseRecord/ns1:RESERVEBALANCE)}</ns3:ReserveBalance>
                    else ()
                }
                {
                    if ($consultaActivoResponseRecord/ns1:BLOCKEDFUNDSPOS)
                    then <ns3:LockedBalance>{fn:data($consultaActivoResponseRecord/ns1:BLOCKEDFUNDSPOS)}</ns3:LockedBalance>
                    else ()
                }
                {
                    if ($consultaActivoResponseRecord/ns1:LIENBALANCE)
                    then <ns3:FloatingBalance>{fn:data($consultaActivoResponseRecord/ns1:LIENBALANCE)}</ns3:FloatingBalance>
                    else ()
                }
                {
                    if ($consultaActivoResponseRecord//ns1:STATUS)
                    then (
                        if(data($consultaActivoResponseRecord//ns1:STATUS)= '')
                        then <ns3:Status>ACTIVE</ns3:Status>
                        else (
                            if(data($consultaActivoResponseRecord//ns1:STATUS)= 'Y')
                            then <ns3:Status>INACTIVE</ns3:Status>
                            else <ns3:Status>{fn:data($consultaActivoResponseRecord//ns1:STATUS)}</ns3:Status>
                        )
                    )
                    else ()
                }
                {
                    if ($consultaActivoResponseRecord/ns1:OPENINGDATE)
                    then <ns3:OpeningDate>{ fn-bea:date-from-string-with-format("yyyyMMdd", fn:data($consultaActivoResponseRecord/ns1:OPENINGDATE)) }</ns3:OpeningDate>
                    else ()
                }
            </ns3:AssetDetails>
            }
            
        </ns3:Assets>
        else ()
        }
        {
        if ($sjConsultaActivosClienteResponse/ns1:consultaCuentaAhorrosResponse) then
         <ns3:Assets>
            <ns3:Type>Savings</ns3:Type>
            {
                if ($sjConsultaActivosClienteResponse/ns1:consultaCuentaAhorrosResponse/ns1:successIndicator)
                then <ns3:Status>{fn:data($sjConsultaActivosClienteResponse/ns1:consultaCuentaAhorrosResponse/ns1:successIndicator)}</ns3:Status>
                else ()
            }
            {
                for $consultaActivoResponseRecord in $sjConsultaActivosClienteResponse/ns1:consultaCuentaAhorrosResponse/ns1:consultaActivoResponseRecords/ns1:consultaActivoResponseRecord
                where $consultaActivoResponseRecord/ns1:CATEGORYDESCRIPTION eq $consultaActivoResponseRecord/ns1:CATEGORYDESCRIPTION
                return 
                <ns3:AssetDetails>
                    {
                        if ($consultaActivoResponseRecord/ns1:ACCOUNTNUMBER)
                        then <ns3:AssetNumber>{fn:data($consultaActivoResponseRecord/ns1:ACCOUNTNUMBER)}</ns3:AssetNumber>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns1:ACCOUNTNAME)
                        then <ns3:AssetName>{fn:data($consultaActivoResponseRecord/ns1:ACCOUNTNAME)}</ns3:AssetName>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns1:CURRENCY)
                        then <ns3:Currency>{fn:data($consultaActivoResponseRecord/ns1:CURRENCY)}</ns3:Currency>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns1:TOTALBALANCE)
                        then <ns3:TotalBalance>{fn:data($consultaActivoResponseRecord/ns1:TOTALBALANCE)}</ns3:TotalBalance>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns1:RESERVEBALANCE)
                        then <ns3:ReserveBalance>{fn:data($consultaActivoResponseRecord/ns1:RESERVEBALANCE)}</ns3:ReserveBalance>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns1:BLOCKEDFUNDSPOS)
                        then <ns3:LockedBalance>{fn:data($consultaActivoResponseRecord/ns1:BLOCKEDFUNDSPOS)}</ns3:LockedBalance>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns1:LIENBALANCE)
                        then <ns3:FloatingBalance>{fn:data($consultaActivoResponseRecord/ns1:LIENBALANCE)}</ns3:FloatingBalance>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns1:AVAILABLEBAL)
                        then <ns3:AvailableBalance>{fn:data($consultaActivoResponseRecord/ns1:AVAILABLEBAL)}</ns3:AvailableBalance>
                        else ()
                    }
                    <ns3:SourceBank>{fn:data($sourceBank)}</ns3:SourceBank>
                    {
                        if ($consultaActivoResponseRecord/ns1:PRODUCTTYPE)
                        then <ns3:OperationType>{fn:data($consultaActivoResponseRecord/ns1:PRODUCTTYPE)}</ns3:OperationType>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns1:STATUS)
                        then (
                            if(data($consultaActivoResponseRecord/ns1:STATUS)= 'A')
                            then <ns3:Status>ACTIVE</ns3:Status>
                            else (
                                if(data($consultaActivoResponseRecord/ns1:STATUS)= 'Y')
                                then <ns3:Status>INACTIVE</ns3:Status>
                                else <ns3:Status>{fn:data($consultaActivoResponseRecord/ns1:STATUS)}</ns3:Status>
                            )
                        )                              
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns1:OPENINGDATE)
                        then <ns3:OpeningDate>{ fn-bea:date-from-string-with-format("yyyyMMdd", fn:data($consultaActivoResponseRecord/ns1:OPENINGDATE)) }</ns3:OpeningDate>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns1:ACCOUNTCATEGORY)
                        then <ns3:AccountCategory>{fn:data($consultaActivoResponseRecord/ns1:ACCOUNTCATEGORY)}</ns3:AccountCategory>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns1:CATEGORYDESCRIPTION)
                        then <ns3:CategoryDescription>{fn:data($consultaActivoResponseRecord/ns1:CATEGORYDESCRIPTION)}</ns3:CategoryDescription>
                        else ()
                    }
                    {
                        if ($consultaActivoResponseRecord/ns1:PAYROLLGROUP)
                        then <ns3:PayrollGroup>{fn:data($consultaActivoResponseRecord/ns1:PAYROLLGROUP)}</ns3:PayrollGroup>
                        else ()
                    }
                </ns3:AssetDetails>
            }
        </ns3:Assets>
        else ()
        }
    </ns3:getCustomerAssetsResponse>
};

ns2:getCustomerAssetsOut($status, $uuid, $sourceBank,$pensionesResponse, $sjConsultaActivosClienteResponse)
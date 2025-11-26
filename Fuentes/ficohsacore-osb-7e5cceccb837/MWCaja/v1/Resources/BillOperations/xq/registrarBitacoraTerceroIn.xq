(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TercerosGT/BitacoraTercero/xsd/registrarBitacoraTercero_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarBitacoraTercero";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/BillOperations/xq/registrarBitacoraTerceroIn/";

declare function xf:registrarBitacoraTerceroIn($uuid as xs:string,
    $primaryKey as xs:string,
    $transactionCode as xs:string,
    $contractNumber as xs:string,
    $transactionChannel as xs:string,
    $transactionUser as xs:string,
    $transactionAmount as xs:string,
    $transactionCurrency as xs:string,
    $target_System as xs:string,
    $serviceRequest as element(*),
    $serviceResponse as element(*),
    $dateTimeRequest as xs:dateTime,
    $dateTimeResponse as xs:dateTime,
    $errorId as xs:string,
    $errorDescription as xs:string,
    $transactionNumber as xs:string,
    $transactionId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID>{ data($uuid) }</ns0:PV_ID>
            <ns0:PV_SERVICEID>MWCAJA0007</ns0:PV_SERVICEID>
            <ns0:PV_PRIMARYKEY>{ data($primaryKey) }</ns0:PV_PRIMARYKEY>
            <ns0:PV_TRANSACTIONCODE>{ data($transactionCode) }</ns0:PV_TRANSACTIONCODE>
            <ns0:PV_CONTRACTNUMBER>{ data($contractNumber) }</ns0:PV_CONTRACTNUMBER>
            <ns0:PV_TRANSACTIONCHANNEL>{ data($transactionChannel ) }</ns0:PV_TRANSACTIONCHANNEL>
            <ns0:PV_TRANSACTIONUSER>{ data($transactionUser) }</ns0:PV_TRANSACTIONUSER>
            <ns0:PN_TRANSACTIONAMOUNT>{ data($transactionAmount) }</ns0:PN_TRANSACTIONAMOUNT>
            <ns0:PV_TRANSACTIONCURRENCY>{ data($transactionCurrency) }</ns0:PV_TRANSACTIONCURRENCY>
             {
                if($transactionNumber != 'NOAPLICA') then(
                
                   <ns0:PV_TRANSACTIONNUMBER>{ data($transactionNumber) }</ns0:PV_TRANSACTIONNUMBER>
                   )else()
             }
                          {
                if($transactionId != 'NOAPLICA') then(
                
                   <ns0:PV_TRANSACTIONID>{ data($transactionId) }</ns0:PV_TRANSACTIONID>
                   )else()
             }            
            <ns0:PV_TARGET_SYSTEM>{ data($target_System) }</ns0:PV_TARGET_SYSTEM>
            <ns0:PV_SERVICEREQUEST>{ fn-bea:serialize($serviceRequest) }</ns0:PV_SERVICEREQUEST>
            <ns0:PV_SERVICERESPONSE>{ fn-bea:serialize($serviceResponse) }</ns0:PV_SERVICERESPONSE>
            <ns0:PD_DATETIMEREQUEST>{ $dateTimeRequest }</ns0:PD_DATETIMEREQUEST>
            <ns0:PD_DATETIMERESPONSE>{ $dateTimeResponse }</ns0:PD_DATETIMERESPONSE>
            <ns0:PV_ERRORID>{ data($errorId) }</ns0:PV_ERRORID>
            <ns0:PV_ERRORDESCRIPTION>{ data($errorDescription) }</ns0:PV_ERRORDESCRIPTION>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $primaryKey as xs:string external;
declare variable $transactionCode as xs:string external;
declare variable $contractNumber as xs:string external;
declare variable $transactionChannel as xs:string external;
declare variable $transactionUser as xs:string external;
declare variable $transactionAmount as xs:string external;
declare variable $transactionCurrency as xs:string external;
declare variable $target_System as xs:string external;
declare variable $serviceRequest as element(*) external;
declare variable $serviceResponse as element(*) external;
declare variable $dateTimeRequest as xs:dateTime external;
declare variable $dateTimeResponse as xs:dateTime external;
declare variable $errorId as xs:string external;
declare variable $errorDescription as xs:string external;
declare variable $transactionNumber as xs:string external;
declare variable $transactionId as xs:string external;

xf:registrarBitacoraTerceroIn($uuid,
    $primaryKey,
    $transactionCode,
    $contractNumber,
    $transactionChannel,
    $transactionUser,
    $transactionAmount,
    $transactionCurrency,
    $target_System,
    $serviceRequest,
    $serviceResponse,
    $dateTimeRequest,
    $dateTimeResponse,
    $errorId,
    $errorDescription,
    $transactionNumber,
    $transactionId)
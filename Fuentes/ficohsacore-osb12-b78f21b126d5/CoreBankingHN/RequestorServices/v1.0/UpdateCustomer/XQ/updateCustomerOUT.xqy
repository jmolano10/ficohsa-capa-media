xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/UpdateCustomerDynamo/UpdateCustomerDynamo.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/updateCustomerOUT";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $costumerCode as xs:string external;
declare variable $uuid as xs:string external;
declare variable $actualizaciondeDatosClienteResponse as element() (:: schema-element(ns2:ActualizacionDynamodatosClientesResponse) ::) external;

declare function ns1:updateCustomerOUT($costumerCode as xs:string, 
                                       $uuid as xs:string, 
                                       $actualizaciondeDatosClienteResponse as element() (:: schema-element(ns2:ActualizacionDynamodatosClientesResponse) ::)) 
                                       as element() (:: schema-element(ns3:updateCustomerResponse) ::) {
    <ns3:updateCustomerResponse>
        <ns3:StatusInfo>
            {
                if ($actualizaciondeDatosClienteResponse/Status/successIndicator)
                then <com:Status>{fn:data($actualizaciondeDatosClienteResponse/Status/successIndicator)}</com:Status>
                else ()
            }
            {
                if ($actualizaciondeDatosClienteResponse/Status/transactionId)
                then <com:TransactionId>{fn:data($actualizaciondeDatosClienteResponse/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        <ns3:CustomerId>{fn:data($costumerCode)}</ns3:CustomerId>
        {
            for $mADDRESS.TYPE in $actualizaciondeDatosClienteResponse/CUSTOMERType/gADDRESS.TYPE/mADDRESS.TYPE
            return 
            <ns3:AddressList>
                {
                    if ($mADDRESS.TYPE/ADDRESSTYPE)
                    then <ns3:Type>{fn:data($mADDRESS.TYPE/ADDRESSTYPE)}</ns3:Type>
                    else ()
                }
                {
                    if ($mADDRESS.TYPE/MAINADPHYCOR)
                    then <ns3:IsMain>{fn:data($mADDRESS.TYPE/MAINADPHYCOR)}</ns3:IsMain>
                    else ()
                }
                {
                    if ($mADDRESS.TYPE/COMPLETEADDRES)
                    then <ns3:AddressLine1>{fn:data($mADDRESS.TYPE/COMPLETEADDRES)}</ns3:AddressLine1>
                    else ()
                }
                {
                    if ($mADDRESS.TYPE/COMPLETADDRESS)
                    then <ns3:AddressLine2>{fn:data($mADDRESS.TYPE/COMPLETADDRESS)}</ns3:AddressLine2>
                    else ()
                }</ns3:AddressList>
        }
    </ns3:updateCustomerResponse>
};

ns1:updateCustomerOUT($costumerCode, $uuid, $actualizaciondeDatosClienteResponse)
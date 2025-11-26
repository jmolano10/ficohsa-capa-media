xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/CrearClienteSimplificado/CrearClienteSimplificado_BS.xsd" ::)
declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/crearClienteSimplificadoHNOUT";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $creaciondeClienteSimplificadoResponse as element() (:: schema-element(ns2:CreaciondeClienteSimplificadoResponse) ::) external;

declare function ns1:crearClienteSimplificadoHNOUT($uuid as xs:string, 
                                                   $creaciondeClienteSimplificadoResponse as element() (:: schema-element(ns2:CreaciondeClienteSimplificadoResponse) ::)) 
                                                   as element() (:: schema-element(ns3:createCustomerResponse) ::) {
    <ns3:createCustomerResponse>
        <ns3:StatusInfo>
            {
                if ($creaciondeClienteSimplificadoResponse/Status/successIndicator)
                then <com:Status>{fn:data($creaciondeClienteSimplificadoResponse/Status/successIndicator)}</com:Status>
                else ()
            }
            {
                if ($creaciondeClienteSimplificadoResponse/Status/transactionId)
                then <com:TransactionId>{fn:data($creaciondeClienteSimplificadoResponse/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        {
            if ($creaciondeClienteSimplificadoResponse/CUSTOMERType/@id)
            then <ns3:CustomerId>{fn:data($creaciondeClienteSimplificadoResponse/CUSTOMERType/@id)}</ns3:CustomerId>
            else ()
        }
        <ns3:CustomerName>{fn:data($creaciondeClienteSimplificadoResponse/CUSTOMERType/gSHORTNAME/SHORTNAME)}</ns3:CustomerName>
        {
            for $mADDRESS.TYPE in $creaciondeClienteSimplificadoResponse/CUSTOMERType/gADDRESS.TYPE/mADDRESS.TYPE
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
    </ns3:createCustomerResponse>
};

ns1:crearClienteSimplificadoHNOUT($uuid, $creaciondeClienteSimplificadoResponse)

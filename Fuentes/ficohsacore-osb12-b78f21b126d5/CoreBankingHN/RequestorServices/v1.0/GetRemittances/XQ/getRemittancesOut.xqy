xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/Remittances/Remittances.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/getRemittances.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $consultaderemesaResponse as element() (:: schema-element(ns1:ConsultaderemesaResponse) ::) external;

declare function local:func($uuid as xs:string, $consultaderemesaResponse as element() (:: schema-element(ns1:ConsultaderemesaResponse) ::)) as element() (:: schema-element(ns2:getRemittancesResponse) ::) {
    let $WSLATAMAGREMITTANCEINFOType := $consultaderemesaResponse/WSLATAMAGREMITTANCEINFOType[1]
        return
            <ns2:getRemittancesResponse>
                {
                    for $gWSLATAMAGREMITTANCEINFODetailType in $WSLATAMAGREMITTANCEINFOType/gWSLATAMAGREMITTANCEINFODetailType
                    return
                        <ns2:getRemittancesResponseType>
                            {
                                for $mWSLATAMAGREMITTANCEINFODetailType in $gWSLATAMAGREMITTANCEINFODetailType/mWSLATAMAGREMITTANCEINFODetailType
                                return
                                    <ns2:getRemittancesResponseRecordTypes>
                                        {
                                            for $REMITTANCEKEY in $mWSLATAMAGREMITTANCEINFODetailType/REMITTANCEKEY
                                            return
                                                <RemittanceId>{ data($REMITTANCEKEY) }</RemittanceId>
                                        }
                                        {
                                            for $STATUS in $mWSLATAMAGREMITTANCEINFODetailType/STATUS
                                            return
                                                <RemittanceStatus>{ data($STATUS) }</RemittanceStatus>
                                        }
                                        <REMITTANCE_SOURCE_AMOUNT></REMITTANCE_SOURCE_AMOUNT> 
                                    </ns2:getRemittancesResponseRecordTypes>
                            }                           
                        </ns2:getRemittancesResponseType>
                }
                <ns2:StatusInfo>
                    {
                        if ($consultaderemesaResponse/Status/successIndicator)
                        then <com:Status>{fn:data($consultaderemesaResponse/Status/successIndicator)}</com:Status>
                        else ()
                    }
                    {
                        if ($consultaderemesaResponse/Status/transactionId)
                        then <com:TransactionId>{fn:data($consultaderemesaResponse/Status/transactionId)}</com:TransactionId>
                        else ()
                    }
                    <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
                    <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
                    <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
                </ns2:StatusInfo>
            </ns2:getRemittancesResponse>
};

local:func($uuid, $consultaderemesaResponse)

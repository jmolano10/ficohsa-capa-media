<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/DeviceManagement";
(:: import schema at "../xsd/DevicesManagementTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $vuResponse as element() (:: schema-element(ns1:DeviceManagementResponseVU) ::) external;
declare variable $ThresholdToValidateResponse as xs:integer external;

declare function xq:Tx_VU_ToDeviceManagementResponse($vuResponse as element() (:: schema-element(ns1:DeviceManagementResponseVU) ::), $ThresholdToValidateResponse  as xs:integer) as element() (:: schema-element(ns1:DeviceManagementResponse) ::) {
    <ns1:DeviceManagementResponse>
        <ns1:DeviceManagementRecordType>
            {
                    if ($vuResponse/ns1:description)
                    then <ns1:RESULT>{fn:data($vuResponse/ns1:description)}</ns1:RESULT>
                    else ()
            }
            {
                if ($vuResponse/ns1:existsHash and $vuResponse/ns1:accuracyPercent >= $ThresholdToValidateResponse)
                then <ns1:EXISTSDEVICE>true</ns1:EXISTSDEVICE>
                else 
                    <ns1:EXISTSDEVICE>false</ns1:EXISTSDEVICE>
            }
            {
                if ($vuResponse/ns1:accuracyPercent)
                then <ns1:ACCURANCYPERCENT>{fn:data($vuResponse/ns1:accuracyPercent)}</ns1:ACCURANCYPERCENT>
                else ()
            }
            {
                if ($vuResponse/ns1:token)
                then <ns1:TOKEN>{fn:data($vuResponse/ns1:token)}</ns1:TOKEN>
                else ()
            }
            {
                if ($vuResponse/ns1:triggeredRule)
                then <ns1:TRIGGEREDRULE>{fn:data($vuResponse/ns1:triggeredRule)}</ns1:TRIGGEREDRULE>
                else ()
            }
            {
                if ($vuResponse/ns1:analyzeResult)
                then <ns1:ANALYZERESULT>{fn:data($vuResponse/ns1:analyzeResult)}</ns1:ANALYZERESULT>
                else ()
            }
            {
              if ($vuResponse/ns1:fingerprint)
              then <ns1:HASH>{fn:data($vuResponse/ns1:fingerprint)}</ns1:HASH>
              else ()
            }
        </ns1:DeviceManagementRecordType>
    </ns1:DeviceManagementResponse>
};

xq:Tx_VU_ToDeviceManagementResponse($vuResponse,$ThresholdToValidateResponse)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/DevicesManagementTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/DeviceManagement/xsd/DevicesManagementTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>
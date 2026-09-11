<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/DeviceInfoTypes";
(:: import schema at "../xsd/DeviceInfoTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $rspVU as element() (:: schema-element(ns1:DeviceInfoResponseVU) ::) external;

declare function xq:VU_To_DeviceInfoResponse($rspVU as element() (:: schema-element(ns1:DeviceInfoResponseVU) ::)) as element() (:: schema-element(ns1:DeviceInfoResponse) ::) {
    <ns1:DeviceInfoResponse>
        <ns1:DeviceInfoRecordType>
            <ns1:Devices>
                <ns1:Browsers>
                    {
                        for $browserInfo in $rspVU/ns1:browserInfo
                        return 
                        <ns1:BrowserInfo>
                            {
                                if ($browserInfo/ns1:id)
                                then <ns1:Id>{fn:data($browserInfo/ns1:id)}</ns1:Id>
                                else ()
                            }
                            {
                                if ($browserInfo/ns1:hash)
                                then <ns1:hashdevice>{fn:data($browserInfo/ns1:hash)}</ns1:hashdevice>
                                else ()
                            }
                            {
                                if ($browserInfo/ns1:creationDate)
                                then <ns1:creationDate>{fn:data($browserInfo/ns1:creationDate)}</ns1:creationDate>
                                else ()
                            }
                            {
                                if ($browserInfo/ns1:lastCheckDate)
                                then <ns1:lastCheckDate>{fn:data($browserInfo/ns1:lastCheckDate)}</ns1:lastCheckDate>
                                else ()
                            }
                            {
                                if ($browserInfo/ns1:status)
                                then <ns1:status>{fn:data($browserInfo/ns1:status)}</ns1:status>
                                else ()
                            }
                        </ns1:BrowserInfo>
                    }
                </ns1:Browsers>
                <ns1:Mobiles>
                    {
                        for $deviceInfo in $rspVU/ns1:deviceInfo
                        return 
                        <ns1:DeviceInfo>
                            {
                                if ($deviceInfo/ns1:id)
                                then <ns1:Id>{fn:data($deviceInfo/ns1:id)}</ns1:Id>
                                else ()
                            }
                            {
                                if ($deviceInfo/ns1:hash)
                                then <ns1:hashdevice>{fn:data($deviceInfo/ns1:hash)}</ns1:hashdevice>
                                else ()
                            }
                            {
                                if ($deviceInfo/ns1:creationDate)
                                then <ns1:creationDate>{fn:data($deviceInfo/ns1:creationDate)}</ns1:creationDate>
                                else ()
                            }
                            {
                                if ($deviceInfo/ns1:deviceId)
                                then <ns1:DeviceId>{fn:data($deviceInfo/ns1:deviceId)}</ns1:DeviceId>
                                else ()
                            }
                            {
                                if ($deviceInfo/ns1:deviceName)
                                then <ns1:DeviceName>{fn:data($deviceInfo/ns1:deviceName)}</ns1:DeviceName>
                                else ()
                            }
                            {
                                if ($deviceInfo/ns1:status)
                                then <ns1:Status>{fn:data($deviceInfo/ns1:status)}</ns1:Status>
                                else ()
                            }
                            {
                                if ($deviceInfo/ns1:lastCheckDate)
                                then <ns1:LastCheckDate>{fn:data($deviceInfo/ns1:lastCheckDate)}</ns1:LastCheckDate>
                                else ()
                            }
                            {
                                if ($deviceInfo/ns1:deviceLocation)
                                then <ns1:deviceLocation>{fn:data($deviceInfo/ns1:deviceLocation)}</ns1:deviceLocation>
                                else ()
                            }
                            {
                                if ($deviceInfo/ns1:osName)
                                then <ns1:deviceOSName>{fn:data($deviceInfo/ns1:osName)}</ns1:deviceOSName>
                                else ()
                            }
                            {
                                if ($deviceInfo/ns1:osVersion)
                                then <ns1:deviceOSVersion>{fn:data($deviceInfo/ns1:osVersion)}</ns1:deviceOSVersion>
                                else ()
                            }
                        </ns1:DeviceInfo>
                    }
                </ns1:Mobiles>
            </ns1:Devices>
        </ns1:DeviceInfoRecordType>
    </ns1:DeviceInfoResponse>
};

xq:VU_To_DeviceInfoResponse($rspVU)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/DeviceInfoTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/DeviceInfo/xsd/DeviceInfoTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>
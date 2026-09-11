<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/DeviceManagement";
(:: import schema at "../xsd/DevicesManagementTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $deviceManagement as element() (:: schema-element(ns1:DeviceManagementRequest) ::) external;
declare variable $apiKey as xs:string external;
declare variable $operation as xs:string external;

declare function xq:DeviceManagement_To_VU($deviceManagement as element() (:: schema-element(ns1:DeviceManagementRequest) ::), 
                                           $apiKey as xs:string,$operation as xs:string) 
                                           as element() (:: schema-element(ns1:DeviceManagementRequestVU) ::) {

    <ns1:DeviceManagementRequestVU>
     { 
     if($operation='REGISTER_WEB' or $operation='REGISTER_MOBILE' or $operation='DELETE_DEVICE' or $operation='VALIDATE_DEVICEBYHASH' or $operation='VALIDATE_DEVICE' or $operation='VALIDATE_WEB' or $operation='VALIDATE_WEB_BYHASH' or $operation='DELETE_WEB') 
        then
        <ns1:apikey>{fn:data($apiKey)}</ns1:apikey>
      else ()
     }
     { 
     if($operation='REGISTER_WEB') 
        then    
     
         if ($deviceManagement/ns1:hash64)
         then <ns1:bfp>{fn:data($deviceManagement/ns1:hash64)}</ns1:bfp>
         else ()
      else ()
     }
     { 
     if($operation='REGISTER_MOBILE') 
        then
        
         if ($deviceManagement/ns1:hashApp)
         then <ns1:fingerprint>{fn:data($deviceManagement/ns1:hashApp)}</ns1:fingerprint>
         else ()
      else ()
     }     
     { 
     if($operation='REGISTER_WEB' or $operation='REGISTER_MOBILE' or $operation='DELETE_DEVICE' or $operation='VALIDATE_DEVICEBYHASH' or $operation='VALIDATE_DEVICE' or $operation='VALIDATE_WEB' or $operation='VALIDATE_WEB_BYHASH' or $operation='DELETE_WEB') 
        then    
     <ns1:userid>{fn:data($deviceManagement/ns1:user)}</ns1:userid>
      else ()
     }

     { 
     if($operation='REGISTER_MOBILE') 
        then
        <ns1:randomSeed>{fn:data($deviceManagement/ns1:randomSeed)}</ns1:randomSeed>
      else ()
     }  
     {
     if ($operation='REGISTER_MOBILE')
     then
     <ns1:deviceFingerprintData>
         {
             if ($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='DEVICEID']/ns1:VALUE)
             then <ns1:deviceId>{fn:data($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='DEVICEID']/ns1:VALUE)}</ns1:deviceId>
             else ()
         }
         {
             if ($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='DEVICENAME']/ns1:VALUE)
             then <ns1:deviceName>{fn:data($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='DEVICENAME']/ns1:VALUE)}</ns1:deviceName>
             else ()
         }
         {
             if ($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='DEVICEMANUFACTURER']/ns1:VALUE)
             then <ns1:deviceManufacturer>{fn:data($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='DEVICEMANUFACTURER']/ns1:VALUE)}</ns1:deviceManufacturer>
             else ()
         }
         {
             if ($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='DEVICERESOLUTION']/ns1:VALUE)
             then <ns1:deviceResolution>{fn:data($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='DEVICERESOLUTION']/ns1:VALUE)}</ns1:deviceResolution>
             else ()
         }
         {
             if ($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='ISROOTED']/ns1:VALUE)
             then <ns1:isRooted>{fn:data($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='ISROOTED']/ns1:VALUE)}</ns1:isRooted>
             else ()
         }
         {
             if ($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='ISJAILBROKEN']/ns1:VALUE)
             then <ns1:isJailbroken>{fn:data($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='ISJAILBROKEN']/ns1:VALUE)}</ns1:isJailbroken>
             else ()
         }
         {
             if ($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='ISFINGERPRINTCOMPATIBLE']/ns1:VALUE)
             then <ns1:isFingerprCompatible>{fn:data($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='ISFINGERPRINTCOMPATIBLE']/ns1:VALUE)}</ns1:isFingerprCompatible>
             else ()
         }
         {
             if ($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='ISGPSCOMPATIBLE']/ns1:VALUE)
             then <ns1:isGPSCompatible>{fn:data($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='ISGPSCOMPATIBLE']/ns1:VALUE)}</ns1:isGPSCompatible>
             else ()
         }
         {
             if ($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='OSNAME']/ns1:VALUE)
             then <ns1:osName>{fn:data($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='OSNAME']/ns1:VALUE)}</ns1:osName>
             else ()
         }
         {
             if ($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='OSVERSION']/ns1:VALUE)
             then <ns1:osVersion>{fn:data($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='OSVERSION']/ns1:VALUE)}</ns1:osVersion>
             else ()
         }
         {
             if ($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='APILEVEL']/ns1:VALUE)
             then <ns1:apiLevel>{fn:data($deviceManagement/ns1:DeviceInfo/ns1:Info[ns1:KEY='APILEVEL']/ns1:VALUE)}</ns1:apiLevel>
             else ()
         }
     </ns1:deviceFingerprintData>
     else ()
     }
     {
     if ($operation='REGISTER_MOBILE')
     then
     <ns1:deviceLocation>
         {
             if ($deviceManagement/ns1:deviceLocation/ns1:Location[ns1:KEY='LATITUDE']/ns1:KEY)
             then <ns1:latitude>{fn:data($deviceManagement/ns1:deviceLocation/ns1:Location[ns1:KEY='LATITUDE']/ns1:VALUE)}</ns1:latitude>
             else ()
         }
         {
             if ($deviceManagement/ns1:deviceLocation/ns1:Location[ns1:KEY='LONGITUDE']/ns1:KEY)
             then <ns1:longitude>{fn:data($deviceManagement/ns1:deviceLocation/ns1:Location[ns1:KEY='LONGITUDE']/ns1:VALUE)}</ns1:longitude>
             else ()
         }
     </ns1:deviceLocation>
     else ()
     }
     {
     if ($operation='DELETE_DEVICE' or $operation='VALIDATE_DEVICEBYHASH' or $operation='VALIDATE_WEB_BYHASH' or $operation='DELETE_WEB')
     then
     
         if ($deviceManagement/ns1:hashApp)
         then <ns1:fingerprintHash>{fn:data($deviceManagement/ns1:hashApp)}</ns1:fingerprintHash>
         else ()
     else ()
     }
     {
     if ($operation='VALIDATE_DEVICE' or $operation='VALIDATE_WEB')
     then
     
         if ($deviceManagement/ns1:token)
         then <ns1:token>{fn:data($deviceManagement/ns1:token)}</ns1:token>
         else ()
     else ()
     }
     {
     if ($operation='VALIDATE_DEVICE' or $operation='VALIDATE_WEB')
     then
     
         if ($deviceManagement/ns1:description)
         then <ns1:description>{fn:data($deviceManagement/ns1:description)}</ns1:description>
         else ()
     else ()
     }     
    </ns1:DeviceManagementRequestVU>
  


};

xq:DeviceManagement_To_VU($deviceManagement, $apiKey,$operation)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/DevicesManagementTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/DeviceManagement/xsd/DevicesManagementTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>
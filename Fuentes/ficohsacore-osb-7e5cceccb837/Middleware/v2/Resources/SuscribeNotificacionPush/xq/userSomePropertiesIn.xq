xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:setUserSomeProperties" location="../../../BusinessServices/LATINIA/provisionerUserService/xsd/XMLSchema_-751714706.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SuscribeNotificacionPush/xq/userSomePropertiesIn/";
declare namespace ns1 = "http://com.latinia/lsubscribers/provisioner/data";
declare namespace ns0 = "http://com.latinia/lsubscribers/provisioner";

declare function xf:userSomePropertiesIn($validation as xs:string,
    $customerid as xs:string,
    $poseepush as xs:string,
    $refCompany as xs:string)
    as element(ns0:setUserSomeProperties) {
        <ns0:setUserSomeProperties>
            <validation>{ $validation }</validation>
            <refCompany>{ $refCompany }</refCompany>
            <refUser>{ $customerid }</refUser>
            <properties>
                <name>poseePush</name>
                {
                   if ($poseepush = "ENABLE") then (
                <values>Y</values>
                  ) else (
                <values>N</values>
				    )
		    	}
            </properties>
        </ns0:setUserSomeProperties>
};

declare variable $validation as xs:string external;
declare variable $customerid as xs:string external;
declare variable $poseepush as xs:string external;
declare variable $refCompany as xs:string external;

xf:userSomePropertiesIn($validation,
    $customerid,
    $poseepush,
    $refCompany)
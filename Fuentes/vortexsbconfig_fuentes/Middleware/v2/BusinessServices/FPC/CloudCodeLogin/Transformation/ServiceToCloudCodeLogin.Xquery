<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/getEncryptCredentialsTypes";
(:: import schema at "../Schemas/GetEncryptCredentialsTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/honduras/pension/user";
(:: import schema at "../Schemas/UserLoginTypes.xsd" ::)

declare variable $credentials as element() (:: schema-element(ns2:credentials) ::) external;
declare variable $forceLogin as xs:boolean external;

declare function local:func($credentials as element() (:: schema-element(ns2:credentials) ::), 
                            $forceLogin as xs:boolean) 
                            as element() (:: schema-element(ns1:cloudCodeLoginRequest) ::) {
    <ns1:cloudCodeLoginRequest>
        <userName>{fn:data($credentials/ns2:userName)}</userName>
        <password>{fn:data($credentials/ns2:userPassword)}</password>
        {
          let $currentDateTime := fn:current-dateTime()
          let $stringDate := fn:string($currentDateTime)
          let $dateTime := fn-bea:dateTime-from-string-with-format("yyyy-MM-dd'T'HH:mm:ss",$stringDate)
          return(
            <timestamp>{$dateTime}</timestamp>
          )
        }
        <forceLogin>{fn:data($forceLogin)}</forceLogin>
    </ns1:cloudCodeLoginRequest>
};

local:func($credentials, $forceLogin)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetEncryptCredentialsTypes.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/FPC/CloudCodeLogin/Schemas/GetEncryptCredentialsTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/UserLoginTypes.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/FPC/CloudCodeLogin/Schemas/UserLoginTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>
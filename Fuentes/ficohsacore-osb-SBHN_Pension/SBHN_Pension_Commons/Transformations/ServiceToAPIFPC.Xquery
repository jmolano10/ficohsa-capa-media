<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/CloudCodeLoginTypes";
(:: import schema at "../../SBHN_Pension_CloudCodeLogin/Schemas/CloudCodeLoginTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/user";
(:: import schema at "../Schemas/UserLoginTypes.xsd" ::)

declare variable $credentials as element() (:: schema-element(ns1:credentials) ::) external;
declare variable $forceLogin as xs:boolean external;

declare function local:func($credentials as element() (:: schema-element(ns1:credentials) ::), 
                            $forceLogin as xs:boolean) 
                            as element() (:: schema-element(ns2:cloudCodeLoginRequest) ::) {
    <ns2:cloudCodeLoginRequest>
        <ns2:userName>{fn:data($credentials/ns1:userName)}</ns2:userName>
        <ns2:password>{fn:data($credentials/ns1:userPassword)}</ns2:password>
        {
          let $currentDateTime := fn:current-dateTime()
          let $stringDate := fn:string($currentDateTime)
          let $dateTime := fn-bea:dateTime-from-string-with-format("yyyy-MM-dd'T'HH:mm:ss",$stringDate)
          return(<ns2:timestamp>{fn:data($dateTime)}</ns2:timestamp>)
        }
        <ns2:forceLogin>{fn:data($forceLogin)}</ns2:forceLogin>
    </ns2:cloudCodeLoginRequest>
};

local:func($credentials, $forceLogin)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_CloudCodeLogin/Schemas/CloudCodeLoginTypes.xsd">
            <con:schema ref="SBHN_Pension_CloudCodeLogin/Schemas/CloudCodeLoginTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/UserLoginTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/UserLoginTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>
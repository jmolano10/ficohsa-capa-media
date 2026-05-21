<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/schema/encryptCredentialsFPCAPITypes";
(:: import schema at "../Resources/encryptCredentialsFPCAPI.wsdl" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/getEncryptCredentialsTypes";
(:: import schema at "../Schemas/GetEncryptCredentialsTypes.xsd" ::)

declare variable $request as element() (:: schema-element(ns1:cloudCodeLoginRequest) ::) external;

declare function local:func($request as element() (:: schema-element(ns1:cloudCodeLoginRequest) ::)) as element() (:: schema-element(ns2:encryptCredentialsFPCAPIRequest) ::) {
    <ns2:encryptCredentialsFPCAPIRequest>
        <userAlias>{fn:data($request/userName)}</userAlias>
        <userPassword>{fn:data($request/password)}</userPassword>
        {
          let $currentDateTime := fn:current-dateTime()
          let $stringDate := fn:string($currentDateTime)
          let $dateTime := fn-bea:dateTime-from-string-with-format("yyyy-MM-dd'T'HH:mm:ss", $stringDate)
          return(
            <beginDate>{$dateTime}</beginDate>
          )
        }
    </ns2:encryptCredentialsFPCAPIRequest>
};

local:func($request)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Resources/encryptCredentialsFPCAPI.wsdl">
            <con:wsdl ref="SBHN_Pension_CloudCodeLogin/Resources/encryptCredentialsFPCAPI"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetEncryptCredentialsTypes.xsd">
            <con:schema ref="SBHN_Pension_CloudCodeLogin/Schemas/GetEncryptCredentialsTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>
xquery version "1.0" encoding "utf-8";

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

local:func($request)
xquery version "1.0" encoding "utf-8";
(:: pragma bea:global-element-return element="ns0:processDataRequest" location="../../../BusinessServices/operacionesCriptograficas/wsdl/cryptographicOperations.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/cryptographicOperationsTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/processDataIn/";

declare function xf:processDataIn($cipher as xs:string,
    $keyAlias as xs:string,
    $value as xs:string,
    $operation as xs:string)
    as element(ns0:processDataRequest) {
        <ns0:processDataRequest>
            <operationType>{ $operation }</operationType>
            <cipher>{ $cipher }</cipher>
            <keyAlias>{ $keyAlias }</keyAlias>
            <dataItems>
                <fieldItem>
                    <value>{ $value }</value>
                </fieldItem>
            </dataItems>
        </ns0:processDataRequest>
};

declare variable $cipher as xs:string external;
declare variable $keyAlias as xs:string external;
declare variable $value as xs:string external;
declare variable $operation as xs:string external;

xf:processDataIn($cipher,
    $keyAlias,
    $value,
    $operation)
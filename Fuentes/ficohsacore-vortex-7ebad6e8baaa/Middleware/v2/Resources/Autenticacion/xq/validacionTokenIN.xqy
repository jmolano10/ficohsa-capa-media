xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validacionToken1" element="ns0:validacionToken" location="../xsd/autenticacionInternaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:authenticateGenericChallengeCallParms" location="../../../BusinessServices/Entrust/wsdl/AuthenticationServiceV9.wsdl" ::)

declare namespace ns2 = "urn:entrust.com:ig:authenticationV9:wsdl";
declare namespace ns1 = "urn:entrust.com:ig:commonV9";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autenticacionInternaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Autenticacion/xq/validacionTokenIN/";

declare function xf:validacionTokenIN($validacionToken1 as element(ns0:validacionToken),
    $AuthType as xs:string,
    $SecurityLevel as xs:string,
    $TokenVendedorId as xs:string)
    as element(ns2:authenticateGenericChallengeCallParms) {
        <ns2:authenticateGenericChallengeCallParms>
            <userId>{ data($validacionToken1/USERNAME) }</userId>
            <response>
                <response>
                    <item>{ data($validacionToken1/TOKEN) }</item>
                </response>
            </response>
            <parms>
                <SecurityLevel>{ $SecurityLevel }</SecurityLevel>
                <AuthenticationType>{ $AuthType }</AuthenticationType>
                <tokenVendorId>{ $TokenVendedorId }</tokenVendorId>
            </parms>
        </ns2:authenticateGenericChallengeCallParms>
};

declare variable $validacionToken1 as element(ns0:validacionToken) external;
declare variable $AuthType as xs:string external;
declare variable $SecurityLevel as xs:string external;
declare variable $TokenVendedorId as xs:string external;

xf:validacionTokenIN($validacionToken1,
    $AuthType,
    $SecurityLevel,
    $TokenVendedorId)
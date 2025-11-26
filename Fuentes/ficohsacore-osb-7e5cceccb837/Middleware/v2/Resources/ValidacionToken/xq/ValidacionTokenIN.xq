(:: pragma bea:global-element-return element="ns1:authenticateGenericChallengeCallParms" location="../../../BusinessServices/Entrust/wsdl/AuthenticationServiceV9.wsdl" ::)

declare namespace ns1 = "urn:entrust.com:ig:authenticationV9:wsdl";
declare namespace ns0 = "urn:entrust.com:ig:commonV9";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidacionToken/xq/ValidacionTokenIN/";

declare function xf:ValidacionTokenIN($UserId as xs:string,
    $Token as xs:string,
    $AuthType as xs:string,
    $SecurityLevel as xs:string,
    $VendedorTokenId as xs:string)
    as element(ns1:authenticateGenericChallengeCallParms) {
        <ns1:authenticateGenericChallengeCallParms>
            <userId>{ $UserId }</userId>
            <response>
                <response>
                    <item>{ $Token }</item>
                </response>
            </response>
            <parms>
                <SecurityLevel>{ $SecurityLevel }</SecurityLevel>
                <AuthenticationType>{ $AuthType }</AuthenticationType>
                <tokenVendorId>{ $VendedorTokenId }</tokenVendorId>
            </parms>
        </ns1:authenticateGenericChallengeCallParms>
};

declare variable $UserId as xs:string external;
declare variable $Token as xs:string external;
declare variable $AuthType as xs:string external;
declare variable $SecurityLevel as xs:string external;
declare variable $VendedorTokenId as xs:string external;

xf:ValidacionTokenIN($UserId,
    $Token,
    $AuthType,
    $SecurityLevel,
    $VendedorTokenId)

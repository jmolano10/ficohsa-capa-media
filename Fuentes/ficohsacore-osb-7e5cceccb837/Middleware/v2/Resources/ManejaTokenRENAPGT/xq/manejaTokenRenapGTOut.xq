(:: pragma bea:global-element-return element="man:manejaTokenRENAPResponse" location="../xsd/manejaTokenRENAPGTTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ManejaTokenRENAPGT/xq/manejaTokenRenapGTOut/";
declare namespace man = "http://www.ficohsa.com.hn/middleware.services/manejaTokenRENAPGTTypes";

declare function xf:manejaTokenRenapGTOut($TokenRenap as xs:string)
    as element(man:manejaTokenRENAPResponse) {
        <man:manejaTokenRENAPResponse>
            <TOKEN>{ $TokenRenap }</TOKEN>
        </man:manejaTokenRENAPResponse>
};

declare variable $TokenRenap as xs:string external;

xf:manejaTokenRenapGTOut($TokenRenap)
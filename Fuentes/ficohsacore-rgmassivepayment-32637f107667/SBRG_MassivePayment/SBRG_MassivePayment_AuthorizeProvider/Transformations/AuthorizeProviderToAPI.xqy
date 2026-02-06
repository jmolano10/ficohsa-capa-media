xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/AuthorizeProviderTypes.xsd" ::)

declare variable $authorizeProvider as element() (:: schema-element(ns1:authorizeProvider) ::) external;

declare function local:authorizeProvider(
    $authorizeProvider as element() (:: schema-element(ns1:authorizeProvider) ::)
    ) as element() (:: schema-element(ns2:AutorizarProveedores) ::) {
    <ns2:AutorizarProveedores>
        <requestHeader>
            <sourceBank>{fn:data($authorizeProvider/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($authorizeProvider/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($authorizeProvider/CustomerId)}</customerId>
            <userName>{fn:data($authorizeProvider/GeneralInfo/ApplicationId)}</userName>
            <userId>{fn:data($authorizeProvider/UserId)}</userId>
        </requestHeader>
        {
            for $Suppliers in $authorizeProvider/Suppliers
            return 
            <suppliers>{fn:data($Suppliers)}</suppliers>
        }
    </ns2:AutorizarProveedores>
};

local:authorizeProvider($authorizeProvider)
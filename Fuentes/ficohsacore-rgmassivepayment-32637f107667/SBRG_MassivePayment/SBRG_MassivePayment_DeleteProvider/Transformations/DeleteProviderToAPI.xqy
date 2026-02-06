xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/DeleteProviderTypes.xsd" ::)

declare variable $deleteProvider as element() (:: schema-element(ns1:deleteProvider) ::) external;

declare function local:deleteProvider(
    $deleteProvider as element() (:: schema-element(ns1:deleteProvider) ::)
    ) as element() (:: schema-element(ns2:EliminarProveedores) ::) {
    <ns2:EliminarProveedores>
        <requestHeader>
            <sourceBank>{fn:data($deleteProvider/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($deleteProvider/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($deleteProvider/CustomerId)}</customerId>
            <userName>{fn:data($deleteProvider/GeneralInfo/ApplicationId)}</userName>
        </requestHeader>
        {
            for $Suppliers in $deleteProvider/Suppliers
            return 
            <suppliers>{fn:data($deleteProvider/Suppliers)}</suppliers>
        }
    </ns2:EliminarProveedores>
};

local:deleteProvider($deleteProvider)
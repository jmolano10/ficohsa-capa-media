xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_AuthorizeProvider/Schemas/AuthorizeProviderTypes.xsd" ::)

declare variable $autorizarProveedores as element() (:: schema-element(ns1:autorizarProveedores) ::) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;

declare function local:func(
    $autorizarProveedores as element() (:: schema-element(ns1:autorizarProveedores) ::),
    $SourceBank as xs:string, 
    $DestinationBank as xs:string
    ) as element() (:: schema-element(ns2:authorizeProvider) ::) {
    <ns2:authorizeProvider>
        <GeneralInfo>
            <SourceBank>{fn:data($SourceBank)}</SourceBank>
            <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
        </GeneralInfo>
        <CustomerId>{fn:data($autorizarProveedores/CUSTOMER_ID)}</CustomerId>
        <UserId>{fn:data($autorizarProveedores/USER_ID)}</UserId>
        {
            for $SUPPLIER in $autorizarProveedores/SUPPLIERS/SUPPLIER
            return 
            <Suppliers>{fn:data($SUPPLIER/ID)}</Suppliers>
        }
    </ns2:authorizeProvider>
};

local:func($autorizarProveedores, $SourceBank, $DestinationBank)
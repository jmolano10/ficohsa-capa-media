xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_DeleteProvider/Schemas/DeleteProviderTypes.xsd" ::)

declare variable $eliminarProveedores as element() (:: schema-element(ns1:eliminarProveedores) ::) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;

declare function local:func(
    $eliminarProveedores as element() (:: schema-element(ns1:eliminarProveedores) ::),
    $SourceBank as xs:string, 
    $DestinationBank as xs:string
    ) as element() (:: schema-element(ns2:deleteProvider) ::) {
    <ns2:deleteProvider>
        <GeneralInfo>
            <SourceBank>{fn:data($SourceBank)}</SourceBank>
            <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
        </GeneralInfo>
        <CustomerId>{fn:data($eliminarProveedores/CUSTOMER_ID)}</CustomerId>
        {
            for $SUPPLIER in $eliminarProveedores/SUPPLIERS/SUPPLIER
            return 
            <Suppliers>{fn:data($SUPPLIER/ID)}</Suppliers>
        }
    </ns2:deleteProvider>
};

local:func($eliminarProveedores, $SourceBank, $DestinationBank)
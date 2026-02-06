xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_GetSupplier/Schemas/GetSupplierTypes.xsd" ::)

declare variable $consultarProveedores as element() (:: schema-element(ns1:consultarProveedores) ::) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;

declare function local:func(
    $consultarProveedores as element() (:: schema-element(ns1:consultarProveedores) ::),
    $SourceBank as xs:string, 
    $DestinationBank as xs:string
    ) as element() (:: schema-element(ns2:getSupplier) ::) {
    <ns2:getSupplier>
        <GeneralInfo>
            <SourceBank>{fn:data($SourceBank)}</SourceBank>
            <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
        </GeneralInfo>
        <CustomerId>{fn:data($consultarProveedores/CUSTOMER_ID)}</CustomerId>
        <SupplierStatus>{fn:data($consultarProveedores/SUPPLIER_STATUS)}</SupplierStatus>
        {
            for $SUPPLIER in $consultarProveedores/SUPPLIERS/SUPPLIER
            return 
            <Suppliers>{fn:data($SUPPLIER/ID)}</Suppliers>
        }
    </ns2:getSupplier>
};

local:func($consultarProveedores, $SourceBank, $DestinationBank)
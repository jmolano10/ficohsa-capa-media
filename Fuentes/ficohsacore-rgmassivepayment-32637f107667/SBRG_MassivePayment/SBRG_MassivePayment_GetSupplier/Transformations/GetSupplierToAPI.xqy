xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/GetSupplierTypes.xsd" ::)

declare variable $getSupplier as element() (:: schema-element(ns1:getSupplier) ::) external;

declare function local:func(
    $getSupplier as element() (:: schema-element(ns1:getSupplier) ::)
    ) as element() (:: schema-element(ns2:ConsultarProveedores) ::) {
    <ns2:ConsultarProveedores>
        <requestHeader>
            <sourceBank>{fn:data($getSupplier/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($getSupplier/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($getSupplier/CustomerId)}</customerId>
            <userName>{fn:data($getSupplier/GeneralInfo/ApplicationId)}</userName>
        </requestHeader>
        <supplierStatus>{fn:data($getSupplier/SupplierStatus)}</supplierStatus>
        {
            for $Suppliers in $getSupplier/Suppliers
            where fn:string-length(fn:data($Suppliers)) > 0
            return 
            <suppliers>{fn:data($Suppliers)}</suppliers>
        }
    </ns2:ConsultarProveedores>
};

local:func($getSupplier)
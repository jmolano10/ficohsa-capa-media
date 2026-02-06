xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/CreateSupplierTypes.xsd" ::)

declare variable $createSupplier as element() (:: schema-element(ns1:createSupplier) ::) external;

declare function local:func(
    $createSupplier as element() (:: schema-element(ns1:createSupplier) ::)
    ) as element() (:: schema-element(ns2:CargarProveedores) ::) {
    <ns2:CargarProveedores>
        <requestHeader>
            <sourceBank>{fn:data($createSupplier/GeneralInfo/SourceBank)}</sourceBank>
            <destinationBank>{fn:data($createSupplier/GeneralInfo/DestinationBank)}</destinationBank>
            <customerId>{fn:data($createSupplier/CustomerId)}</customerId>
            <userName>{fn:data($createSupplier/GeneralInfo/ApplicationId)}</userName>
            <userId>{fn:data($createSupplier/UserId)}</userId>
        </requestHeader>
        {
            for $Suppliers in $createSupplier/Suppliers
            return 
            <suppliers>
                <id>{fn:data($Suppliers/Id)}</id>
                <name>{fn:data($Suppliers/Name)}</name>
                <legalId>{fn:data($Suppliers/LegalId)}</legalId>
                {
                    if ($Suppliers/DestinationBank)
                    then <destinationBank>{fn:data($Suppliers/DestinationBank)}</destinationBank>
                    else ()
                }
                <accountNumber>{fn:data($Suppliers/AccountNumber)}</accountNumber>
                {
                    if ($Suppliers/AccountType)
                    then <accountType>{fn:data($Suppliers/AccountType)}</accountType>
                    else ()
                }
            </suppliers>
        }
    </ns2:CargarProveedores>
};

local:func($createSupplier)
xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_CreateSupplier/Schemas/CreateSupplierTypes.xsd" ::)

declare variable $cargarProveedores as element() (:: schema-element(ns1:cargarProveedores) ::) external;
declare variable $SourceBank as xs:string external;
declare variable $DestinationBank as xs:string external;

declare function local:func(
    $cargarProveedores as element() (:: schema-element(ns1:cargarProveedores) ::),
    $SourceBank as xs:string, 
    $DestinationBank as xs:string
    ) as element() (:: schema-element(ns2:createSupplier) ::) {
    <ns2:createSupplier>
        <GeneralInfo>
            <SourceBank>{fn:data($SourceBank)}</SourceBank>
            <DestinationBank>{fn:data($DestinationBank)}</DestinationBank>
        </GeneralInfo>
        <CustomerId>{fn:data($cargarProveedores/CUSTOMER_ID)}</CustomerId>
        <UserId>{fn:data($cargarProveedores/USER_ID)}</UserId>
        {
            for $SUPPLIER in $cargarProveedores/SUPPLIERS/SUPPLIER
            return 
            <Suppliers>
                <Id>{fn:data($SUPPLIER/ID)}</Id>
                <Name>{fn:data($SUPPLIER/NAME)}</Name>
                <LegalId>{fn:data($SUPPLIER/LEGAL_ID)}</LegalId>
                {
                    if ($SUPPLIER/DESTINATION_BANK)
                    then <DestinationBank>{fn:data($SUPPLIER/DESTINATION_BANK)}</DestinationBank>
                    else ()
                }
                <AccountNumber>{fn:data($SUPPLIER/ACCOUNT_NUMBER)}</AccountNumber>
                {
                    if ($SUPPLIER/ACCOUNT_TYPE)
                    then <AccountType>{fn:data($SUPPLIER/ACCOUNT_TYPE)}</AccountType>
                    else ()
                }
            </Suppliers>
        }
    </ns2:createSupplier>
};

local:func($cargarProveedores, $SourceBank, $DestinationBank)
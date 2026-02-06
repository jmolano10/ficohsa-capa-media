xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
(:: import schema at "../../../Schemas/PagosMasivos/pagosMasivosTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../../../../SBRG_MassivePayment_GetSupplier/Schemas/GetSupplierTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:getSupplierResponse) ::) external;

declare function local:func($responseService as element() (:: schema-element(ns1:getSupplierResponse) ::)) as element() (:: schema-element(ns2:consultarProveedoresResponse) ::) {
    <ns2:consultarProveedoresResponse>
        {
            if ($responseService/CustomerId)
            then <CUSTOMER_ID>{fn:data($responseService/CustomerId)}</CUSTOMER_ID>
            else ()
        }
        <SUPPLIERS>
            {
                for $Suppliers in $responseService/Suppliers
                return 
                <SUPPLIER>
                    <ID>{fn:data($Suppliers/Id)}</ID>
                    <NAME>{fn:data($Suppliers/Name)}</NAME>
                    <LEGAL_ID>{fn:data($Suppliers/LegalId)}</LEGAL_ID>
                    {
                        if ($Suppliers/DestinationBank)
                        then <DESTINATION_BANK>{fn:data($Suppliers/DestinationBank)}</DESTINATION_BANK>
                        else ()
                    }
                    {
                        if ($Suppliers/DestinationBankDesc)
                        then <DESTINATION_BANK_DESC>{fn:data($Suppliers/DestinationBankDesc)}</DESTINATION_BANK_DESC>
                        else ()
                    }
                    <ACCOUNT_NUMBER>{fn:data($Suppliers/AccountNumber)}</ACCOUNT_NUMBER>
                    {
                        if ($Suppliers/AccountType)
                        then <ACCOUNT_TYPE>{fn:data($Suppliers/AccountType)}</ACCOUNT_TYPE>
                        else ()
                    }
                    {
                        if ($Suppliers/Status)
                        then <STATUS>{fn:data($Suppliers/Status)}</STATUS>
                        else ()
                    }
                </SUPPLIER>
            }
        </SUPPLIERS>
    </ns2:consultarProveedoresResponse>
};

local:func($responseService)
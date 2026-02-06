xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/massivePayment/apiPagosMasivosTypes";
(:: import schema at "../../SBRG_MassivePayment_Commons/Schemas/APIPagosMasivosTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/massivePayment";
(:: import schema at "../Schemas/GetSupplierTypes.xsd" ::)

declare variable $responseService as element() (:: schema-element(ns1:ConsultarProveedoresResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:func(
    $responseService as element() (:: schema-element(ns1:ConsultarProveedoresResponse) ::),
    $globalId as xs:string
    ) as element() (:: schema-element(ns2:getSupplierResponse) ::) {
    <ns2:getSupplierResponse>
        <StatusInfo>
            <Status>Success</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        {
            if ($responseService/customerId)
            then <CustomerId>{fn:data($responseService/customerId)}</CustomerId>
            else ()
        }
        {
            for $suppliers in $responseService/suppliers
            return 
            <Suppliers>
                <Id>{fn:data($suppliers/id)}</Id>
                <Name>{fn:data($suppliers/name)}</Name>
                <LegalId>{fn:data($suppliers/legalId)}</LegalId>
                {
                    if ($suppliers/destinationBank)
                    then <DestinationBank>{fn:data($suppliers/destinationBank)}</DestinationBank>
                    else ()
                }
                {
                    if ($suppliers/destinationBankDescription)
                    then <DestinationBankDesc>{fn:data($suppliers/destinationBankDescription)}</DestinationBankDesc>
                    else ()
                }
                <AccountNumber>{fn:data($suppliers/accountNumber)}</AccountNumber>
                {
                    if ($suppliers/accountType)
                    then <AccountType>{fn:data($suppliers/accountType)}</AccountType>
                    else ()
                }
                {
                    if ($suppliers/status)
                    then <Status>{fn:data($suppliers/status)}</Status>
                    else ()
                }
            </Suppliers>
        }
    </ns2:getSupplierResponse>
};

local:func($responseService, $globalId)
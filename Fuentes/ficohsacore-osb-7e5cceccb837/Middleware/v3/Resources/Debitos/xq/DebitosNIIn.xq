(:: pragma bea:global-element-return element="ns0:opTransferenciaRegSalienteTcSolicitud" location="../../../../v2/BusinessServices/CTS/transferencia/xsd/services.xsd" ::)

declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns0 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/Debitos/xq/DebitosNIIn/";

declare function xf:DebitosNIIn($TransactionType as xs:int,
    $SourceAccount as xs:string,
    $DestinationAccount as xs:string,
    $Amount as xs:string,
    $Currency as xs:string,
    $DestinationCountry as xs:string,
    $DestinationBank as xs:string,
    $Beneficiary as xs:string,
    $DestinationProduct as xs:string,
    $DestinationTypeId as xs:string,
    $DestinationId as xs:string,
    $DestinationAmount as xs:string,
    $DestinationCurrency as xs:string,
    $Concept as xs:string,
    $InterfaceReferenceNumber as xs:string)
    as element(ns0:opTransferenciaRegSalienteTcSolicitud) {
        <ns0:opTransferenciaRegSalienteTcSolicitud>
            <ns1:modo>{ $TransactionType }</ns1:modo>
            <ns1:ctaOrigen>{ $SourceAccount }</ns1:ctaOrigen>
            <ns1:ctaDestino>{ $DestinationAccount }</ns1:ctaDestino>
            <ns1:monto>{ fn:number($Amount) }</ns1:monto>
            <ns1:moneda>{ $Currency }</ns1:moneda>
            <ns1:paisDestino>{ $DestinationCountry }</ns1:paisDestino>
            <ns1:bcoDestino>{ $DestinationBank }</ns1:bcoDestino>
            <ns1:beneficiario>{ $Beneficiary }</ns1:beneficiario>
            <ns1:prodDestino>{ $DestinationProduct }</ns1:prodDestino>
            <ns1:tipoidDestino>{ $DestinationTypeId }</ns1:tipoidDestino>
            <ns1:idDestino>{ $DestinationId }</ns1:idDestino>
            <ns1:montoOrigen>{ fn:number($Amount) }</ns1:montoOrigen>
            <ns1:montoDestino>{ fn:number($DestinationAmount) }</ns1:montoDestino>
            <ns1:monedaOrigen>{ $Currency }</ns1:monedaOrigen>
            <ns1:monedaDestino>{ $DestinationCurrency }</ns1:monedaDestino>
            <ns1:concepto>{ $Concept }</ns1:concepto>
            <ns1:referencia>{ fn:number($InterfaceReferenceNumber) }</ns1:referencia>
        </ns0:opTransferenciaRegSalienteTcSolicitud>
};

declare variable $TransactionType as xs:int external;
declare variable $SourceAccount as xs:string external;
declare variable $DestinationAccount as xs:string external;
declare variable $Amount as xs:string external;
declare variable $Currency as xs:string external;
declare variable $DestinationCountry as xs:string external;
declare variable $DestinationBank as xs:string external;
declare variable $Beneficiary as xs:string external;
declare variable $DestinationProduct as xs:string external;
declare variable $DestinationTypeId as xs:string external;
declare variable $DestinationId as xs:string external;
declare variable $DestinationAmount as xs:string external;
declare variable $DestinationCurrency as xs:string external;
declare variable $Concept as xs:string external;
declare variable $InterfaceReferenceNumber as xs:string external;

xf:DebitosNIIn($TransactionType,
    $SourceAccount,
    $DestinationAccount,
    $Amount,
    $Currency,
    $DestinationCountry,
    $DestinationBank,
    $Beneficiary,
    $DestinationProduct,
    $DestinationTypeId,
    $DestinationId,
    $DestinationAmount,
    $DestinationCurrency,
    $Concept,
    $InterfaceReferenceNumber)

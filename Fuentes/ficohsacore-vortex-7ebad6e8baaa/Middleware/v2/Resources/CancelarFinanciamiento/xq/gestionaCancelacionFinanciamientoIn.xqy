xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cancelarFinanciamiento" element="ns0:cancelarFinanciamiento" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CreaGestionCancelacionFinanciamiento" location="../../../../External/Outgoing/BusinessServices/Salesforce/gestionaCancelacionFinanciamiento/wsdl/gestionaCancelacionFinanciamiento.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns1 = "http://soap.sforce.com/schemas/class/WS_CreateCaseHelper";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarFinanciamiento/xq/gestionaCancelacionFinanciamientoIn/";

declare function xf:gestionaCancelacionFinanciamientoIn($cancelarFinanciamiento as element(ns0:cancelarFinanciamiento),
    $currency as xs:string,
    $subReason as xs:string,
    $reason as xs:string,
    $priority as xs:string)
    as element(ns1:CreaGestionCancelacionFinanciamiento) {
        <ns1:CreaGestionCancelacionFinanciamiento>
            <ns1:numeroCuenta>{ data($cancelarFinanciamiento/CREDIT_CARD_INFO/ACCOUNT_NUMBER) }</ns1:numeroCuenta>
            <ns1:numTarjeta>{ data($cancelarFinanciamiento/CREDIT_CARD_INFO/CARD_NUMBER) }</ns1:numTarjeta>
            <ns1:emailCliente>{ data($cancelarFinanciamiento/CUSTOMER_EMAIL) }</ns1:emailCliente>
            <ns1:motivoCancelacionFinanciamiento>{ $reason }</ns1:motivoCancelacionFinanciamiento>
            <ns1:subMotivoCancelacionFinanciamiento>{ $subReason }</ns1:subMotivoCancelacionFinanciamiento>
            <ns1:prioridad>{ $priority }</ns1:prioridad>
            <ns1:productoCancelado>{ data($cancelarFinanciamiento/FINANCING_DETAILS/TYPE) }</ns1:productoCancelado>
            <ns1:Monto>{ data($cancelarFinanciamiento/CANCELLATION_DETAILS/AMOUNT) }</ns1:Monto>
            <ns1:Moneda>{ $currency }</ns1:Moneda>
            <ns1:Asunto>{ data($cancelarFinanciamiento/CANCELLATION_DETAILS/SUBJECT) }</ns1:Asunto>
            <ns1:Descripcion>{ data($cancelarFinanciamiento/CANCELLATION_DETAILS/SUBJECT) }</ns1:Descripcion>
            <ns1:comprobante>{ data($cancelarFinanciamiento/FINANCING_DETAILS/ID) }</ns1:comprobante>
        </ns1:CreaGestionCancelacionFinanciamiento>
};

declare variable $cancelarFinanciamiento as element(ns0:cancelarFinanciamiento) external;
declare variable $currency as xs:string external;
declare variable $subReason as xs:string external;
declare variable $reason as xs:string external;
declare variable $priority as xs:string external;

xf:gestionaCancelacionFinanciamientoIn($cancelarFinanciamiento,
    $currency,
    $subReason,
    $reason,
    $priority)
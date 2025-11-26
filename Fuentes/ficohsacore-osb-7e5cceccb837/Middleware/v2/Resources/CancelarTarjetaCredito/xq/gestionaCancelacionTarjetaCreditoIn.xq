(:: pragma bea:global-element-parameter parameter="$cancelarTarjetaCredito" element="ns0:cancelarTarjetaCredito" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CreaGestionCancelacionCuenta" location="../../../../External/Outgoing/BusinessServices/Salesforce/gestionaCancelacionTarjetaCredito/wsdl/gestionaCancelacionTarjetaCredito.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns1 = "http://soap.sforce.com/schemas/class/WS_CreateCaseHelper";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarTarjetaCredito/xq/gestionaCancelacionTarjetaCreditoIn/";

declare function xf:gestionaCancelacionTarjetaCreditoIn($cancelarTarjetaCredito as element(ns0:cancelarTarjetaCredito),
    $source as xs:string,
    $reason as xs:string)
    as element(ns1:CreaGestionCancelacionCuenta) {
        <ns1:CreaGestionCancelacionCuenta>
            <ns1:numeroCuenta>{ data($cancelarTarjetaCredito/CREDIT_CARD_INFO/ACCOUNT_NUMBER) }</ns1:numeroCuenta>
            <ns1:numTarjeta>{ data($cancelarTarjetaCredito/CREDIT_CARD_INFO/CARD_NUMBER) }</ns1:numTarjeta>
            <ns1:emailCliente>{ data($cancelarTarjetaCredito/CUSTOMER_EMAIL) }</ns1:emailCliente>
            <ns1:OrigenCancelacion>{ $source }</ns1:OrigenCancelacion>
            <ns1:MotivoCacelacion>{ $reason }</ns1:MotivoCacelacion>
            <ns1:Subject>{ data($cancelarTarjetaCredito/CANCELLATION_DETAILS/SUBJECT) }</ns1:Subject>
        </ns1:CreaGestionCancelacionCuenta>
};

declare variable $cancelarTarjetaCredito as element(ns0:cancelarTarjetaCredito) external;
declare variable $source as xs:string external;
declare variable $reason as xs:string external;

xf:gestionaCancelacionTarjetaCreditoIn($cancelarTarjetaCredito,
    $source,
    $reason)

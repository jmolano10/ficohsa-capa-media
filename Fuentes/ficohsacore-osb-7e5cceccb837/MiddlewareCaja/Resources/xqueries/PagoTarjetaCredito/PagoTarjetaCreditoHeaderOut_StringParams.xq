(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../xsds/General/Autenticacion_v2.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/PagoTarjetaCreditoHeaderOut_StringParams/";

declare function xf:PagoTarjetaCreditoHeaderOut_StringParams($TransactionID as xs:string,
    $SuccessIndicator as xs:string,
    $Messages as xs:string,
    $ValueDate as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <transactionId>{ $TransactionID }</transactionId>
            <successIndicator>{ $SuccessIndicator }</successIndicator>
            <valueDate>{ $ValueDate }</valueDate>
        </ns0:ResponseHeader>
};

declare variable $TransactionID as xs:string external;
declare variable $SuccessIndicator as xs:string external;
declare variable $Messages as xs:string external;
declare variable $ValueDate as xs:string external;

xf:PagoTarjetaCreditoHeaderOut_StringParams($TransactionID,
    $SuccessIndicator,
    $Messages,
    $ValueDate)

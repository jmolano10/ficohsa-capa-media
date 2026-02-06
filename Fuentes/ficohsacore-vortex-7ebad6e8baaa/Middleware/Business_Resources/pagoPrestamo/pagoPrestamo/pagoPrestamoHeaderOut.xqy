xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_PAG_PRESTAMO_T24/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/pagoPrestamoHeaderOut/";

declare function xf:pagoPrestamoHeaderOut($valueDate as xs:string,
    $transactionId as xs:string,
    $outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <transactionId>{ $transactionId }</transactionId>
            {
                for $ERROR_CODE in $outputParameters/ns0:ERROR_CODE
                return
                    <successIndicator>{ data($ERROR_CODE) }</successIndicator>
            }
            {
                for $ERROR_MESSAGE in $outputParameters/ns0:ERROR_MESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
            <valueDate>{ $valueDate }</valueDate>
        </ns1:ResponseHeader>
};

declare variable $valueDate as xs:string external;
declare variable $transactionId as xs:string external;
declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:pagoPrestamoHeaderOut($valueDate,
    $transactionId,
    $outputParameters)
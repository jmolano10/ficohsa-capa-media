(:: pragma bea:global-element-return element="ns0:consultaDetalleCompletoTransaccion" location="../../../../Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VerificaPagoRecaudo/xq/consultaDetalleTxnIn/";

declare function xf:consultaDetalleTxnIn($transactionId as xs:string)
    as element(ns0:consultaDetalleCompletoTransaccion) {
        <ns0:consultaDetalleCompletoTransaccion>
            <TRANSACTION_REFERENCE>{ $transactionId }</TRANSACTION_REFERENCE>
        </ns0:consultaDetalleCompletoTransaccion>
};

declare variable $transactionId as xs:string external;

xf:consultaDetalleTxnIn($transactionId)
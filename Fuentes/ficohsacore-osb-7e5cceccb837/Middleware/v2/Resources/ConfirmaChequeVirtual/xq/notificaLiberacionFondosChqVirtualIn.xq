(:: pragma bea:global-element-parameter parameter="$confirmaChequeVirtual" element="ns2:confirmaChequeVirtual" location="../xsd/confirmaChequeVirtualTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleDeDepChqVirtualResponse" element="ns1:ConsultaDetalleDeDepChqVirtualResponse" location="../../../../Business_Resources/compensacion/resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns0:notificaEstadoChequeVirtual" location="../../NotificaEstadoChequeVirtual/xsd/notificaEstadoChequeVirtualTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoChequeVirtualTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/confirmaChequeVirtualTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmaChequeVirtual/xq/notificaLiberacionFondosChqVirtualIn/";

declare function xf:notificaLiberacionFondosChqVirtualIn($confirmaChequeVirtual as element(ns2:confirmaChequeVirtual),
    $consultaDetalleDeDepChqVirtualResponse as element(ns1:ConsultaDetalleDeDepChqVirtualResponse))
    as element(ns0:notificaEstadoChequeVirtual) {
        <ns0:notificaEstadoChequeVirtual>
            <ID_RECORD_REF>{ data($confirmaChequeVirtual/ID_RECORD_REF) }</ID_RECORD_REF>
            <USER_CODE>{ data($consultaDetalleDeDepChqVirtualResponse/CHQVIRNOTIFICAWSType[1]/gCHQVIRNOTIFICAWSDetailType/mCHQVIRNOTIFICAWSDetailType[1]/USERCODE) }</USER_CODE>
            <CHEQUE_NO>{ data($consultaDetalleDeDepChqVirtualResponse/CHQVIRNOTIFICAWSType[1]/gCHQVIRNOTIFICAWSDetailType/mCHQVIRNOTIFICAWSDetailType[1]/CHEQUENO) }</CHEQUE_NO>
            <CURRENCY>{ data($consultaDetalleDeDepChqVirtualResponse/CHQVIRNOTIFICAWSType[1]/gCHQVIRNOTIFICAWSDetailType/mCHQVIRNOTIFICAWSDetailType[1]/CURRENCY) }</CURRENCY>
            <AMOUNT>{ data($consultaDetalleDeDepChqVirtualResponse/CHQVIRNOTIFICAWSType[1]/gCHQVIRNOTIFICAWSDetailType/mCHQVIRNOTIFICAWSDetailType[1]/AMOUNT) }</AMOUNT>
            <DATE_TIME>{ data($consultaDetalleDeDepChqVirtualResponse/CHQVIRNOTIFICAWSType[1]/gCHQVIRNOTIFICAWSDetailType/mCHQVIRNOTIFICAWSDetailType[1]/DATETIME) }</DATE_TIME>
            <ISSUING_BANK>{ data($consultaDetalleDeDepChqVirtualResponse/CHQVIRNOTIFICAWSType[1]/gCHQVIRNOTIFICAWSDetailType/mCHQVIRNOTIFICAWSDetailType[1]/ISSUINGBANK) }</ISSUING_BANK>
            <STATUS>{ data($consultaDetalleDeDepChqVirtualResponse/CHQVIRNOTIFICAWSType[1]/gCHQVIRNOTIFICAWSDetailType/mCHQVIRNOTIFICAWSDetailType[1]/STATUS) }</STATUS>
            <MESSAGE>{ data($consultaDetalleDeDepChqVirtualResponse/CHQVIRNOTIFICAWSType[1]/gCHQVIRNOTIFICAWSDetailType/mCHQVIRNOTIFICAWSDetailType[1]/MENSAJE) }</MESSAGE>
        </ns0:notificaEstadoChequeVirtual>
};

declare variable $confirmaChequeVirtual as element(ns2:confirmaChequeVirtual) external;
declare variable $consultaDetalleDeDepChqVirtualResponse as element(ns1:ConsultaDetalleDeDepChqVirtualResponse) external;

xf:notificaLiberacionFondosChqVirtualIn($confirmaChequeVirtual,
    $consultaDetalleDeDepChqVirtualResponse)
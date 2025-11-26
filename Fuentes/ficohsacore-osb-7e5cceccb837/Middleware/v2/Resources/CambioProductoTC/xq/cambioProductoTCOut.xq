(:: pragma bea:global-element-parameter parameter="$accountProductTransferUpdateResponse1" element="ns0:AccountProductTransferUpdateResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cambioProductoTCResponse" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambioProductoTC/xq/cambioProductoTCOut/";

declare function xf:cambioProductoTCOut($accountProductTransferUpdateResponse1 as element(ns0:AccountProductTransferUpdateResponse))
    as element(ns1:cambioProductoTCResponse) {
        <ns1:cambioProductoTCResponse>
            <LOGO_ID>{ data($accountProductTransferUpdateResponse1/AZXFXO-XFR-TO-LOGO) }</LOGO_ID>
            <ACCOUNT>{ data($accountProductTransferUpdateResponse1/AZXFXO-XFR-TO-ACCT) }</ACCOUNT>
            <REASON_ACTION>{ data($accountProductTransferUpdateResponse1/AZXFXO-CARD-ACTION-REASON) }</REASON_ACTION>
            <TRANSACTION_DATE>{ data($accountProductTransferUpdateResponse1/AZXFXO-XFR-EFF-DATE) }</TRANSACTION_DATE>
            <REASON_REJECTION>{ data($accountProductTransferUpdateResponse1/AZXFXO-REJ-REASON) }</REASON_REJECTION>
        </ns1:cambioProductoTCResponse>
};

declare variable $accountProductTransferUpdateResponse1 as element(ns0:AccountProductTransferUpdateResponse) external;

xf:cambioProductoTCOut($accountProductTransferUpdateResponse1)
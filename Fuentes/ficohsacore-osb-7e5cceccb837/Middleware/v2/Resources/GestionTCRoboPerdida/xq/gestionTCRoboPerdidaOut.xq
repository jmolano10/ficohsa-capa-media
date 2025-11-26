(:: pragma bea:global-element-parameter parameter="$cardTransferResponse1" element="ns0:CardTransferResponse" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)
(:: pragma bea:global-element-return element="ns1:gestionTCRoboPerdidaResponse" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionTCRoboPerdida/xq/gestionTCRoboPerdidaOut/";

declare function xf:gestionTCRoboPerdidaOut($cardTransferResponse1 as element(ns0:CardTransferResponse))
    as element(ns1:gestionTCRoboPerdidaResponse) {
        <ns1:gestionTCRoboPerdidaResponse>
            <CARD_NUMBER>{ data($cardTransferResponse1/ARXE1O-CARD-NBR) }</CARD_NUMBER>
            <TRANSFER_ACCOUNT>{ data($cardTransferResponse1/ARXE1O-XFR-TO-ACCT) }</TRANSFER_ACCOUNT>
            <CUSTOMER_ID>{ data($cardTransferResponse1/ARXE1O-XFR-TO-CUST) }</CUSTOMER_ID>
            <CURRENT_DATE>{ data($cardTransferResponse1/ARXE1O-EFF-DATE) }</CURRENT_DATE>
            <BLOCK_TYPE>{ data($cardTransferResponse1/ARXE1O-BLOCK-CODE) }</BLOCK_TYPE>
        </ns1:gestionTCRoboPerdidaResponse>
};

declare variable $cardTransferResponse1 as element(ns0:CardTransferResponse) external;

xf:gestionTCRoboPerdidaOut($cardTransferResponse1)
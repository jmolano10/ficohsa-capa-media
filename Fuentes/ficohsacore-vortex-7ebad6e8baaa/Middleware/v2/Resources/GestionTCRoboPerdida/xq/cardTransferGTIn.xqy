xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$gestionTCRoboPerdida1" element="ns1:gestionTCRoboPerdida" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:CardTransferRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionTCRoboPerdida/xq/cardTransferIn/";

declare function xf:cardTransferIn($gestionTCRoboPerdida1 as element(ns1:gestionTCRoboPerdida),
    $org as xs:string,
    $seqCard as xs:string,
    $numCuenta as xs:string,
    $orgCliente as xs:string)
    as element(ns0:CardTransferRequest) {
        <ns0:CardTransferRequest>
            <ARXE1I-ORG>{ data($org) }</ARXE1I-ORG>
            <ARXE1I-CARD-NBR>{ data($gestionTCRoboPerdida1/CARD_NUMBER) }</ARXE1I-CARD-NBR>
            <ARXE1I-CARD-SEQ>{ data($seqCard) }</ARXE1I-CARD-SEQ>
            <ARXE1I-BS-ACCT>{ $numCuenta }</ARXE1I-BS-ACCT>
            <ARXE1I-CUS-ORG>{ data($orgCliente) }</ARXE1I-CUS-ORG>
            <ARXE1I-ARXF-FUNCTION>T</ARXE1I-ARXF-FUNCTION>
            <ARXE1I-LOGO>{ data($gestionTCRoboPerdida1/LOGO) }</ARXE1I-LOGO>
            <ARXE1I-START-DATE>{ data($gestionTCRoboPerdida1/EFFECTIVE_DATE) }</ARXE1I-START-DATE>
            <ARXE1I-XFR-TO-ACCT>/</ARXE1I-XFR-TO-ACCT>
            <ARXE1I-XFR-TO-CUST>{ data($gestionTCRoboPerdida1/CUSTOMER_ID) }</ARXE1I-XFR-TO-CUST>
            <ARXE1I-EFF-DATE>{ fn:adjust-date-to-timezone(fn:current-date(),()) }</ARXE1I-EFF-DATE>
            <ARXE1I-XFR-REP-IND>0</ARXE1I-XFR-REP-IND>
            <ARXE1I-BLOCK-CODE>{ data($gestionTCRoboPerdida1/BLOCK_TYPE) }</ARXE1I-BLOCK-CODE>
            <ARXE1I-PROCESS-TYPE>{ data($gestionTCRoboPerdida1/PROCCESS_TYPE) }</ARXE1I-PROCESS-TYPE>
            <ARXE1I-REASON-CODE>{ data($gestionTCRoboPerdida1/BLOCK_REASON) }</ARXE1I-REASON-CODE>
            <ARXE1I-ISSUE-TYPE>S</ARXE1I-ISSUE-TYPE>
        </ns0:CardTransferRequest>
};

declare variable $gestionTCRoboPerdida1 as element(ns1:gestionTCRoboPerdida) external;
declare variable $org as xs:string external;
declare variable $seqCard as xs:string external;
declare variable $numCuenta as xs:string external;
declare variable $orgCliente as xs:string external;

xf:cardTransferIn($gestionTCRoboPerdida1,
    $org,
    $seqCard,
    $numCuenta,
    $orgCliente)
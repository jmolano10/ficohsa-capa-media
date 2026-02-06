xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:CardActionUpdateRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RemplazoPlasticoTC/xq/cardActionUpdateNIIn/";

declare function xf:cardActionUpdateNIIn($org as xs:string,
    $cardNumber as xs:string,
    $sequenceCard as xs:string,
    $pinSupression as xs:string,
    $action as xs:string,
    $processType as xs:string)
    as element(ns0:CardActionUpdateRequest) {
        <ns0:CardActionUpdateRequest>
            <ARXPRI-ORG>{ data($org) }</ARXPRI-ORG>
            <ARXPRI-CARD-NBR>{ data($cardNumber) }</ARXPRI-CARD-NBR>
            <ARXPRI-CARD-SEQ>{ data($sequenceCard) }</ARXPRI-CARD-SEQ>
            <ARXPRI-ACTION>{ data($action) }</ARXPRI-ACTION>
            <ARXPRI-NBR-REQ-CARDS>1</ARXPRI-NBR-REQ-CARDS>
            <ARXPRI-NBR-RET-CARDS>0</ARXPRI-NBR-RET-CARDS>
            <ARXPRI-RANDOM-PIN-GEN>{ data($pinSupression) }</ARXPRI-RANDOM-PIN-GEN>
            <CardActionUserArray/>
  			<ARXPRI-SDP-PROCESS-TYPE>{ data($processType) }</ARXPRI-SDP-PROCESS-TYPE>
  			<ARXPRI-CARD-ACTION-REASON/>
        </ns0:CardActionUpdateRequest>
};

declare variable $org as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $sequenceCard as xs:string external;
declare variable $pinSupression as xs:string external;
declare variable $action as xs:string external;
declare variable $processType as xs:string external;

xf:cardActionUpdateNIIn($org,
    $cardNumber,
    $sequenceCard,
    $pinSupression,
    $action,
    $processType)
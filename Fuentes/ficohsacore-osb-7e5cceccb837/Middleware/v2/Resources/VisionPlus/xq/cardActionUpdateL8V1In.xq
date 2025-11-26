(:: pragma bea:global-element-return element="ns0:CardActionUpdateL8V1Request" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlus/xq/cardActionUpdateIn1/";

declare function xf:cardActionUpdateIn1($org as xs:string,
    $cardNumber as xs:string,
    $sequenceCard as xs:string)
    as element(ns0:CardActionUpdateL8V1Request) {
        <ns0:CardActionUpdateL8V1Request>
            <AZXPRI-ORG>{ data($org) }</AZXPRI-ORG>
            <AZXPRI-CARD-NBR>{ data($cardNumber) }</AZXPRI-CARD-NBR>
            <AZXPRI-CARD-SEQ>{ data($sequenceCard) }</AZXPRI-CARD-SEQ>
            <AZXPRI-ACTION>7</AZXPRI-ACTION>
            <AZXPRI-NBR-REQ-CARDS>1</AZXPRI-NBR-REQ-CARDS>
            <AZXPRI-NBR-RET-CARDS>0</AZXPRI-NBR-RET-CARDS>
            <AZXPRI-RANDOM-PIN-GEN>0</AZXPRI-RANDOM-PIN-GEN>
             <CardActionUserArray/>
         	<AZXPRI-SDP-PROCESS-TYPE/>
         	<AZXPRI-CARD-ACTION-REASON/>
        </ns0:CardActionUpdateL8V1Request>
};

declare variable $org as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $sequenceCard as xs:string external;

xf:cardActionUpdateIn1($org,
    $cardNumber,
    $sequenceCard)
(:: pragma bea:global-element-return element="ns0:PINSuppressionUpdateRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionTCRoboPerdida/xq/PINSuppressionUpdateIn/";

declare function xf:PINSuppressionUpdateIn($org as xs:string,
    $numTarjeta as xs:string,
    $seqCard as xs:string,
    $pinSuppression as xs:string)
    as element(ns0:PINSuppressionUpdateRequest) {
        <ns0:PINSuppressionUpdateRequest>
            <AZXPNI-ORG>{ data($org) }</AZXPNI-ORG>
            <AZXPNI-CARD-NBR>{ data($numTarjeta) }</AZXPNI-CARD-NBR>
            <AZXPNI-CARD-SEQ>{ data($seqCard) }</AZXPNI-CARD-SEQ>
            <AZXPNI-PIN-SUPPRESSION>{ data($pinSuppression) }</AZXPNI-PIN-SUPPRESSION>
        </ns0:PINSuppressionUpdateRequest>
};

declare variable $org as xs:string external;
declare variable $numTarjeta as xs:string external;
declare variable $seqCard as xs:string external;
declare variable $pinSuppression as xs:string external;

xf:PINSuppressionUpdateIn($org,
    $numTarjeta,
    $seqCard,
    $pinSuppression)
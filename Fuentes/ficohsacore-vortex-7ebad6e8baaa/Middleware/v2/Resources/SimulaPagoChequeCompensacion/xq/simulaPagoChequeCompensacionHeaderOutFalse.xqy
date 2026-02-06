xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$simulapagodechqporcompensacionResponse" element="ns0:Simulapagodechqporcompensacion_ValidateResponse" location="../../../../Business_Resources/compensacion/resources/XMLSchema_1569843523.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SimulaPagoChequeCompensacion/xq/simulaPagoChequeCompensacionHeaderOutFalse/";

declare function xf:simulaPagoChequeCompensacionHeaderOutFalse($simulapagodechqporcompensacionResponse as element(ns0:Simulapagodechqporcompensacion_ValidateResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $simulapagodechqporcompensacionResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $REJECTIONCODE in $simulapagodechqporcompensacionResponse/FICOINWARDCLEARINGType/REJECTIONCODE,
                    $REJECTIONTYPE in $simulapagodechqporcompensacionResponse/FICOINWARDCLEARINGType/REJECTIONTYPE,
                    $messageId in $simulapagodechqporcompensacionResponse/Status/messageId
                return
                    <messageId>{ concat($REJECTIONCODE, "-", $REJECTIONTYPE, "", $messageId) }</messageId>
            }
            <successIndicator>ERROR</successIndicator>
            {
                for $application in $simulapagodechqporcompensacionResponse/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $REJECTIONREASON in $simulapagodechqporcompensacionResponse/FICOINWARDCLEARINGType/REJECTIONREASON union $simulapagodechqporcompensacionResponse/Status/messages,
                	$REJECTIONCODE in $simulapagodechqporcompensacionResponse/FICOINWARDCLEARINGType/REJECTIONCODE,
                    $REJECTIONTYPE in $simulapagodechqporcompensacionResponse/FICOINWARDCLEARINGType/REJECTIONTYPE
                return
                    <messages>{ concat($REJECTIONCODE,"-",$REJECTIONTYPE,"-", $REJECTIONREASON) }</messages>
            }
            {
                let $result :=
                    for $DATETIME in $simulapagodechqporcompensacionResponse/FICOINWARDCLEARINGType/gDATETIME/DATETIME
                    return
                        <valueDate>{ data($DATETIME) }</valueDate>
                return
                    $result[1]
            }
        </ns1:ResponseHeader>
};

declare variable $simulapagodechqporcompensacionResponse as element(ns0:Simulapagodechqporcompensacion_ValidateResponse) external;

xf:simulaPagoChequeCompensacionHeaderOutFalse($simulapagodechqporcompensacionResponse)
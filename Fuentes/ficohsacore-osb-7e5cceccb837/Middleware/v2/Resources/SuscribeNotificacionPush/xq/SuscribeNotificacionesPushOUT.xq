(:: pragma  parameter="$CostumerType" type="anyType" ::)
(:: pragma bea:global-element-parameter parameter="$suscribeNotificacionPush" element="ns0:SuscribeNotificacionPush" location="../xsd/SuscribeNotificacionPushTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:SuscribeNotificacionPushResponse" location="../xsd/SuscribeNotificacionPushTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/SuscribeNotificacionPushTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SuscribeNotificacionPush/xq/SuscribeNotificacionesPushOUT/";

declare function xf:SuscribeNotificacionesPushOUT($CustomerType as element(*),
    $suscribeNotificacionPush as element(ns0:SuscribeNotificacionPush))
    as element(ns0:SuscribeNotificacionPushResponse) {
        <ns0:SuscribeNotificacionPushResponse>
            {
                let $COSTUMERS := $suscribeNotificacionPush/COSTUMERS
                return
                    <COSTUMERS>
                        {
                            for $COSTUMER_DETAIL at $i  in $COSTUMERS/COSTUMER_DETAIL
                            
                            return
                                 if (data($CustomerType/SUCCESS_INDICATOR_RESPONSE/SUCCESS_INDICATOR[$i]='ERROR')) then (
                                <COSTUMER_DETAIL>
                                    <MESSAGE_ID>{ data($CustomerType/MESSAGE_ID_RESPONSE/MESSAGE_ID[$i]) }</MESSAGE_ID>
                                    <ID>{ data($CustomerType/ID_RESPONSE/ID[$i]) }</ID>
                                    <SUCCESS_INDICATOR>{ data($CustomerType/SUCCESS_INDICATOR_RESPONSE/SUCCESS_INDICATOR[$i]) }</SUCCESS_INDICATOR>
                                    <ERROR_MESSAGE>{ data($CustomerType/ERROR_MESSAGE_RESPONSE/ERROR_MESSAGE[$i]) }</ERROR_MESSAGE>
                                </COSTUMER_DETAIL>
                                 )else(
                                 <COSTUMER_DETAIL>
                                       <ID>{ data($CustomerType/ID_RESPONSE/ID[$i]) }</ID>
                                       <SUCCESS_INDICATOR>{ data($CustomerType/SUCCESS_INDICATOR_RESPONSE/SUCCESS_INDICATOR[$i]) }</SUCCESS_INDICATOR>    
                                </COSTUMER_DETAIL>
                                 )
                        }
                    </COSTUMERS>
            }
        </ns0:SuscribeNotificacionPushResponse>
};

declare variable $CustomerType as element(*) external;
declare variable $suscribeNotificacionPush as element(ns0:SuscribeNotificacionPush) external;

xf:SuscribeNotificacionesPushOUT($CustomerType,
    $suscribeNotificacionPush)
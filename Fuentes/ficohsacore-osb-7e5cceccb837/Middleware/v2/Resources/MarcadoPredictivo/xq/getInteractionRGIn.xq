(:: pragma bea:global-element-parameter parameter="$marcadoPredictivo" element="ns0:marcadoPredictivo" location="../xsd/marcadoPredictivoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:getInteractionRequest" location="../../../BusinessServices/ASPECT/wsdl/uadIntegration.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/marcadoPredictivoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/uadIntegration";
declare namespace xf = "http://tempuri.org/Middleware/v2/ProxyServices/getInteractionRGIn/";

declare function xf:getInteractionRGIn($marcadoPredictivo as element(ns0:marcadoPredictivo))
    as element(ns1:getInteractionRequest) {
        <ns1:getInteractionRequest>
            <customeId>{ data($marcadoPredictivo/CUSTOMER_ID) }</customeId>
            <requestData>
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[1]
                    return
                        <UserDefined1>{ data($DATA) }</UserDefined1>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[2]
                    return
                        <UserDefined2>{ data($DATA) }</UserDefined2>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[3]
                    return
                        <UserDefined3>{ data($DATA) }</UserDefined3>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[4]
                    return
                        <UserDefined4>{ data($DATA) }</UserDefined4>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[5]
                    return
                        <UserDefined5>{ data($DATA) }</UserDefined5>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[6]
                    return
                        <UserDefined6>{ data($DATA) }</UserDefined6>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[7]
                    return
                        <UserDefined7>{ data($DATA) }</UserDefined7>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[8]
                    return
                        <UserDefined8>{ data($DATA) }</UserDefined8>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[9]
                    return
                        <UserDefined9>{ data($DATA) }</UserDefined9>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[10]
                    return
                        <UserDefined10>{ data($DATA) }</UserDefined10>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[11]
                    return
                        <UserDefined11>{ data($DATA) }</UserDefined11>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[12]
                    return
                        <UserDefined12>{ data($DATA) }</UserDefined12>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[13]
                    return
                        <UserDefined13>{ data($DATA) }</UserDefined13>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[14]
                    return
                        <UserDefined14>{ data($DATA) }</UserDefined14>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[15]
                    return
                        <UserDefined15>{ data($DATA) }</UserDefined15>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[16]
                    return
                        <UserDefined16>{ data($DATA) }</UserDefined16>
                return
                    $result[1]
            } 
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[17]
                    return
                        <UserDefined17>{ data($DATA) }</UserDefined17>
                return
                    $result[1]
            } 
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[18]
                    return
                        <UserDefined18>{ data($DATA) }</UserDefined18>
                return
                    $result[1]
            } 
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[19]
                    return
                        <UserDefined19>{ data($DATA) }</UserDefined19>
                return
                    $result[1]
            } 
            {
                let $result :=
                    for $DATA in $marcadoPredictivo/ADDITIONAL_INFO/DATA[20]
                    return
                        <UserDefined20>{ data($DATA) }</UserDefined20>
                return
                    $result[1]
            }                                                                                                             
                <DispositionCode>{ data($marcadoPredictivo/DISPOSITION_CODE) }</DispositionCode>
                {
                    for $DATE_TIME_SCHEDULE in $marcadoPredictivo/DATE_TIME_SCHEDULE
                    return
                        <DateTimeSchedule>{ data($DATE_TIME_SCHEDULE) }</DateTimeSchedule>
                }
                {
                    for $PHONE_SCHEDULE in $marcadoPredictivo/PHONE_SCHEDULE
                    return
                        <PhoneSchedule>{ data($PHONE_SCHEDULE) }</PhoneSchedule>
                }
                {
                    for $MEMO_SCHEDULE in $marcadoPredictivo/MEMO_SCHEDULE
                    return
                        <MemoSchedule>{ data($MEMO_SCHEDULE) }</MemoSchedule>
                }
                {
                    for $SAME_AGENT_SCHEDULE in $marcadoPredictivo/SAME_AGENT_SCHEDULE
                    return
                        <SameAgentSchedule>{ data($SAME_AGENT_SCHEDULE) }</SameAgentSchedule>
                }
                {
                    for $SNOOZE_TIME_SCHEDULE in $marcadoPredictivo/SNOOZE_TIME_SCHEDULE
                    return
                        <SnoozeTimeSchedule>{ data($SNOOZE_TIME_SCHEDULE) }</SnoozeTimeSchedule>
                }
                {
                    for $SERVICE_ID_SCHEDULE in $marcadoPredictivo/SERVICE_ID_SCHEDULE
                    return
                        <ServiceIdSchedule>{ data($SERVICE_ID_SCHEDULE) }</ServiceIdSchedule>
                }
            </requestData>
        </ns1:getInteractionRequest>
};

declare variable $marcadoPredictivo as element(ns0:marcadoPredictivo) external;

xf:getInteractionRGIn($marcadoPredictivo)
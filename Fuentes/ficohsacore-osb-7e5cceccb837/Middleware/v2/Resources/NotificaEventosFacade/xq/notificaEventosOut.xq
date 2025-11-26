(:: pragma bea:global-element-parameter parameter="$notificaEventosT24Response" element="ns0:notificaEventosT24Response" location="../../NotificaEventosT24/xsd/notificaEventosT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:notificaEventosFacadeResponse" location="../xsd/notificaEventosFacadeTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEventosT24Types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/notificaEventosFacadeTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaEventosFacade/xq/notificaEventosOut/";

declare function xf:notificaEventosOut($notificaEventosT24Response as element(ns0:notificaEventosT24Response))
    as element(ns1:notificaEventosFacadeResponse) {
        <ns1:notificaEventosFacadeResponse>
            {
                for $EVENTS in $notificaEventosT24Response/EVENTS
                return
                    <EVENTS>
                        {
                            for $EVENT in $EVENTS/EVENT
                            return
                                <EVENT>
                                    {
                                        for $FIELDS in $EVENT/FIELDS
                                        return
                                            <FIELDS>
                                                {
                                                    for $FIELD in $FIELDS/FIELD[1]
                                                    return
                                                        <FIELD>
                                                            {
                                                                for $TYPE_NAME in $FIELD/TYPE_NAME
                                                                return
                                                                	if( data($TYPE_NAME)="TRAMA")then(
                    													<TYPE_NAME>ID_TRANSACCION</TYPE_NAME>
            														)else(
            															<TYPE_NAME>{ data($TYPE_NAME) }</TYPE_NAME>
            														)     			 
                                                            }
                                                            {
                                                                for $TYPE_VALUE in $FIELD/TYPE_VALUE
                                                                return
                                                                	if( data($FIELD/TYPE_NAME)="TRAMA")then(
                    													<TYPE_VALUE>{ fn:tokenize(data($TYPE_VALUE),"\|")[2] }</TYPE_VALUE>
            														)else(
            															<TYPE_VALUE>{ data($TYPE_VALUE) }</TYPE_VALUE>
            														)  
                                                            }
                                                        </FIELD>
                                                }
                                            </FIELDS>
                                    }
                                    {
                                        for $SUCCESS_INDICATOR in $EVENT/SUCCESS_INDICATOR
                                        return
                                            <SUCCESS_INDICATOR>{ data($SUCCESS_INDICATOR) }</SUCCESS_INDICATOR>
                                    }
                                    {
                                        for $ERROR_MESSAGE in $EVENT/ERROR_MESSAGE
                                        return
                                            <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                                    }
                                </EVENT>
                        }
                    </EVENTS>
            }
        </ns1:notificaEventosFacadeResponse>
};

declare variable $notificaEventosT24Response as element(ns0:notificaEventosT24Response) external;

xf:notificaEventosOut($notificaEventosT24Response)
(:: pragma bea:global-element-parameter parameter="$consultadeFicoAlertasResponse" element="ns0:ConsultadeFicoAlertasResponse" location="../Resources/XMLSchema_1876963756.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFicoAlertasResponse" location="consultaFicoAlertasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFicoAlertasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/ConsultaFicoAlertas/consultaFicoAlertasOut/";

declare function xf:consultaFicoAlertasOut($consultadeFicoAlertasResponse as element(ns0:ConsultadeFicoAlertasResponse))
    as element(ns1:consultaFicoAlertasResponse) {
        <ns1:consultaFicoAlertasResponse>
            {
                for $gWSALERTLISTDetailType in $consultadeFicoAlertasResponse/WSALERTLISTType[1]/gWSALERTLISTDetailType
                return
                    <ns1:consultaFicoAlertasResponseType>
                        {
                            for $mWSALERTLISTDetailType in $gWSALERTLISTDetailType/mWSALERTLISTDetailType
                            return
                                <ns1:consultaFicoAlertasResponseRecordType>
                                    {
                                        for $ID in $mWSALERTLISTDetailType/ID
                                        return
                                            <ALERT_ID>{ data($ID) }</ALERT_ID>
                                    }
                                    {
                                        for $DESCRIPTION in $mWSALERTLISTDetailType/DESCRIPTION
                                        return
                                            <DESCRIPTION>{ data($DESCRIPTION) }</DESCRIPTION>
                                    }
                                    {
                                        for $ALERTCLASS in $mWSALERTLISTDetailType/ALERTCLASS
                                        return
                                            <ALERT_CLASS>{ data($ALERTCLASS) }</ALERT_CLASS>
                                    }
                                    {
                                        for $EVENTTYPE in $mWSALERTLISTDetailType/EVENTTYPE
                                        return
                                            <EVENT_TYPE>{ data($EVENTTYPE) }</EVENT_TYPE>
                                    }
                                </ns1:consultaFicoAlertasResponseRecordType>
                        }
                    </ns1:consultaFicoAlertasResponseType>
            }
        </ns1:consultaFicoAlertasResponse>
};

declare variable $consultadeFicoAlertasResponse as element(ns0:ConsultadeFicoAlertasResponse) external;

xf:consultaFicoAlertasOut($consultadeFicoAlertasResponse)
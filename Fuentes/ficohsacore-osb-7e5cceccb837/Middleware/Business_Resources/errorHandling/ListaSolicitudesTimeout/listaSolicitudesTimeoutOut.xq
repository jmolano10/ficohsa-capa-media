(:: pragma bea:global-element-parameter parameter="$listadesolicitudescontimeoutResponse" element="ns0:ListadesolicitudescontimeoutResponse" location="../Resources/XMLSchema_1080088451.xsd" ::)
(:: pragma bea:global-element-return element="ns1:listaSolicitudesTimeoutResponse" location="listaSolicitudesTimeoutTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/listaSolicitudesTimeoutTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/errorHandling/ListaSolicitudesTimeout/listaSolicitudesTimeoutOut/";

declare function xf:listaSolicitudesTimeoutOut($listadesolicitudescontimeoutResponse as element(ns0:ListadesolicitudescontimeoutResponse))
    as element(ns1:listaSolicitudesTimeoutResponse) {
        <ns1:listaSolicitudesTimeoutResponse>
            {
                for $gWSFICOEERRORHANDLEDetailType in $listadesolicitudescontimeoutResponse/WSFICOEERRORHANDLEType[1]/gWSFICOEERRORHANDLEDetailType
                return
                    <ns1:listaSolicitudesTimeoutResponseType>
                        {
                            for $mWSFICOEERRORHANDLEDetailType in $gWSFICOEERRORHANDLEDetailType/mWSFICOEERRORHANDLEDetailType
                            return
                                <ns1:listaSolicitudesTimeoutResponseRecordType>
                                    {
                                        for $ID in $mWSFICOEERRORHANDLEDetailType/ID
                                        return
                                            <REQUEST_ID>{ data($ID) }</REQUEST_ID>
                                    }
                                    {
                                        for $STATUS in $mWSFICOEERRORHANDLEDetailType/STATUS
                                        return
                                            <STATUS>{ data($STATUS) }</STATUS>
                                    }
                                    {
                                        for $VERSION in $mWSFICOEERRORHANDLEDetailType/VERSION
                                        return
                                            <TRANSACTION_TYPE>{ data($VERSION) }</TRANSACTION_TYPE>
                                    }
                                    {
                                        for $MSGOUT in $mWSFICOEERRORHANDLEDetailType/MSGOUT
                                        return
                                            <MSGOUT>{ data($MSGOUT) }</MSGOUT>
                                    }
                                </ns1:listaSolicitudesTimeoutResponseRecordType>
                        }
                    </ns1:listaSolicitudesTimeoutResponseType>
            }
        </ns1:listaSolicitudesTimeoutResponse>
};

declare variable $listadesolicitudescontimeoutResponse as element(ns0:ListadesolicitudescontimeoutResponse) external;

xf:listaSolicitudesTimeoutOut($listadesolicitudescontimeoutResponse)
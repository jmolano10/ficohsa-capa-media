(:: pragma bea:global-element-parameter parameter="$consultasuborigendefondosResponse1" element="ns0:ConsultasuborigendefondosResponse" location="../resources/XMLSchema_-253522267.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/origenFondos/consultaSubOrigenFondos/consultaSubOrigenHeaderOutZero/";

declare function xf:consultaSubOrigenHeaderOutZero($consultasuborigendefondosResponse1 as element(ns0:ConsultasuborigendefondosResponse))
    as element(ns1:ResponseHeader) {
        let $ConsultasuborigendefondosResponse := $consultasuborigendefondosResponse1
        return
            <ns1:ResponseHeader>
                {
                    for $transactionId in $ConsultasuborigendefondosResponse/Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
                {
                    for $messageId in $ConsultasuborigendefondosResponse/Status/messageId
                    return
                        <messageId>{ data($messageId) }</messageId>
                }
                <successIndicator>NO RECORDS</successIndicator>
                {
                    for $application in $ConsultasuborigendefondosResponse/Status/application
                    return
                        <application>{ data($application) }</application>
                }
                {
                    for $ZERORECORDS in $ConsultasuborigendefondosResponse/WSFUNDSSUBORIGINLISTType[1]/ZERORECORDS
                    return
                        <messages>{ data($ZERORECORDS) }</messages>
                }
            </ns1:ResponseHeader>
};

declare variable $consultasuborigendefondosResponse1 as element(ns0:ConsultasuborigendefondosResponse) external;

xf:consultaSubOrigenHeaderOutZero($consultasuborigendefondosResponse1)
(:: pragma bea:global-element-parameter parameter="$consultadeorigendefondosResponse1" element="ns0:ConsultadeorigendefondosResponse" location="../resources/XMLSchema_-253522267.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/origenFondos/consultaOrigenFondos/consultaOrigenFondosHeaderOutZero/";

declare function xf:consultaOrigenFondosHeaderOutZero($consultadeorigendefondosResponse1 as element(ns0:ConsultadeorigendefondosResponse))
    as element(ns1:ResponseHeader) {
        let $ConsultadeorigendefondosResponse := $consultadeorigendefondosResponse1
        return
            <ns1:ResponseHeader>
                {
                    for $transactionId in $ConsultadeorigendefondosResponse/Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
                {
                    for $messageId in $ConsultadeorigendefondosResponse/Status/messageId
                    return
                        <messageId>{ data($messageId) }</messageId>
                }
                <successIndicator>NO RECORDS</successIndicator>
                {
                    for $application in $ConsultadeorigendefondosResponse/Status/application
                    return
                        <application>{ data($application) }</application>
                }
                {
                    for $ZERORECORDS in $ConsultadeorigendefondosResponse/WSFUNDSORIGINLISTType[1]/ZERORECORDS
                    return
                        <messages>{ data($ZERORECORDS) }</messages>
                }
            </ns1:ResponseHeader>
};

declare variable $consultadeorigendefondosResponse1 as element(ns0:ConsultadeorigendefondosResponse) external;

xf:consultaOrigenFondosHeaderOutZero($consultadeorigendefondosResponse1)
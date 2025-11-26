(:: pragma bea:global-element-parameter parameter="$consultadepaisesResponse1" element="ns0:ConsultadepaisesResponse" location="../Resources/XMLSchema_1123420404.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaPaises/consultaPaisesHeaderOut2/";

declare function xf:consultaPaisesHeaderOut2($consultadepaisesResponse1 as element(ns0:ConsultadepaisesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadepaisesResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $messageId in $consultadepaisesResponse1/Status/messageId
                return
                    <messageId>{ data($messageId) }</messageId>
            }
            <successIndicator>NO RECORDS</successIndicator>
            {
                for $application in $consultadepaisesResponse1/Status/application
                return
                    <application>{ data($application) }</application>
            }
            {
                for $ZERORECORDS in $consultadepaisesResponse1/WSCOUNTRYLISTType[1]/ZERORECORDS
                return
                    <messages>{ data($ZERORECORDS) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadepaisesResponse1 as element(ns0:ConsultadepaisesResponse) external;

xf:consultaPaisesHeaderOut2($consultadepaisesResponse1)
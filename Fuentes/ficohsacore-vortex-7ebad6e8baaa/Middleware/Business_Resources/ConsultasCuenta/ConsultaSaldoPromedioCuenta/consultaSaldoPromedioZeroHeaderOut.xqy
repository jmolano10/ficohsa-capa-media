xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultasaldopromcuentaResponse1" element="ns0:ConsultasaldopromcuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaSaldoPromedioCuenta/consultaSaldoPromedioZeroHeader/";

declare function xf:consultaSaldoPromedioZeroHeader($consultasaldopromcuentaResponse1 as element(ns0:ConsultasaldopromcuentaResponse))
    as element(ns1:ResponseHeader) {
        let $Status := $consultasaldopromcuentaResponse1/Status
        return
            <ns1:ResponseHeader>
                {
                    for $transactionId in $Status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
                {
                    for $messageId in $Status/messageId
                    return
                        <messageId>{ data($messageId) }</messageId>
                }
                <successIndicator>NO RECORDS</successIndicator>
                {
                    for $application in $Status/application
                    return
                        <application>{ data($application) }</application>
                }
                {
                    for $ZERONORECORDS in $consultasaldopromcuentaResponse1/WSACCTAVERAGEBALType[1]/ZERONORECORDS
                    return
                        <messages>{ data($ZERONORECORDS) }</messages>
                }
            </ns1:ResponseHeader>
};

declare variable $consultasaldopromcuentaResponse1 as element(ns0:ConsultasaldopromcuentaResponse) external;

xf:consultaSaldoPromedioZeroHeader($consultasaldopromcuentaResponse1)
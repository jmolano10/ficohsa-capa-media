(:: pragma bea:global-element-parameter parameter="$consultadebancoslocalesResponse1" element="ns0:ConsultadebancoslocalesResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaBancosLocales/consultaBancosLocalesZeroHeaderOut/";

declare function xf:consultaBancosLocalesZeroHeaderOut($consultadebancoslocalesResponse1 as element(ns0:ConsultadebancoslocalesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadebancoslocalesResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            <successIndicator>NO RECORDS</successIndicator>
            {
                for $ZERORECORDS in $consultadebancoslocalesResponse1/WSLOCALBANKSType[1]/ZERORECORDS
                return
                    <messages>{ data($ZERORECORDS) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadebancoslocalesResponse1 as element(ns0:ConsultadebancoslocalesResponse) external;

xf:consultaBancosLocalesZeroHeaderOut($consultadebancoslocalesResponse1)
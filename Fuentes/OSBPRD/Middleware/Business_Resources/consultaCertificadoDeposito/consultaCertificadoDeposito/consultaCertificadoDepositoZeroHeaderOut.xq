(:: pragma bea:global-element-parameter parameter="$consultadecertifdepositoResponse1" element="ns0:ConsultadecertifdepositoResponse" location="../Resources/XMLSchema_1178015080.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCertificadoDeposito/consultaCertificadoDeposito/consultaCertificadoDepositoZeroHeaderOut/";

declare function xf:consultaCertificadoDepositoZeroHeaderOut($consultadecertifdepositoResponse1 as element(ns0:ConsultadecertifdepositoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadecertifdepositoResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            <successIndicator>NO RECORDS</successIndicator>
            {
                for $ZERORECORDS in $consultadecertifdepositoResponse1/WSAZACCOUNTDEPType[1]/ZERORECORDS
                return
                    <messages>{ data($ZERORECORDS) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadecertifdepositoResponse1 as element(ns0:ConsultadecertifdepositoResponse) external;

xf:consultaCertificadoDepositoZeroHeaderOut($consultadecertifdepositoResponse1)
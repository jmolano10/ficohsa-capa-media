xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaDetallesCuenta/consultaDetallesCuentaZeroHeaderOut/";

declare function xf:consultaDetallesCuentaZeroHeaderOut($consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadedetallesdelacuentaResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            <successIndicator>NO RECORDS</successIndicator>
            {
                for $ZERORECORDS in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/ZERORECORDS
                return
                    <messages>{ data($ZERORECORDS) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:consultaDetallesCuentaZeroHeaderOut($consultadedetallesdelacuentaResponse1)
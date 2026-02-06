xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadeclienteResponse1" element="ns0:ConsultadeclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaCliente/consultaClienteHeaderOut/";

declare function xf:consultaClienteHeaderOut($consultadeclienteResponse1 as element(ns0:ConsultadeclienteResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $consultadeclienteResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            <successIndicator>NO RECORDS</successIndicator>
            {
                for $ZERORECORDS in $consultadeclienteResponse1/WSCUSTOMERType[1]/ZERORECORDS
                return
                    <messages>{ data($ZERORECORDS) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadeclienteResponse1 as element(ns0:ConsultadeclienteResponse) external;

xf:consultaClienteHeaderOut($consultadeclienteResponse1)
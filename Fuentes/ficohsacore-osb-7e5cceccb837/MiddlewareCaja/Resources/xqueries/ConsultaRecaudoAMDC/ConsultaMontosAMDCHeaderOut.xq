(:: pragma bea:global-element-parameter parameter="$consultadedetrecaudoamdcmontosResponse" element="ns0:ConsultadedetrecaudoamdcmontosResponse" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAMDC/ConsultaMontosAMDCHeaderOut/";

declare function xf:ConsultaMontosAMDCHeaderOut($consultadedetrecaudoamdcmontosResponse as element(ns0:ConsultadedetrecaudoamdcmontosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultadedetrecaudoamdcmontosResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadedetrecaudoamdcmontosResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadedetrecaudoamdcmontosResponse as element(ns0:ConsultadedetrecaudoamdcmontosResponse) external;

xf:ConsultaMontosAMDCHeaderOut($consultadedetrecaudoamdcmontosResponse)
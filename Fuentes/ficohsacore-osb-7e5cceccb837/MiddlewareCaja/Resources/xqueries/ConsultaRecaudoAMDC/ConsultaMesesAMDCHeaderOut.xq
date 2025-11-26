(:: pragma bea:global-element-parameter parameter="$consultadedetrecaudoamdcmesesResponse" element="ns0:ConsultadedetrecaudoamdcmesesResponse" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoAMDC/ConsultaMesesAMDCHeaderOut/";

declare function xf:ConsultaMesesAMDCHeaderOut($consultadedetrecaudoamdcmesesResponse as element(ns0:ConsultadedetrecaudoamdcmesesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultadedetrecaudoamdcmesesResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadedetrecaudoamdcmesesResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadedetrecaudoamdcmesesResponse as element(ns0:ConsultadedetrecaudoamdcmesesResponse) external;

xf:ConsultaMesesAMDCHeaderOut($consultadedetrecaudoamdcmesesResponse)
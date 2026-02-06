xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTransaccionACH1" element="ns0:consultaTransaccionACH" location="../xsd/consultaTransaccionACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:GetStatusReportHNL" location="../../../BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638.xsd" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/GetStatusReportHNLIn/";

declare function xf:GetStatusReportHNLIn($consultaTransaccionACH1 as element(ns0:consultaTransaccionACH))
    as element(ns1:GetStatusReportHNL) {
        <ns1:GetStatusReportHNL>
            <ns1:SearchCriteria>{ data($consultaTransaccionACH1/SEARCH_CRITERIA) }</ns1:SearchCriteria>
            <ns1:SearchValue>{ data($consultaTransaccionACH1/SEARCH_VALUE) }</ns1:SearchValue>
        </ns1:GetStatusReportHNL>
};

declare variable $consultaTransaccionACH1 as element(ns0:consultaTransaccionACH) external;

xf:GetStatusReportHNLIn($consultaTransaccionACH1)
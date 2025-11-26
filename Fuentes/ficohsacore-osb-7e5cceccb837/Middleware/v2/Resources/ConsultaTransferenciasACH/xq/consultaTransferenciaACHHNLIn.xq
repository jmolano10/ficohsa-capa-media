(:: pragma bea:global-element-parameter parameter="$consultaTransferenciasACH" element="ns0:consultaTransferenciasACH" location="../xsd/consultaTransferenciasACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:GetStatusReportHNL" location="../../../BusinessServices/PYST/envioTransfACH/xsd/XMLSchema_-1986733638.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTransferenciasACHTypes";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransferenciasACH/xq/consultaTransferenciaACHHNLIn/";

declare function xf:consultaTransferenciaACHHNLIn($consultaTransferenciasACH as element(ns0:consultaTransferenciasACH))
    as element(ns1:GetStatusReportHNL) {
        <ns1:GetStatusReportHNL>
            <ns1:SearchCriteria>{ data($consultaTransferenciasACH/SEARCH_CRITERIA) }</ns1:SearchCriteria>
            <ns1:SearchValue>{ data($consultaTransferenciasACH/SEARCH_VALUE) }</ns1:SearchValue>
        </ns1:GetStatusReportHNL>
};

declare variable $consultaTransferenciasACH as element(ns0:consultaTransferenciasACH) external;

xf:consultaTransferenciaACHHNLIn($consultaTransferenciasACH)
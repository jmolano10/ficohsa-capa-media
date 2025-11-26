(:: pragma bea:global-element-parameter parameter="$consultadechequedegerenciaFCYResponse1" element="ns0:ConsultadechequedegerenciaFCYResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaEstadoChequeGerencia/consultaChequeGerenciaFcyHeaderOut/";

declare function xf:consultaChequeGerenciaFcyHeaderOut($consultadechequedegerenciaFCYResponse1 as element(ns0:ConsultadechequedegerenciaFCYResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                if (fn:string($consultadechequedegerenciaFCYResponse1/Status/successIndicator/text()) = "Success" and
                	fn:string($consultadechequedegerenciaFCYResponse1/FICOHNFCYDRAFTDETAILSWSType[1]/ZERORECORDS/text()) != "") then (
                    <successIndicator>NORECORDS</successIndicator>,
                    <messages>ZERO RECORDS RETURNED</messages>
                ) else (
                	<successIndicator>{ fn:string($consultadechequedegerenciaFCYResponse1/Status/successIndicator/text()) }</successIndicator>,
                    <messages>{ fn:string($consultadechequedegerenciaFCYResponse1/Status/messages/text()) }</messages>
                )
            }
        </ns1:ResponseHeader>
};

declare variable $consultadechequedegerenciaFCYResponse1 as element(ns0:ConsultadechequedegerenciaFCYResponse) external;

xf:consultaChequeGerenciaFcyHeaderOut($consultadechequedegerenciaFCYResponse1)
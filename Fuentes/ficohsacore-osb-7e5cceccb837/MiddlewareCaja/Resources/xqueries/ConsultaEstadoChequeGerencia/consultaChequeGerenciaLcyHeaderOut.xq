(:: pragma bea:global-element-parameter parameter="$consultadechequedegerenciaResponse1" element="ns0:ConsultadechequedegerenciaResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaEstadoChequeGerencia/consultaChequeGerenciaLcyHeaderOut/";

declare function xf:consultaChequeGerenciaLcyHeaderOut($consultadechequedegerenciaResponse1 as element(ns0:ConsultadechequedegerenciaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                if (fn:string($consultadechequedegerenciaResponse1/Status/successIndicator/text()) = "Success" and
                	fn:string($consultadechequedegerenciaResponse1/WSFICOECASHIERCHEQUEDETAILSType[1]/ZERORECORDS/text()) != "") then (
                    <successIndicator>NORECORDS</successIndicator>,
                    <messages>ZERO RECORDS RETURNED</messages>
                ) else (
                	<successIndicator>{ fn:string($consultadechequedegerenciaResponse1/Status/successIndicator/text()) }</successIndicator>,
                    <messages>{ fn:string($consultadechequedegerenciaResponse1/Status/messages/text()) }</messages>
                )
            }
        </ns1:ResponseHeader>
};

declare variable $consultadechequedegerenciaResponse1 as element(ns0:ConsultadechequedegerenciaResponse) external;

xf:consultaChequeGerenciaLcyHeaderOut($consultadechequedegerenciaResponse1)
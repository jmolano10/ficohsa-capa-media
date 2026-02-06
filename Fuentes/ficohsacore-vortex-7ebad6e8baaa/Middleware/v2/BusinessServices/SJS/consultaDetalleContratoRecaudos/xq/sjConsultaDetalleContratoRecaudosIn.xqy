xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaDetalleContratoRecaudos" element="ns1:sjConsultaDetalleContratoRecaudos" location="../xsd/sjConsultaDetalleContratoRecaudosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadetallecontratorecaudo" location="../../../../../Business_Resources/contratosConvenios/Resources/XMLSchema_266061745.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaDetalleContratoRecaudosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaDetalleContratoRecaudos/xq/sjConsultaDetalleContratoRecaudosIn/";

declare function xf:sjConsultaDetalleContratoRecaudosIn($sjConsultaDetalleContratoRecaudos as element(ns1:sjConsultaDetalleContratoRecaudos))
    as element(ns0:Consultadetallecontratorecaudo) {
        <ns0:Consultadetallecontratorecaudo>
            <WebRequestCommon>
                <userName>{ data($sjConsultaDetalleContratoRecaudos/USERNAME) }</userName>
                <password>{ data($sjConsultaDetalleContratoRecaudos/PASSWORD) }</password>
            </WebRequestCommon>
            <WSCOLLECTIONCONDSType>
                {
                    let $CONTRACT_ID  := (fn:string($sjConsultaDetalleContratoRecaudos/CONTRACT_ID/text()))  
                    return
                        if ($CONTRACT_ID != "") then (
                        	<enquiryInputCollection>
                            	<columnName>@ID</columnName>
                            	<criteriaValue>{ $CONTRACT_ID }</criteriaValue>
                            	<operand>EQ</operand>
                            </enquiryInputCollection>
                        ) else ()
                }
</WSCOLLECTIONCONDSType>
        </ns0:Consultadetallecontratorecaudo>
};

declare variable $sjConsultaDetalleContratoRecaudos as element(ns1:sjConsultaDetalleContratoRecaudos) external;

xf:sjConsultaDetalleContratoRecaudosIn($sjConsultaDetalleContratoRecaudos)
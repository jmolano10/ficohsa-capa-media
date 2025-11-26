(:: pragma bea:global-element-parameter parameter="$responseHeader1" element="ns2:ResponseHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDetalleContratoRecaudosResponse1" element="ns0:consultaDetalleContratoRecaudosResponse" location="../../../../Resources/ConsultaDetalleContratoRecaudos/xsd/consultaDetalleContratoRecaudosTypes.xsd" ::)
(:: pragma bea:schema-type-return type="ns1:agreementsResponseType" location="../../../../Resources/ConsultaRecaudoMultiple/xsd/consultaRecaudoMultipleTypes.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRecaudoMultiple/xq/consDetContratoOut/";

declare function xf:consDetContratoOut($responseHeader1 as element(ns2:ResponseHeader),
    $consultaDetalleContratoRecaudosResponse1 as element(ns0:consultaDetalleContratoRecaudosResponse),
    $agreementId as xs:string)
    as element() {
        <ns1:agreementsResponseType>
            <AGREEMENT>
            	<SUCCESS_INDICATOR>{ fn:string($responseHeader1/successIndicator/text()) }</SUCCESS_INDICATOR>
            	<ID>{ fn:number($agreementId) }</ID>
                <NAME>
                { 
                	if (fn:string($responseHeader1/successIndicator/text()) = "Success") then (
                		data($consultaDetalleContratoRecaudosResponse1/ns0:consultaDetalleContratoRecaudosResponseType/ns0:consultaDetalleContratoRecaudosResponseRecordType[1]/CONTRACT_NAME)
                	) else (
                		"CONTRATO NO EXISTE" 
                	)
                }
                </NAME>
                <DEBTORS/>
            </AGREEMENT>
        </ns1:agreementsResponseType>
};

declare variable $responseHeader1 as element(ns2:ResponseHeader) external;
declare variable $consultaDetalleContratoRecaudosResponse1 as element(ns0:consultaDetalleContratoRecaudosResponse) external;
declare variable $agreementId as xs:string external;

xf:consDetContratoOut($responseHeader1,
    $consultaDetalleContratoRecaudosResponse1,
    $agreementId)
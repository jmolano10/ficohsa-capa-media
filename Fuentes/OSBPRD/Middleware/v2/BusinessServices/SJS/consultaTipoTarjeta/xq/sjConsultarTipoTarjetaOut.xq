(:: pragma bea:global-element-parameter parameter="$consultadebinesTDResponse1" element="ns1:ConsultadebinesTDResponse" location="../../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../ABK/consultarBinesTC/xsd/consultarBinesTC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:sjConsultaTipoTarjetaResponse" location="../xsd/sjConsultaTipoTarjeta.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaTipoTarjeta";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarBines";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTipoTarjeta/xq/sjConsultarTipoTarjetaOut/";

declare function xf:sjConsultarTipoTarjetaOut($consultadebinesTDResponse1 as element(ns1:ConsultadebinesTDResponse),
    $outputParameters1 as element(ns0:OutputParameters))
    as element(ns2:sjConsultaTipoTarjetaResponse) {
        <ns2:sjConsultaTipoTarjetaResponse>
            {
                let $successIndTD := fn:upper-case(fn:string($consultadebinesTDResponse1/Status/successIndicator/text()))
                let $successIndTC := fn:string($outputParameters1/ns0:PV_SUCCESSINDICATOR/text())
                return
                if ($successIndTD = "SUCCESS" and
                	fn:string($consultadebinesTDResponse1/WSCARDTYPEType/ZERORECORDS/text()) = "") then (
                	<ns2:SUCCESS_INDICATOR>SUCCESS</ns2:SUCCESS_INDICATOR>,
                	<ns2:BIN_NUMBER>{ fn:string($consultadebinesTDResponse1/WSCARDTYPEType[1]/gWSCARDTYPEDetailType[1]/mWSCARDTYPEDetailType[1]/BINNUMBER/text()) }</ns2:BIN_NUMBER>,
                	<ns2:BIN_DESCRIPTION>{ fn:string($consultadebinesTDResponse1/WSCARDTYPEType[1]/gWSCARDTYPEDetailType[1]/mWSCARDTYPEDetailType[1]/BINDESCRIPTION/text()) }</ns2:BIN_DESCRIPTION>,
                	<ns2:CARD_TYPE>DEBIT</ns2:CARD_TYPE>
				) else if ( $successIndTC = "SUCCESS") then (
					<ns2:SUCCESS_INDICATOR>SUCCESS</ns2:SUCCESS_INDICATOR>,
                	<ns2:BIN_NUMBER>{ fn:string($outputParameters1/ns0:PV_BIN_NUMBER/ns0:PV_BIN_NUMBER_ITEM[1]/text()) }</ns2:BIN_NUMBER>,
                	<ns2:BIN_DESCRIPTION>{ fn:string($outputParameters1/ns0:PV_DESCRIPCION/ns0:PV_DESCRIPCION_ITEM[1]/text()) }</ns2:BIN_DESCRIPTION>,
                	<ns2:CARD_TYPE>CREDIT</ns2:CARD_TYPE>
				) else (
					<ns2:SUCCESS_INDICATOR>ERROR</ns2:SUCCESS_INDICATOR>,
					<ns2:ERROR_MESSAGE>INVALID BIN</ns2:ERROR_MESSAGE>
				)
            }
        </ns2:sjConsultaTipoTarjetaResponse>
};

declare variable $consultadebinesTDResponse1 as element(ns1:ConsultadebinesTDResponse) external;
declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:sjConsultarTipoTarjetaOut($consultadebinesTDResponse1,
    $outputParameters1)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../../v3/BusinessServices/MDW/obtenerInformacionConvenio/xsd/ObtenerInfomacionConvenio_sp.xsd" ::)
(:: pragma bea:schema-type-return type="ns0:agreementsResponseType" location="../../../../Resources/ConsultaRecaudoMultiple/xsd/consultaRecaudoMultipleTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerInfomacionConvenio";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRecaudoMultipleGT/xq/sjConsDetContratoGTOut/";

declare function xf:sjConsDetContratoGTOut($outputParameters as element(ns1:OutputParameters),
    $aggreId as xs:string)
    as element() {
        <ns0:agreementsResponseType>
            <AGREEMENT>
                <SUCCESS_INDICATOR>{ 
                	if(upper-case(data($outputParameters/ns1:PV_ERRORCODE/text())) = "SUCCESS") then
                		 ("Success")
                    else ("ERROR") 
                }</SUCCESS_INDICATOR>
                <ID>{ data($aggreId) }</ID>
                <NAME>  
                { 
                	if (upper-case(data($outputParameters/ns1:PV_ERRORCODE)) = "SUCCESS") then (
                		data($outputParameters/ns1:PV_NOMBRECONVENIO)
                	) else (
                		"CONTRATO NO EXISTE" 
                	)
                }
                </NAME>
                <DEBTORS/>
            </AGREEMENT>
        </ns0:agreementsResponseType>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $aggreId as xs:string external;

xf:sjConsDetContratoGTOut($outputParameters,
    $aggreId)
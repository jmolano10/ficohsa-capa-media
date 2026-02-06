xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/CatalogosInfoPrestamo/ConsultaGruposTasa/xsd/ConsultaGruposTasa_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaGruposTasaResponse" location="../../CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaGruposTasa";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGruposTasa/xq/consultaGruposTasaHNOut/";

declare function xf:consultaGruposTasaHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaGruposTasaResponse) {
        <ns0:consultaGruposTasaResponse>
            	{
            		let $CODE := $outputParameters/ns1:P_CODE_RATE/ns1:P_MAJOR_VALUE_ITEM
            		let $DESCRIPTION := $outputParameters/ns1:P_DESCRIPTION/ns1:P_DESCRIPTION_ITEM
            		let $VALID_DATE := $outputParameters/ns1:P_VALID_DATE/ns1:P_VALID_DATE_ITEM
            		let $MINOR_VALUE := $outputParameters/ns1:P_MINOR_VALUE/ns1:P_MAJOR_VALUE_ITEM
            		let $MAJOR_VALUE := $outputParameters/ns1:P_MAJOR_VALUE/ns1:P_MAJOR_VALUE_ITEM
            		let $LAST_VALUE := $outputParameters/ns1:P_LAST_VALUE/ns1:P_MAJOR_VALUE_ITEM
            		let $count := count($CODE)
            		return
            		if($count > 0) then (
            			<RATE_GROUPS>
            				{
            					for $index in(1 to $count)
            					return(
            						<RATE_GROUP>
            							<CODE>{ data($CODE[$index]) }</CODE>
            							<DESCRIPTION>{ data($DESCRIPTION[$index]) }</DESCRIPTION>
            							<VALID_DATE>{ fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", data($VALID_DATE[$index])) }</VALID_DATE>
            							<MINOR_VALUE>{ data($MINOR_VALUE[$index]) }</MINOR_VALUE>
            							<MAJOR_VALUE>{ data($MAJOR_VALUE[$index]) }</MAJOR_VALUE>
            							<LAST_VALUE>{ data($LAST_VALUE[$index]) }</LAST_VALUE>
            						</RATE_GROUP>
            					)
            				}
            			</RATE_GROUPS>
            		) else ()
            	}
        </ns0:consultaGruposTasaResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaGruposTasaHNOut($outputParameters)
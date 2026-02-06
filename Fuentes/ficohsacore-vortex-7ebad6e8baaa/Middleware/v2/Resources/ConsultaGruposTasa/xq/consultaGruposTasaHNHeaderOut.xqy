xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/CatalogosInfoPrestamo/ConsultaGruposTasa/xsd/ConsultaGruposTasa_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaGruposTasa";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaGruposTasa/xq/consultaGruposTasaHNHeaderOut/";

declare function xf:consultaGruposTasaHNHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        {
        	let $errorcode := $outputParameters/ns1:P_SUCCESSINDICATOR/text()
            let $validationMessage := $outputParameters/ns1:P_MESSAGES/text()
            return
            	if($errorcode != 'SUCCESS' ) then(
            		<successIndicator>{ $errorcode }</successIndicator>,
            		<messages>{ $validationMessage }</messages>
            	)else(
            	<successIndicator>Success</successIndicator>
            	)
            
         }   
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaGruposTasaHNHeaderOut($outputParameters)
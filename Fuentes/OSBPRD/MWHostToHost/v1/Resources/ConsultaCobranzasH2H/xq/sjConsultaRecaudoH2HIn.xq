(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../EsquemasGenerales/headerElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCobranzas" element="ns2:consultaCobranzas" location="../../CobranzasH2H/xsd/cobranzasH2HTypes.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$PT_INFOCONVENIOS" type="ns3:OutputParameters/ns3:PT_INFOCONVENIOS" location="../../../BusinessServices/INTFC/consultaConveniosH2H/xsd/consultaConveniosH2H_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:sjConsultaCobranzas" location="../../../BusinessServices/SJS/consultaCobranzasH2H/xsd/sjConsultaCobranzasH2H.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjCobranzasH2HTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/cobranzasH2HTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaCobranzasH2H/xq/sjConsultaRecaudoH2HIn/";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConveniosH2H";

declare function xf:sjConsultaRecaudoH2HIn($requestHeader as element(ns1:RequestHeader),
    $consultaCobranzas as element(ns2:consultaCobranzas),
    $PT_INFOCONVENIOS as element())
    as element(ns0:sjConsultaCobranzas) {
        <ns0:sjConsultaCobranzas>
            <USER_NAME>{ upper-case(string($requestHeader/Authentication/UserName/text())) }</USER_NAME>
            <PASSWORD>{ data($requestHeader/Authentication/Password) }</PASSWORD>
            <SOURCE_BANK>{ data($requestHeader/Region/SourceBank/text()) }</SOURCE_BANK>
            <CUSTOMER_ID>{ data($consultaCobranzas/CUSTOMER_ID) }</CUSTOMER_ID>
            <SERVICES>
            {
            	for $service in $consultaCobranzas/SERVICES/SERVICE
            	return
            		<SERVICE>
	                    <ID>{ data($service/ID) }</ID>
	                    {
	                    	let $infoConvenio := $PT_INFOCONVENIOS/ns3:PT_INFOCONVENIOS_ITEM[ ns3:ID_SERVICIO = data($service/ID) ]
	                    	return(	                    	
	                    		let $contrato := string($infoConvenio/ns3:ID_CONTRATO/text())
	                    		return
	                    			if ( $contrato != '')then(
		                    			<CONTRACT_ID>{ $contrato }</CONTRACT_ID>
		                    		)else(),		                    		
		                    	let $descripcion := string($infoConvenio/ns3:DESCRIPCION/text())
		                    	return
		                    		if ( $descripcion != '')then(
		                    			<NAME>{ $descripcion }</NAME>
		                    		)else()
		                    )
	                    }
	                    <DEBTORS>{ $service/DEBTORS/@* , $service/DEBTORS/node() }</DEBTORS>
	                </SERVICE>
            }
            </SERVICES>
        </ns0:sjConsultaCobranzas>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $consultaCobranzas as element(ns2:consultaCobranzas) external;
declare variable $PT_INFOCONVENIOS as element() external;

xf:sjConsultaRecaudoH2HIn($requestHeader,
    $consultaCobranzas,
    $PT_INFOCONVENIOS)
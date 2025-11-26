xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$crearExtraResponse" element="ns1:CrearExtraResponse" location="../../../BusinessServices/External/SalesforceHNIngresaGestionExtra/wsdl/SalesforceHNIngresaGestionExtra.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$solicitaFinanciamientoTC" element="ns0:solicitaFinanciamientoTC" location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:solicitaFinanciamientoTCResponse" location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/solicitaFinanciamientoTCOut/";
declare namespace ns1 = "http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes";

declare function getMessageStatus($messageStatus as xs:string) 
	as xs:string{
			if (upper-case($messageStatus) = ("EN PROCESO","INGRESADA")) then ("PENDING") else
			if (upper-case($messageStatus) = "APROBADO") then ("APPROVED") else 
			"REJECTED"
	};

declare function xf:solicitaFinanciamientoTCOut($crearExtraResponse as element(ns1:CrearExtraResponse),
    $solicitaFinanciamientoTC as element(ns0:solicitaFinanciamientoTC))
    as element(ns0:solicitaFinanciamientoTCResponse) {
        <ns0:solicitaFinanciamientoTCResponse>
            {
                for $IdGestion in $crearExtraResponse/ns1:result/ns1:IdGestion
                return
                    <TRANSACTION_ID>{ concat($solicitaFinanciamientoTC/TRANSACTION_ID , $IdGestion) }</TRANSACTION_ID>
            }
            <AMOUNT_REQUESTED>{ data($solicitaFinanciamientoTC/TOTAL_AMOUNT) }</AMOUNT_REQUESTED>
            <NUMBER_OF_PAYMENTS>{ data($solicitaFinanciamientoTC/NUMBER_OF_PAYMENTS) }</NUMBER_OF_PAYMENTS>
            {
                for $cuotaMensual in $crearExtraResponse/ns1:result/ns1:cuotaMensual
                return
                    <MONTHLY_PAYMENT>{ data($cuotaMensual) }</MONTHLY_PAYMENT>
            }
            {
                for $tasaMensual in $crearExtraResponse/ns1:result/ns1:tasaMensual
                return
                    <MONTHLY_INTEREST_RATE>{ data($tasaMensual) }</MONTHLY_INTEREST_RATE>
            }
            <CURRENCY>{ data($solicitaFinanciamientoTC/CURRENCY) }</CURRENCY>
            <AVAILABLE_AMOUNT>
            {
                 $solicitaFinanciamientoTC/TOTAL_AMOUNT - sum( ($crearExtraResponse/ns1:result/ns1:valorSeguro, $crearExtraResponse/ns1:result/ns1:valorDesembolso))
            }
            </AVAILABLE_AMOUNT>
            <CHARGES>
				<CHARGE> 
                    <NAME>DISBURSEMENT</NAME>
                    
                    { 
                    	for $valorDesembolso in $crearExtraResponse/ns1:result/ns1:valorDesembolso
                		return
                    	<VALUE>{ data($valorDesembolso) }</VALUE>
					} 
                </CHARGE>
                <CHARGE>
                    <NAME>INSURANCE</NAME>
                    { 
                    	for $valorSeguro in $crearExtraResponse/ns1:result/ns1:valorSeguro
                		return
                    	<VALUE>{ data($valorSeguro) }</VALUE>
					}
				</CHARGE>
                <TOTAL>{ sum( ($crearExtraResponse/ns1:result/ns1:valorSeguro, $crearExtraResponse/ns1:result/ns1:valorDesembolso) ) }</TOTAL>
            </CHARGES>
            {
                for $estadoGestion in $crearExtraResponse/ns1:result/ns1:estadoGestion
                return
                    <STATUS>{ getMessageStatus(data($estadoGestion)) }</STATUS>
            }
        </ns0:solicitaFinanciamientoTCResponse>
};

declare variable $crearExtraResponse as element(ns1:CrearExtraResponse) external;
declare variable $solicitaFinanciamientoTC as element(ns0:solicitaFinanciamientoTC) external;

xf:solicitaFinanciamientoTCOut($crearExtraResponse,
    $solicitaFinanciamientoTC)
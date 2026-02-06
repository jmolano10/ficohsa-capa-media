xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$crearExtraResponse1" element="ns1:CrearExtraResponse" location="../../../BusinessServices/External/SalesforceRGNIngresaGestionExtra/wsdl/SalesforceRGNIngresaGestionExtra.wsdl" ::)
(:: pragma bea:global-element-parameter parameter="$solicitaFinanciamientoTC1" element="ns0:solicitaFinanciamientoTC" location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:solicitaFinanciamientoTCResponse" location="../../SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/solicitudFinanciamientoTCTypes";
declare namespace ns1 = "http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/solicitaFinanciamientoTCRGNIOut/";

declare function getMessageStatus($messageStatus as xs:string) 
	as xs:string{
			if (upper-case($messageStatus) = ("EN PROCESO","INGRESADA")) then ("PENDING") else
			if (upper-case($messageStatus) = "APROBADO") then ("APPROVED") else 
			"REJECTED"
	};

declare function xf:solicitaFinanciamientoTCRGNIOut($crearExtraResponse1 as element(ns1:CrearExtraResponse),
    $solicitaFinanciamientoTC1 as element(ns0:solicitaFinanciamientoTC))
    as element(ns0:solicitaFinanciamientoTCResponse) {
        <ns0:solicitaFinanciamientoTCResponse>
             <AMOUNT_REQUESTED>{ data($solicitaFinanciamientoTC1/TOTAL_AMOUNT) }</AMOUNT_REQUESTED>
             <NUMBER_OF_PAYMENTS>{ data($solicitaFinanciamientoTC1/NUMBER_OF_PAYMENTS) }</NUMBER_OF_PAYMENTS>
            {
                for $cuotaMensual in $crearExtraResponse1/ns1:result/ns1:cuotaMensual
                return
                    <MONTHLY_PAYMENT>{ data($cuotaMensual) }</MONTHLY_PAYMENT>
            }
            {
                for $tasaMensual in $crearExtraResponse1/ns1:result/ns1:tasaMensual
                return
                    <MONTHLY_INTEREST_RATE>{ data($tasaMensual) }</MONTHLY_INTEREST_RATE>
            }
            <CURRENCY>{ data($solicitaFinanciamientoTC1/CURRENCY) }</CURRENCY>
           <AVAILABLE_AMOUNT>
            {
                 $solicitaFinanciamientoTC1/TOTAL_AMOUNT - sum( ($crearExtraResponse1/ns1:result/ns1:valorSeguro, $crearExtraResponse1/ns1:result/ns1:valorDesembolso))
            }
            </AVAILABLE_AMOUNT>
            <CHARGES>
            	<CHARGE> 
                    <NAME>DISBURSEMENT</NAME>
                    { 
                    	for $valorDesembolso in $crearExtraResponse1/ns1:result/ns1:valorDesembolso
                		return
                    	<VALUE>{ data($valorDesembolso) }</VALUE>
					}
                </CHARGE>
                <CHARGE>
                    <NAME>INSURANCE</NAME>
                    { 
                    	for $valorSeguro in $crearExtraResponse1/ns1:result/ns1:valorSeguro
                		return
                    	<VALUE>{ data($valorSeguro) }</VALUE>
					}
				</CHARGE>
               <TOTAL>{sum(($crearExtraResponse1/ns1:result/ns1:valorDesembolso, $crearExtraResponse1/ns1:result/ns1:valorSeguro))}</TOTAL>
            </CHARGES>
            {
                for $estadoGestion in $crearExtraResponse1/ns1:result/ns1:estadoGestion
                return
                    <STATUS>{ getMessageStatus(data($estadoGestion)) }</STATUS>
            }
        </ns0:solicitaFinanciamientoTCResponse>
};

declare variable $crearExtraResponse1 as element(ns1:CrearExtraResponse) external;
declare variable $solicitaFinanciamientoTC1 as element(ns0:solicitaFinanciamientoTC) external;

xf:solicitaFinanciamientoTCRGNIOut($crearExtraResponse1,
    $solicitaFinanciamientoTC1)
(:: pragma bea:global-element-parameter parameter="$consultadelistanegraResponse1" element="ns0:ConsultadelistanegraResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadelistaPEPResponse1" element="ns0:ConsultadelistaPEPResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../../BusinessServices/consultarListaFatca/xsd/XMLSchema_-131806455.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadelistagrisResponse1" element="ns0:ConsultaListaGrisResponse" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns3:OutputParameters" location="../../../BusinessServices/consultaListaOFAC/xsd/consultaListaOFAC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadeclientesnoFATCAResponse" element="ns4:ConsultadeclientesnoFATCAResponse" location="../../../BusinessServices/T24/consultaClientesNoFATCA/xsd/XMLSchema_-531907416.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$RSPPartRelac" element="ns4:OutputParameters" location="../../../BusinessServices/ConsultaClientesPartesRelacionadas/xsd/consultaClientesPartesRelacionadas_sp.xsd" ::)

(:: pragma bea:global-element-return element="ns1:sjConsultaListasClienteResponse" location="../xsd/sjConsultaListasCliente.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaListasCliente";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaOFAC";
declare namespace ns4 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaClientesPartesRelacionadas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaListasCliente/xq/sjConsultaListasClienteOut2/";

declare function xf:sjConsultaListasClienteOut2($consultadelistanegraResponse1 as element(ns0:ConsultadelistanegraResponse),
    $consultadelistaPEPResponse1 as element(ns0:ConsultadelistaPEPResponse),
    $outputParameters1 as element(ns1:sjConsultaListasClienteResponse),
    $consultadelistagrisResponse1 as element(ns0:ConsultaListaGrisResponse),
    $outputParameters as element(ns3:OutputParameters),
    $consultadeclientesnoFATCAResponse as element(ns1:sjConsultaListasClienteResponse),
    $RSPPartRelac as element(ns4:OutputParameters))
    as element(ns1:sjConsultaListasClienteResponse) {
        <ns1:sjConsultaListasClienteResponse>
            <ns1:consultaListaClienteResponse>
                {
                    for $successIndicator in $consultadelistanegraResponse1/Status/successIndicator
                    return
                        <ns1:successIndicator>{ data($successIndicator) }</ns1:successIndicator>
                }
                {
                    for $messages in $consultadelistanegraResponse1/Status/messages
                    return
                        <ns1:messages>{ data($messages) }</ns1:messages>
                }
                <ns1:ASSOCIATION_NAME>BLACKLIST</ns1:ASSOCIATION_NAME>
                {
                    for $DOCNUMBER in $consultadelistanegraResponse1/WSFICOBLACKLISTDETType[1]/gWSFICOBLACKLISTDETDetailType/mWSFICOBLACKLISTDETDetailType[1]/DOCNUMBER
                    return
                        <ns1:CUSTOMER_ID>{ data($DOCNUMBER) }</ns1:CUSTOMER_ID>
                }
                {
                    let $CUSTNAME := fn:string($consultadelistanegraResponse1/WSFICOBLACKLISTDETType[1]/gWSFICOBLACKLISTDETDetailType/mWSFICOBLACKLISTDETDetailType[1]/CUSTNAME/text())
                    let $CUSTSURNAME := fn:string($consultadelistanegraResponse1/WSFICOBLACKLISTDETType[1]/gWSFICOBLACKLISTDETDetailType/mWSFICOBLACKLISTDETDetailType[1]/CUSTSURNAME/text())
                    return
                        <ns1:CUSTOMER_NAME>{ fn:normalize-space(fn:concat($CUSTNAME," ",$CUSTSURNAME)) }</ns1:CUSTOMER_NAME>
                }
            </ns1:consultaListaClienteResponse>
            <ns1:consultaListaClienteResponse>
                {
                    for $successIndicator in $consultadelistaPEPResponse1/Status/successIndicator
                    return
                        <ns1:successIndicator>{ data($successIndicator) }</ns1:successIndicator>
                }
                {
                    for $messages in $consultadelistaPEPResponse1/Status/messages
                    return
                        <ns1:messages>{ data($messages) }</ns1:messages>
                }
                <ns1:ASSOCIATION_NAME>PEP</ns1:ASSOCIATION_NAME>
                {
                    for $DOCUMENTNUMBER in $consultadelistaPEPResponse1/WSFICOPEPDETType[1]/gWSFICOPEPDetailType/mWSFICOPEPDETDetailType[1]/DOCUMENTNUMBER
                    return
                        <ns1:CUSTOMER_ID>{ data($DOCUMENTNUMBER) }</ns1:CUSTOMER_ID>
                }
                {
                    let $GIVENNAMES := fn:string($consultadelistaPEPResponse1/WSFICOPEPDETType[1]/gWSFICOPEPDETDetailType/mWSFICOPEPDETDetailType[1]/GIVENNAMES/text())
                    let $FAMILYNAME := fn:string($consultadelistaPEPResponse1/WSFICOPEPDETType[1]/gWSFICOPEPDETDetailType/mWSFICOPEPDETDetailType[1]/FAMILYNAME/text())
                    return
                        <ns1:CUSTOMER_NAME>{ fn:normalize-space(fn:concat($GIVENNAMES," ",$FAMILYNAME)) }</ns1:CUSTOMER_NAME>
                }
            </ns1:consultaListaClienteResponse> 
            <ns1:consultaListaClienteResponse>
	            
	            	<ns1:successIndicator>{ fn:string($outputParameters1/ns1:consultaListaClienteResponse/ns1:successIndicator/text()) }</ns1:successIndicator>
	            	{
	            	  for $messagesFatca in $outputParameters1/ns1:consultaListaClienteResponse/ns1:messages
	            	  return
	            		<ns1:messages>{ data($messagesFatca) }</ns1:messages>
	            	}
	            	<ns1:ASSOCIATION_NAME>FATCA</ns1:ASSOCIATION_NAME>
	            	<ns1:CUSTOMER_NAME>{ data($outputParameters1/ns1:consultaListaClienteResponse/ns1:CUSTOMER_NAME) }</ns1:CUSTOMER_NAME>
	            
            </ns1:consultaListaClienteResponse>   
            <ns1:consultaListaClienteResponse>
                {
                    for $successIndicator in $consultadelistagrisResponse1/Status/successIndicator
                    return
                        <ns1:successIndicator>{ data($successIndicator) }</ns1:successIndicator>
                }
                {
                    for $messages in $consultadelistagrisResponse1/Status/messages
                    return
                        <ns1:messages>{ data($messages) }</ns1:messages>
                }
                <ns1:ASSOCIATION_NAME>GRAYLIST</ns1:ASSOCIATION_NAME>
                {
                    for $IDENTNUMBER in $consultadelistagrisResponse1/WSFICOBUSCARGRAYLISTType[1]/gWSFICOBUSCARGRAYLISTDetailType/mWSFICOBUSCARGRAYLISTDetailType[1]/IDENTNUMBER
                    return
                        <ns1:CUSTOMER_ID>{ data($IDENTNUMBER) }</ns1:CUSTOMER_ID>
                }
                {
                    let $NAME := fn:string($consultadelistagrisResponse1/WSFICOBUSCARGRAYLISTType[1]/gWSFICOBUSCARGRAYLISTDetailType/mWSFICOBUSCARGRAYLISTDetailType[1]/NAME/text())
                    return
                        <ns1:CUSTOMER_NAME>{ fn:normalize-space($NAME) }</ns1:CUSTOMER_NAME>
                }
            </ns1:consultaListaClienteResponse>
            <ns1:consultaListaClienteResponse>
	            {
	            	<ns1:successIndicator>{ fn:string($outputParameters/ns3:RESPONSE_CODE/text()) }</ns1:successIndicator>,
	            	<ns1:messages>{ fn:string($outputParameters/ns3:RESPONSE_MESSAGE/text()) }</ns1:messages>,
	            	<ns1:ASSOCIATION_NAME>OFAC</ns1:ASSOCIATION_NAME>,
	            	<ns1:CUSTOMER_ID></ns1:CUSTOMER_ID>,
	            	<ns1:CUSTOMER_NAME>{ fn:string($outputParameters/ns3:ENTITY_NAME/text()) }</ns1:CUSTOMER_NAME>
	            }
            </ns1:consultaListaClienteResponse>   
            <ns1:consultaListaClienteResponse>
                {
                    for $successIndicator in $consultadeclientesnoFATCAResponse/ns1:consultaListaClienteResponse/ns1:successIndicator
                    return
                        <ns1:successIndicator>{ data($successIndicator) }</ns1:successIndicator>
                }
                {
                    for $messages in $consultadeclientesnoFATCAResponse/ns1:consultaListaClienteResponse/ns1:messages
                    return
                        <ns1:messages>{ data($messages) }</ns1:messages>
                }
                {
                	 for $ASSOCIATION_NAME in $consultadeclientesnoFATCAResponse/ns1:consultaListaClienteResponse/ns1:ASSOCIATION_NAME
                    	return
                    	 <ns1:ASSOCIATION_NAME>{ data($ASSOCIATION_NAME) }</ns1:ASSOCIATION_NAME>
                }
               
                {
                    for $DOCNUMBER in $consultadeclientesnoFATCAResponse/ns1:consultaListaClienteResponse/ns1:CUSTOMER_ID
                    return
                        <ns1:CUSTOMER_ID>{ data($DOCNUMBER) }</ns1:CUSTOMER_ID>
                }
                 {
                    for $CUSTOMER_NAME in $consultadeclientesnoFATCAResponse/ns1:consultaListaClienteResponse/ns1:CUSTOMER_NAME
                    return
                        <ns1:CUSTOMER_NAME>{ data($CUSTOMER_NAME) }</ns1:CUSTOMER_NAME>
                }
            </ns1:consultaListaClienteResponse>
            <ns1:consultaListaClienteResponse>
            	{
            		(
                    	if($RSPPartRelac/ns4:PV_RESPUESTA/text() != '')then(
                    		<ns1:successIndicator>SUCCESS</ns1:successIndicator>
            			)else(
            				<ns1:successIndicator></ns1:successIndicator>
            			)
            		),
	            	<ns1:messages>{ $RSPPartRelac/ns4:PV_RESPUESTA/text() }</ns1:messages>,
	            	<ns1:ASSOCIATION_NAME>RELPARTLIST</ns1:ASSOCIATION_NAME>,
	            	<ns1:CUSTOMER_ID></ns1:CUSTOMER_ID>,
	            	(
	            		if($RSPPartRelac/ns4:PV_RESPUESTA/text() = 'SI')then(
                    		<ns1:CUSTOMER_NAME>YES</ns1:CUSTOMER_NAME>
            			)else(
            				<ns1:CUSTOMER_NAME></ns1:CUSTOMER_NAME>
            			)
	            	)
	            }
            </ns1:consultaListaClienteResponse>                             
        </ns1:sjConsultaListasClienteResponse>
};

declare variable $consultadelistanegraResponse1 as element(ns0:ConsultadelistanegraResponse) external;
declare variable $consultadelistaPEPResponse1 as element(ns0:ConsultadelistaPEPResponse) external;
declare variable $outputParameters1 as element(ns1:sjConsultaListasClienteResponse) external;
declare variable $consultadelistagrisResponse1 as element(ns0:ConsultaListaGrisResponse) external;
declare variable $outputParameters as element(ns3:OutputParameters) external;
declare variable $RSPPartRelac as element(ns4:OutputParameters) external;
declare variable $consultadeclientesnoFATCAResponse as element(ns1:sjConsultaListasClienteResponse) external;

xf:sjConsultaListasClienteOut2($consultadelistanegraResponse1,
    $consultadelistaPEPResponse1,
    $outputParameters1,
    $consultadelistagrisResponse1,
    $outputParameters,
    $consultadeclientesnoFATCAResponse,
    $RSPPartRelac)
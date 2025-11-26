(:: pragma bea:global-element-parameter parameter="$consultaChequesPagadosTTResponse" element="ns0:ConsultaChequesPagadosTTResponse" location="../Resources/XMLSchema_516353548.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaChequesPagadosFTResponse" element="ns0:ConsultaChequesPagadosFTResponse" location="../Resources/XMLSchema_516353548.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/ConsultaChequesPagados/consultaChequesPagadosHeaderOut/";

declare function xf:consultaChequesPagadosHeaderOut($consultaChequesPagadosTTResponse as element(ns0:ConsultaChequesPagadosTTResponse),
    $consultaChequesPagadosFTResponse as element(ns0:ConsultaChequesPagadosFTResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        {
        	let $ZERORECORDSTT := fn:string($consultaChequesPagadosTTResponse/WSTTCHEQUESPRESENTEDType[1]/ZERORECORDS/text())
        	let $ZERORECORDSFT := fn:string($consultaChequesPagadosFTResponse/WSFTCHEQUESPRESENTEDType[1]/ZERORECORDS/text())
        	return
        		if( $ZERORECORDSTT = "" or $ZERORECORDSFT = "") then (
        			<successIndicator>Success</successIndicator>
        		) else (
        			<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ $ZERORECORDSTT }</messages>
        		)
        }
        </ns1:ResponseHeader>
};

declare variable $consultaChequesPagadosTTResponse as element(ns0:ConsultaChequesPagadosTTResponse) external;
declare variable $consultaChequesPagadosFTResponse as element(ns0:ConsultaChequesPagadosFTResponse) external;

xf:consultaChequesPagadosHeaderOut($consultaChequesPagadosTTResponse,
    $consultaChequesPagadosFTResponse)
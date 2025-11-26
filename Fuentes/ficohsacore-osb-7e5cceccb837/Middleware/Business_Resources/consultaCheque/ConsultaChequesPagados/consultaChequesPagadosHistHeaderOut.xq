xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaChequesPagadosTTHISResponse" element="ns0:ConsultaChequesPagadosTTHISResponse" location="../Resources/XMLSchema_516353548.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaChequesPagadosFTHISResponse" element="ns0:ConsultaChequesPagadosFTHISResponse" location="../Resources/XMLSchema_516353548.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/ConsultaChequesPagados/consultaChequesPagadosHistHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:consultaChequesPagadosHistHeaderOut($consultaChequesPagadosTTHISResponse as element(ns0:ConsultaChequesPagadosTTHISResponse),
    $consultaChequesPagadosFTHISResponse as element(ns0:ConsultaChequesPagadosFTHISResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        {
        	let $ZERORECORDSTT := fn:string($consultaChequesPagadosTTHISResponse/WSTTCHEQUESPRESENTEDHISType[1]/ZERORECORDS/text())
        	let $ZERORECORDSFT := fn:string($consultaChequesPagadosFTHISResponse/WSFTCHEQUESPRESENTEDHISType[1]/ZERORECORDS/text())
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

declare variable $consultaChequesPagadosTTHISResponse as element(ns0:ConsultaChequesPagadosTTHISResponse) external;
declare variable $consultaChequesPagadosFTHISResponse as element(ns0:ConsultaChequesPagadosFTHISResponse) external;

xf:consultaChequesPagadosHistHeaderOut($consultaChequesPagadosTTHISResponse,
    $consultaChequesPagadosFTHISResponse)
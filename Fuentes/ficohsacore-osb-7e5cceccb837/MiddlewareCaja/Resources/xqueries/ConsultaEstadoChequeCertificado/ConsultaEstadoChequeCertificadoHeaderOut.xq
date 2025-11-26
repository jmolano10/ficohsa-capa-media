(:: pragma bea:global-element-parameter parameter="$consultadechqcertificadoResponse" element="ns0:ConsultadechqcertificadoResponse" location="../../xsds/CertifCheque/XMLSchema_1194496794.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaEstadoChequeCertificado/ConsultaEstadoChequeCertificadoHeaderOut/";

declare function xf:ConsultaEstadoChequeCertificadoHeaderOut($consultadechqcertificadoResponse as element(ns0:ConsultadechqcertificadoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
        	{
        		let $zeroRecords := fn:string($consultadechqcertificadoResponse/FICOCERTCHQSTATUSType[1]/gFICOCERTCHQSTATUSDetailType/mFICOCERTCHQSTATUSDetailType[1]/CHEQUENUMBER/text())
        		let $successIndicator := fn:string($consultadechqcertificadoResponse/Status/successIndicator/text())
        		return
        			if ($zeroRecords = "") then (
        				<successIndicator>NO RECORDS</successIndicator>,
        				 <messages>0 Records Returned</messages>
        			) else (
        				<successIndicator>{ $successIndicator }</successIndicator>,
        				for $messages in $consultadechqcertificadoResponse/Status/messages
                		return
                    		<messages>{ data($messages) }</messages>
        			
        			)	
        	}
        </ns1:ResponseHeader>
};

declare variable $consultadechqcertificadoResponse as element(ns0:ConsultadechqcertificadoResponse) external;

xf:ConsultaEstadoChequeCertificadoHeaderOut($consultadechqcertificadoResponse)
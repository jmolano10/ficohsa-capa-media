(:: pragma bea:global-element-parameter parameter="$consultadechqcertificadoResponse" element="ns0:ConsultadechqcertificadoResponse" location="../../xsds/CertifCheque/XMLSchema_1194496794.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaEstadoChequeCertificadoResponse" location="../../xsds/ConsultaEstadoChequeCertificado/ConsultaEstadoChequeCertificado.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoChequeCertificadoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaEstadoChequeCertificado/ConsultaEstadoChequeCertificadoOut/";

declare function xf:ConsultaEstadoChequeCertificadoOut($consultadechqcertificadoResponse as element(ns0:ConsultadechqcertificadoResponse))
    as element(ns1:consultaEstadoChequeCertificadoResponse) {
    	let $successIndicator := fn:string($consultadechqcertificadoResponse/Status/successIndicator/text())
    	return
    		if ($successIndicator = "Success") then (
    			<ns1:consultaEstadoChequeCertificadoResponse>
		            <ns1:consultaEstadoChequeCertificadoResponseType>
		                <ns1:consultaEstadoChequeCertificadoResponseRecordType>
		                    {
		                        for $DEBITACCOUNTNO in $consultadechqcertificadoResponse/FICOCERTCHQSTATUSType[1]/gFICOCERTCHQSTATUSDetailType/mFICOCERTCHQSTATUSDetailType[1]/DEBITACCOUNTNO
		                        return
		                            <ACCOUNT_NUMBER>{ data($DEBITACCOUNTNO) }</ACCOUNT_NUMBER>
		                    }
		                    {
		                        for $CHEQUENUMBER in $consultadechqcertificadoResponse/FICOCERTCHQSTATUSType[1]/gFICOCERTCHQSTATUSDetailType/mFICOCERTCHQSTATUSDetailType[1]/CHEQUENUMBER
		                        return
		                            <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
		                    }
		                    {
		                        for $CURRENCY in $consultadechqcertificadoResponse/FICOCERTCHQSTATUSType[1]/gFICOCERTCHQSTATUSDetailType/mFICOCERTCHQSTATUSDetailType[1]/CURRENCY
		                        return
		                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
		                    }
		                    {
		                        for $BENEFICIARYNAME in $consultadechqcertificadoResponse/FICOCERTCHQSTATUSType[1]/gFICOCERTCHQSTATUSDetailType/mFICOCERTCHQSTATUSDetailType[1]/BENEFICIARYNAME
		                        return
		                            <BENEFICIARY_NAME>{ data($BENEFICIARYNAME) }</BENEFICIARY_NAME>
		                    }
		                    {
		                        for $CHEQUEAMT in $consultadechqcertificadoResponse/FICOCERTCHQSTATUSType[1]/gFICOCERTCHQSTATUSDetailType/mFICOCERTCHQSTATUSDetailType[1]/CHEQUEAMT
		                        return
		                            <AMOUNT>{ data($CHEQUEAMT) }</AMOUNT>
		                    }
		                    {
		                        for $CHEQUESTATUS in $consultadechqcertificadoResponse/FICOCERTCHQSTATUSType[1]/gFICOCERTCHQSTATUSDetailType/mFICOCERTCHQSTATUSDetailType[1]/CHEQUESTATUS
		                        return
		                            <STATUS>{ data($CHEQUESTATUS) }</STATUS>
		                    }
		                </ns1:consultaEstadoChequeCertificadoResponseRecordType>
		            </ns1:consultaEstadoChequeCertificadoResponseType>
	         	</ns1:consultaEstadoChequeCertificadoResponse>
			) else (
	       		<ns1:consultaEstadoChequeCertificadoResponse/>
	       	)
        
};

declare variable $consultadechqcertificadoResponse as element(ns0:ConsultadechqcertificadoResponse) external;

xf:ConsultaEstadoChequeCertificadoOut($consultadechqcertificadoResponse)
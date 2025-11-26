(:: pragma bea:global-element-parameter parameter="$consultadechqcertificadoResponse" element="ns0:ConsultadechqcertificadoResponse" location="../Resources/XMLSchema_1194496794.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaEstadoChequeCertificadoResponse" location="consultaEstadoChequeCertificadoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoChequeCertificadoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/ConsultaEstadoChequeCertificado/consultaEstadoChequeCertificadoOut/";

declare function xf:consultaEstadoChequeCertificadoOut($consultadechqcertificadoResponse as element(ns0:ConsultadechqcertificadoResponse))
    as element(ns1:consultaEstadoChequeCertificadoResponse) {
        <ns1:consultaEstadoChequeCertificadoResponse>
            <ns1:consultaEstadoChequeCertificadoResponseType>
                <ns1:consultaEstadoChequeCertificadoResponseRecordType>
                    {
                        for $DEBITACCTNO in $consultadechqcertificadoResponse/FICOCERTCHQSTATUSType[1]/gFICOCERTCHQSTATUSDetailType/mFICOCERTCHQSTATUSDetailType[1]/DEBITACCTNO
                        return
                            <ACCOUNT_NUMBER>{ data($DEBITACCTNO) }</ACCOUNT_NUMBER>
                    }
                    {
                        for $CHEQUENO in $consultadechqcertificadoResponse/FICOCERTCHQSTATUSType[1]/gFICOCERTCHQSTATUSDetailType/mFICOCERTCHQSTATUSDetailType[1]/CHEQUENO
                        return
                            <CHEQUE_NUMBER>{ data($CHEQUENO) }</CHEQUE_NUMBER>
                    }
                    {
                        for $CURRENCY in $consultadechqcertificadoResponse/FICOCERTCHQSTATUSType[1]/gFICOCERTCHQSTATUSDetailType/mFICOCERTCHQSTATUSDetailType[1]/CURRENCY
                        return
                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                    }
                    {
                        for $BENNAME in $consultadechqcertificadoResponse/FICOCERTCHQSTATUSType[1]/gFICOCERTCHQSTATUSDetailType/mFICOCERTCHQSTATUSDetailType[1]/BENNAME
                        return
                            <BENEFICIARY_NAME>{ data($BENNAME) }</BENEFICIARY_NAME>
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
};

declare variable $consultadechqcertificadoResponse as element(ns0:ConsultadechqcertificadoResponse) external;

xf:consultaEstadoChequeCertificadoOut($consultadechqcertificadoResponse)
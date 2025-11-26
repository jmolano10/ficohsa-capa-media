(:: pragma bea:global-element-parameter parameter="$solicituddechequeraResponse1" element="ns0:SolicituddechequeraResponse" location="../Resources/XMLSchema_21306858.xsd" ::)
(:: pragma bea:global-element-return element="ns1:solicitudChequerasResponse" location="solicitudChequerasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudChequerasTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/solicitudChequeras/SolicitudChequeras/solicitudChequerasOut/";

declare function xf:solicitudChequerasOut($solicituddechequeraResponse1 as element(ns0:SolicituddechequeraResponse))
    as element(ns1:solicitudChequerasResponse) {
        <ns1:solicitudChequerasResponse>
            <ns1:solicitudChequerasResponseType>
                <ns1:solicitudChequerasResponseRecordType>
                    <ACCOUNT_NUMBER>{ data($solicituddechequeraResponse1/FICOHCHECKBOOKREQUESTType/ACCOUNTNUMBER) }</ACCOUNT_NUMBER>
                    <DESTINATION_BRANCH>{ data($solicituddechequeraResponse1/FICOHCHECKBOOKREQUESTType/DESTINAGENCYCODE) }</DESTINATION_BRANCH>
                    <CHEQUEBOOK_TYPE>{ data($solicituddechequeraResponse1/FICOHCHECKBOOKREQUESTType/CHEQUETYPEID) }</CHEQUEBOOK_TYPE>
                    <NO_OF_BOOKS>{ data($solicituddechequeraResponse1/FICOHCHECKBOOKREQUESTType/NOOFBOOKS) }</NO_OF_BOOKS>
                    <FIRST_CHEQUE_NUMBER>{ data($solicituddechequeraResponse1/FICOHCHECKBOOKREQUESTType/CHEQUENOSTART) }</FIRST_CHEQUE_NUMBER>
                    <LAST_CHEQUE_NUMBER>{ data($solicituddechequeraResponse1/FICOHCHECKBOOKREQUESTType/CHEQUENOEND) }</LAST_CHEQUE_NUMBER>
                    <AUTHORIZED_CLAIMER>{ data($solicituddechequeraResponse1/FICOHCHECKBOOKREQUESTType/CLAIMPERSON) }</AUTHORIZED_CLAIMER>
                    <DATE_TIME>{ data($solicituddechequeraResponse1/FICOHCHECKBOOKREQUESTType/gDATETIME/DATETIME[1]) }</DATE_TIME>
                </ns1:solicitudChequerasResponseRecordType>
            </ns1:solicitudChequerasResponseType>
        </ns1:solicitudChequerasResponse>
};

declare variable $solicituddechequeraResponse1 as element(ns0:SolicituddechequeraResponse) external;

xf:solicitudChequerasOut($solicituddechequeraResponse1)
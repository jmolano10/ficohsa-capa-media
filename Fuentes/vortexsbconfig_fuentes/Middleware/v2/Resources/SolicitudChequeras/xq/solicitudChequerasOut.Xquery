<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$solicituddechequeraResponse1" element="ns0:SolicituddechequeraResponse" location="../../../../Business_Resources/solicitudChequeras/Resources/XMLSchema_21306858.xsd" ::)
(:: pragma bea:global-element-return element="ns1:solicitudChequerasResponse" location="../xsd/solicitudChequerasTypes.xsd" ::)

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

xf:solicitudChequerasOut($solicituddechequeraResponse1)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/solicitudChequeras/Resources/XMLSchema_21306858.xsd">
        <con:schema ref="Middleware/Business_Resources/solicitudChequeras/Resources/XMLSchema_21306858"/>
    </con:dependency>
    <con:dependency location="../xsd/solicitudChequerasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/SolicitudChequeras/xsd/solicitudChequerasTypes"/>
    </con:dependency>
</con:xqueryEntry>